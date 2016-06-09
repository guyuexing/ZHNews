//
//  ZHCycleCollectionViewCell.m
//  ZHNews
//
//  Created by guyuexing on 16/6/8.
//  Copyright © 2016年 neu. All rights reserved.
//

#import "ZHCycleCollectionViewCell.h"
#import <UIImageView+AFNetworking.h>

@interface ZHCycleCollectionViewCell ()

@property (weak, nonatomic) IBOutlet UIImageView *iconView;

@property (weak, nonatomic) IBOutlet UILabel *titleLbl;

@end

@implementation ZHCycleCollectionViewCell

-(void)setModel:(ZHCycleModel *)model{

    _model = model;
    [self.iconView setImageWithURL:[NSURL URLWithString:model.imgsrc]];
    self.titleLbl.text = model.title;

}

@end
