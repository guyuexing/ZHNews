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
    
    [_iconView sd_setImageWithURL:[NSURL URLWithString:model.imgsrc]];
    _titleLbl.text = model.title;
    _subTitleLbl.text = model.digest;
    
    if (model.imgextra.count == 2) {
        for (NSInteger i = 0; i < model.imgextra.count; i++) {
            NSDictionary *dict = model.imgextra[i];
            NSURL *url = [NSURL URLWithString:dict[@"imgsrc"]];
            [self.imageArray[i] sd_setImageWithURL:url];
        }
    }
}


@end
