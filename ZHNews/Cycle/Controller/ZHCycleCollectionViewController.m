//
//  ZHCycleCollectionViewController.m
//  ZHNews
//
//  Created by guyuexing on 16/6/8.
//  Copyright © 2016年 neu. All rights reserved.
//

#import "ZHCycleCollectionViewController.h"
#import "ZHCycleModel.h"
#import "ZHCycleCollectionViewCell.h"
#define KImageCount 4

@interface ZHCycleCollectionViewController ()<UIScrollViewDelegate>

@property (nonatomic,strong) NSArray *cycleDataArr;

@property (weak, nonatomic) IBOutlet UICollectionViewFlowLayout *cycleFlowLayout;

@property (nonatomic,strong) NSTimer *timer;

@property (nonatomic,strong) NSIndexPath *indexPath;

@end

@implementation ZHCycleCollectionViewController

static NSString * const reuseIdentifier = @"Cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.cycleFlowLayout.itemSize = CGSizeMake([UIScreen mainScreen].bounds.size.width, 250);
    self.collectionView.showsHorizontalScrollIndicator = NO;
    self.collectionView.showsVerticalScrollIndicator = NO;
    self.collectionView.backgroundColor = [UIColor whiteColor];
    [self setCycleData];
}

- (void)setCycleData{
    __weak typeof(self) weakSelf = self;
    [ZHCycleModel cycleDataWithURL:@"http://c.m.163.com/nc/ad/headline/0-4.html" andComplete:^(NSArray *dataArr) {
        weakSelf.cycleDataArr = dataArr;
        [weakSelf.collectionView reloadData];
        [weakSelf.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:1] atScrollPosition:UICollectionViewScrollPositionLeft animated:NO];
        [weakSelf timer];
    }];
}

-(NSTimer *)timer{
    if (_timer == nil) {
        _timer = [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(nextPage) userInfo:nil repeats:YES];
        [[NSRunLoop currentRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
    }
    return _timer;
}

#pragma mark - 图片无限轮播
/*
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{

    int offsetValue = (int)scrollView.contentOffset.x / scrollView.bounds.size.width;
    //组别
    int groupCount = offsetValue / 4;
    if (groupCount == 1) return;
    //组内每一个item号
    int itemCount = offsetValue % 4;
    //NSLog(@"%zd---组%zd-%zd",offsetValue,groupCount,itemCount);
    NSIndexPath *indexPath = [NSIndexPath indexPathForItem:itemCount inSection:1];
    [self.collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionRight animated:NO];
}

- (void)nextPage{
    NSIndexPath *indexPath = [[self.collectionView indexPathsForVisibleItems] lastObject];
    if (indexPath.item != KImageCount-1) {
       // NSLog(@"%zd",indexPath.item);
        indexPath = [NSIndexPath indexPathForRow:indexPath.item+1 inSection:1];
    }else{
        indexPath = [NSIndexPath indexPathForRow:0 inSection:2];
    }
    NSLog(@"=====%zd",indexPath.section);
    [self.collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionLeft animated:YES];
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
    [self scrollViewStop];
}

- (void)scrollViewStop{
    NSIndexPath *indexPath = [self.collectionView indexPathsForVisibleItems].lastObject;
    NSLog(@"------%zd",indexPath.section);
    if (indexPath.section == 1) return;
    NSIndexPath *index = [NSIndexPath indexPathForItem:indexPath.item inSection:1];
    [self.collectionView scrollToItemAtIndexPath:index atScrollPosition:UICollectionViewScrollPositionLeft animated:NO];
}

*/

- (void)nextPage {
    
    // 获取当前界面上看到cell的索引
    NSIndexPath *indexPath = [[self.collectionView indexPathsForVisibleItems] lastObject];
    // 如果当前不是最后一页就让它跳到下一页
    if (indexPath.item != KImageCount - 1) { // 如果不是最后一页
        self.indexPath = [NSIndexPath indexPathForItem:indexPath.item + 1 inSection:1];
        // 如果当前是第1组的最后一页了,我们继续让它走到第2组的第0
    } else {
        self.indexPath = [NSIndexPath indexPathForItem:0 inSection:2];
    }
    
    // 动画去滚动cell
    [self.collectionView scrollToItemAtIndexPath:self.indexPath atScrollPosition:UICollectionViewScrollPositionLeft animated:YES];
}

// 自动动画滚动停下来之后会来调用一次"而且也必须开启了动画才会调用此方法"
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    
    [self scrollViewStop];
    
}
// 当滚动停下来之后做一些判断
- (void)scrollViewStop {
    //NSIndexPath *indexPath = [[self.collectionView indexPathsForVisibleItems] lastObject];
    
    // 如果是在中间这一组的滚动就直接返回不走下面的滚动,只有不在第1组的时间才去不加动画的回到中间这一组
    if (self.indexPath.section == 1) return;
    
    
    // 创建一个新的索引,让它回到中间组所对应当前显示图片的cell
    NSIndexPath *index = [NSIndexPath indexPathForItem:self.indexPath.item inSection:1];
    
    [self.collectionView scrollToItemAtIndexPath:index atScrollPosition:UICollectionViewScrollPositionLeft animated:NO];
}

//将要开始拖拽"用户拖拽时就把定时器停止"
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    // 停止定时器,当定时器一停止就不能再开启了,只能重新创建一个新的定时器
    [self.timer invalidate];
    self.timer = nil;
}

// 当用户停止拖拽时会来调用一次此方法,但是停止拖拽不代表,停止了滚动
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    if (decelerate == NO) { // 没有降速的过程,直接在此方法中去添加定时器
        [self timer];
    }
    
}
// 手动去拖拽停下来之后就会业调用此方法
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
//    NSLog(@"---");
    // 添加定时器"如果有降速过程让滚动完全停下来之后再去添加定时器"
    [self timer];
    
    
    [self scrollViewStop];
    
    
}

#pragma mark - 数据源方法
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 3;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{

    return self.cycleDataArr.count;
    
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    ZHCycleCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cycleCell" forIndexPath:indexPath];
    cell.model = self.cycleDataArr[indexPath.row];
    return cell;
}

@end
