//
//  ZHNewsViewController.m
//  ZHNews
//
//  Created by guyuexing on 16/6/7.
//  Copyright © 2016年 neu. All rights reserved.
//

#import "ZHNewsViewController.h"
#import "ZHChannelModel.h"
#import "ZHChannelLabel.h"
#import "ZHNewsCollectionViewCell.h"
#define kScreenWidth [UIScreen mainScreen].bounds.size.width

@interface ZHNewsViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UIScrollViewDelegate>

//频道
@property (weak, nonatomic) IBOutlet UIScrollView *channelView;

//保存模型的数组
@property (nonatomic,strong) NSArray <ZHChannelModel *>*channelArr;

//展示新闻的CollectionView界面
@property (weak, nonatomic) IBOutlet UICollectionView *newsCollectionView;

//流布局
@property (weak, nonatomic) IBOutlet UICollectionViewFlowLayout *newsCollectionFlowLayout;

//保存所有的频道
@property (nonatomic,strong) NSMutableArray<ZHChannelLabel *> *channelLabelArr;

//保存点击的当前频道
@property (nonatomic,strong) ZHChannelLabel *currentChannel;

@end

@implementation ZHNewsViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    //MARK: - 不让channelScrollView的contentInset Top增加64
    self.automaticallyAdjustsScrollViewInsets = NO;
    //设置滚动频道的UI
    [self setupChannelView];
    [self setupNewsCollectionItem];

}

#pragma mark - 设置UICollectionCell的属性
- (void)setupNewsCollectionItem{

    CGFloat itemW = kScreenWidth;
    CGFloat itemH = [UIScreen mainScreen].bounds.size.height - 64 - 44;
    self.newsCollectionFlowLayout.itemSize = CGSizeMake(itemW, itemH);
    self.newsCollectionView.pagingEnabled = YES;
}

#pragma mark - 设置channelView上的频道
- (void)setupChannelView{
    
    self.channelArr = [ZHChannelModel setChannelData];
    CGFloat chanLblY = 0;
    CGFloat chanLblW = 80;
    CGFloat chanLblH = 44;
    
    self.channelLabelArr = [NSMutableArray array];
    for (NSInteger i = 0; i < self.channelArr.count; i++) {
        ZHChannelLabel *chanLbl = [[ZHChannelLabel alloc] init];
        chanLbl.text = self.channelArr[i].tname;
        CGFloat chanLblX = i*chanLblW;
        chanLbl.frame = CGRectMake(chanLblX, chanLblY, chanLblW, chanLblH);
        [self.channelView addSubview:chanLbl];
        
        if (i == 0) {
            chanLbl.scale = 1;
        }
        
        //MARK: - 新闻页面滚动相关
        [self.channelLabelArr addObject:chanLbl];
        chanLbl.userInteractionEnabled = YES;
        chanLbl.tag = i;
        UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(channelClick:)];
        [chanLbl addGestureRecognizer:gesture];
    }
    self.channelView.contentSize = CGSizeMake(chanLblW * self.channelArr.count, 0);
}

#pragma mark - 点击频道，新闻的TableView会跳转与之对应
- (void)channelClick:(UITapGestureRecognizer *)gesture{

    ZHChannelLabel *currentLbl = (ZHChannelLabel *)gesture.view;
    self.currentChannel = currentLbl;
    NSIndexPath *indexPath = [NSIndexPath indexPathForItem:currentLbl.tag inSection:0];
    [self.newsCollectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionLeft animated:NO];
    [self channelScrollToCenter];
}
#pragma mark - 拖动CollectionView让频道随之滚动
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{

    NSInteger currentPage = scrollView.contentOffset.x/kScreenWidth;
    self.currentChannel = self.channelLabelArr[currentPage];
    [self channelScrollToCenter];

}

#pragma mark - 点击频道后让点击的频道滚动到中间位置
-(void)channelScrollToCenter{

    CGFloat needsScrollInstance = self.currentChannel.center.x - self.channelView.bounds.size.width/2;
    CGFloat maxScrollInstance = self.channelView.contentSize.width - kScreenWidth;
    if (needsScrollInstance <= 0) {
        needsScrollInstance = 0;
    }else if (needsScrollInstance >= maxScrollInstance){
        needsScrollInstance = maxScrollInstance;
    }
    [self.channelView setContentOffset:CGPointMake(needsScrollInstance, 0) animated:YES];
    
    //点击频道后让被点击的频道变大变红，其余的恢复原样
    for (ZHChannelLabel *channelLable in self.channelLabelArr) {
        if (channelLable == self.currentChannel) {
            channelLable.scale = 1.0;
        }else{
            channelLable.scale = 0.0;
        }
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    //获取滚动到哪一个频道,如果是第一个频道或最后一个频道就直接返回
    CGFloat offsetRate = scrollView.contentOffset.x/kScreenWidth;
    if (offsetRate < 0 || offsetRate > self.channelLabelArr.count-1) return;
    //计算左边频道的索引
    int leftIndex = (int)scrollView.contentOffset.x/kScreenWidth;
    //计算右边频道的索引
    int rightIndex = leftIndex + 1;
    //右边频道的缩放比例
    CGFloat rightRadio = offsetRate - leftIndex;
    //左边频道的缩放比例
    CGFloat leftRadio = 1-rightRadio;
    
    self.channelLabelArr[leftIndex].scale = leftRadio;
    if (leftIndex<self.channelLabelArr.count-1) {
        self.channelLabelArr[rightIndex].scale = rightRadio;

    }
    
    //NSLog(@"%f--%f--%f",offsetRate,rightRadio,leftRadio);
}

#pragma mark - 改变频道的字体大小和颜色
- (void)changeChannelSizeAndColor{

   

}

#pragma mark - UICollectionView的数据源方法
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.channelArr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    ZHNewsCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"newsItem" forIndexPath:indexPath];
    ZHChannelModel *channelModel = self.channelArr[indexPath.item];
    
    cell.URLStirng = channelModel.URLString;
    return cell;

}

@end
