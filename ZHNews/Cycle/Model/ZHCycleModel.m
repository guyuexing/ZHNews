//
//  ZHCycleModel.m
//  ZHNews
//
//  Created by guyuexing on 16/6/8.
//  Copyright © 2016年 neu. All rights reserved.
//

#import "ZHCycleModel.h"
#import "ZHHTTPSessionManager.h"

@implementation ZHCycleModel

+(instancetype)cycleDataWithDict:(NSDictionary *)dict{
    ZHCycleModel *model = [[self alloc] init];
    [model setValuesForKeysWithDictionary:dict];
    return model;
}

-(void)setValue:(id)value forUndefinedKey:(NSString *)key{}

+ (void)cycleDataWithURL:(NSString *)URLString andComplete:(CycleDataBlock)cycleDataBlock{

    [[ZHHTTPSessionManager shareManager] GET:URLString parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dict = (NSDictionary *)responseObject;
        NSString *key = dict.allKeys.lastObject;
        NSArray *dataArr = dict[key];
        
        NSMutableArray *dataArrM = [NSMutableArray array];
        for (NSDictionary *dataDict in dataArr) {
            [dataArrM addObject:[ZHCycleModel cycleDataWithDict:dataDict]];
        }
        if (cycleDataBlock) {
            cycleDataBlock(dataArrM.copy);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error.localizedDescription);
    }];
    
}

@end
