//
//  ZHNewsTableViewCell.m
//  ZHNews
//
//  Created by guyuexing on 16/6/7.
//  Copyright © 2016年 neu. All rights reserved.
//

#import "ZHNewsTableViewCell.h"
#import <UIImageView+WebCache.h>

@interface ZHNewsTableViewCell ()

@property (weak, nonatomic) IBOutlet UIImageView *iconView;

@property (weak, nonatomic) IBOutlet UILabel *titleLbl;

@property (weak, nonatomic) IBOutlet UILabel *subTitleLbl;

@property (strong, nonatomic) IBOutletCollection(UIImageView) NSArray *imageArray;

@end


@implementation ZHNewsTableViewCell

-(void)setModel:(ZHNewsModel *)model{

    _model = model;
    
    [_iconView sd_setImageWithURL:[NSURL URLWithString:model.imgsrc] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        _iconView.image = image;
    }];
    
    _titleLbl.text = model.title;
    _subTitleLbl.text = model.digest;
    
    

}


@end
