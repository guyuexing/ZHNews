//
//  ZHHTTPSessionManager.m
//  ZHNews
//
//  Created by guyuexing on 16/6/7.
//  Copyright © 2016年 neu. All rights reserved.
//

#import "ZHHTTPSessionManager.h"

@implementation ZHHTTPSessionManager

static ZHHTTPSessionManager *_instance;


#ifdef DEBUG
static NSString *baseURLString = @"http://c.m.163.com/";
#else
static NSString *baseURLString = @"http://c.m.163.com/";
#endif
//MARK: - 工具类单例模式
+(instancetype)shareManager{

    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[self alloc] init];
       
    });
    return _instance;
}

- (void)downloadDataWithPathWithPath:(NSString *)URLPath andComplete:(FinishBlock)finishBlock{
    
     self.responseSerializer.acceptableContentTypes = [self.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
    
    [self GET:URLPath parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        if (finishBlock) {
            finishBlock(responseObject);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];

}


@end
