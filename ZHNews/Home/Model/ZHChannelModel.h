//
//  ZHChannelModel.h
//  ZHNews
//
//  Created by guyuexing on 16/6/7.
//  Copyright © 2016年 neu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZHChannelModel : NSObject

@property (nonatomic,copy) NSString *tid;

@property (nonatomic,copy) NSString *tname;

//新闻的服务器地址
@property (nonatomic,copy) NSString *URLString;


+ (NSArray *)setChannelData;

@end
