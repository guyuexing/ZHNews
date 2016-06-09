//
//  ZHChannelLabel.m
//  ZHNews
//
//  Created by guyuexing on 16/6/7.
//  Copyright © 2016年 neu. All rights reserved.
//

#import "ZHChannelLabel.h"

@implementation ZHChannelLabel

-(instancetype)initWithFrame:(CGRect)frame{
    if ([super initWithFrame:frame]) {
        self.textAlignment = NSTextAlignmentCenter;
    }
    return self;
}

-(void)setScale:(CGFloat)scale{
    _scale = scale;
    
    self.textColor =  [UIColor colorWithRed:scale green:0 blue:0 alpha:1.0];
    CGFloat titleSizeRatio = 0.8 + 0.2*scale;
    
    self.transform = CGAffineTransformMakeScale(titleSizeRatio, titleSizeRatio);
}

@end
