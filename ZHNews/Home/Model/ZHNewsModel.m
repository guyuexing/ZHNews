//
//  ZHNewsModel.m
//  ZHNews
//
//  Created by guyuexing on 16/6/7.
//  Copyright © 2016年 neu. All rights reserved.
//

#import "ZHNewsModel.h"
#import "ZHHTTPSessionManager.h"


@implementation ZHNewsModel

+ (void)newsModelWithPath:(NSString *)downloadPath andFinish:(CompleteBlock)completeBlock{

    NSMutableArray *dataArrM = [NSMutableArray array];
    [[ZHHTTPSessionManager manager] downloadDataWithPathWithPath:downloadPath andComplete:^(id obj) {
        NSDictionary *dict = (NSDictionary *)obj;
        NSString *key = dict.allKeys.lastObject;
        NSArray *array = dict[key];
        for (NSDictionary *dataDict in array) {
            ZHNewsModel *model = [self modelWithDict:dataDict];
            [dataArrM addObject:model];
        }
       
        if (completeBlock) {
            completeBlock(dataArrM.copy);
        }
    }];
    
}

+ (instancetype)modelWithDict:(NSDictionary *)dict{

    ZHNewsModel *model = [[self alloc] init];
    [model setValuesForKeysWithDictionary:dict];
    return model;
}

-(void)setValue:(id)value forUndefinedKey:(NSString *)key{

}


@end
