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

@interface ZHNewsViewController ()<UICollectionViewDataSource,UICollectionViewDelegate>

//频道
@property (weak, nonatomic) IBOutlet UIScrollView *channelView;

//保存模型的数组
@property (nonatomic,strong) NSArray <ZHChannelModel *>*channelArr;

//展示新闻的CollectionView界面
@property (weak, nonatomic) IBOutlet UICollectionView *newsCollectionView;

//流布局
@property (weak, nonatomic) IBOutlet UICollectionViewFlowLayout *newsCollectionFlowLayout;


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

    CGFloat itemW = [UIScreen mainScreen].bounds.size.width;
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
    for (NSInteger i = 0; i < self.channelArr.count; i++) {
        ZHChannelLabel *chanLbl = [[ZHChannelLabel alloc] init];
        chanLbl.text = self.channelArr[i].tname;
        CGFloat chanLblX = i*chanLblW;
        chanLbl.frame = CGRectMake(chanLblX, chanLblY, chanLblW, chanLblH);
        chanLbl.backgroundColor =  [UIColor colorWithRed:((float)arc4random_uniform(256) / 255.0) green:((float)arc4random_uniform(256) / 255.0) blue:((float)arc4random_uniform(256) / 255.0) alpha:1.0];
        [self.channelView addSubview:chanLbl];
    }
    self.channelView.contentSize = CGSizeMake(chanLblW * self.channelArr.count, 0);
}

#pragma mark - UICollectionView的数据源方法
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.channelArr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    ZHNewsCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"newsItem" forIndexPath:indexPath];
    ZHChannelModel *channelModel = self.channelArr[indexPath.item];
    
    //根据频道的tid来确定服务器地址
    if ([channelModel.tid isEqualToString:@"T1348647853363"]) {
        cell.URLStirng = [NSString stringWithFormat:@"http://c.m.163.com/nc/article/headline/%@/0-20.html",channelModel.tid];
    }else{
        cell.URLStirng = [NSString stringWithFormat:@"http://c.m.163.com/nc/article/list/%@/0-20.html",channelModel.tid];
    }
    return cell;

}

@end
