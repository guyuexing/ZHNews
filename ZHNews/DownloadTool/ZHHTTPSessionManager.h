//
//  ZHHTTPSessionManager.h
//  ZHNews
//
//  Created by guyuexing on 16/6/7.
//  Copyright © 2016年 neu. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>

typedef void(^FinishBlock)(NSDictionary *dict);

@interface ZHHTTPSessionManager : AFHTTPSessionManager

@property (nonatomic,copy) NSString *URLString;

+ (instancetype)shareManager;

- (void)downloadDataWithPathWithPath:(NSString *)URLPath andComplete:(FinishBlock)finishBlock;

@end
