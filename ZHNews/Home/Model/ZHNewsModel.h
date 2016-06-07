//
//  ZHNewsModel.h
//  ZHNews
//
//  Created by guyuexing on 16/6/7.
//  Copyright © 2016年 neu. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^CompleteBlock)(NSArray *dataArr);

@interface ZHNewsModel : NSObject

// 标题
@property (nonatomic, copy) NSString *title;
// 摘要
@property (nonatomic, copy) NSString *digest;
// 图片
@property (nonatomic, copy) NSString *imgsrc;
// 跟贴数
@property (nonatomic, assign) int replyCount;
// 多张配图
@property (nonatomic, strong) NSArray *imgextra;
// 大图标记
@property (nonatomic, assign) BOOL imgType;

+ (void)newsModelWithPath:(NSString *)downloadPath andFinish:(CompleteBlock)completeBlock;

+ (instancetype)modelWithDict:(NSDictionary *)dict;

@end
