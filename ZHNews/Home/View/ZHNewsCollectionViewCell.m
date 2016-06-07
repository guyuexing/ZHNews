//
//  ZHNewsCollectionViewCell.m
//  ZHNews
//
//  Created by guyuexing on 16/6/7.
//  Copyright © 2016年 neu. All rights reserved.
//

#import "ZHNewsCollectionViewCell.h"
#import "ZHNewsTableViewController.h"

@interface ZHNewsCollectionViewCell ()

@property (nonatomic,strong) ZHNewsTableViewController *newsTableVc;

@end

@implementation ZHNewsCollectionViewCell

-(void)awakeFromNib{
    //MARK: - 根据创建的storyBoard加载控制器的根视图
    UIStoryboard *newsStoryBoard = [UIStoryboard storyboardWithName:@"NewsTableStoryboard" bundle:nil];
    ZHNewsTableViewController *newsTableVc = [newsStoryBoard instantiateViewControllerWithIdentifier:@"newsTable"];
    newsTableVc.tableView.frame = self.bounds;
    self.newsTableVc = newsTableVc;
    [self.contentView addSubview:newsTableVc.tableView];
    
}

-(void)setURLStirng:(NSString *)URLStirng{

    _URLStirng = URLStirng;
    self.newsTableVc.URLString = URLStirng;

}


@end
