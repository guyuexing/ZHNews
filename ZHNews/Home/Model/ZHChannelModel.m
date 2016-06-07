//
//  ZHChannelModel.m
//  ZHNews
//
//  Created by guyuexing on 16/6/7.
//  Copyright © 2016年 neu. All rights reserved.
//

#import "ZHChannelModel.h"

@implementation ZHChannelModel

+(instancetype)channelWithDict:(NSDictionary *)dict{
    //字典转模型
    id obj = [[self alloc] init];
    [obj setValuesForKeysWithDictionary:dict];
    return obj;
}

//防止字典中没有转换的key值引起崩溃
-(void)setValue:(id)value forUndefinedKey:(NSString *)key{

}

-(NSString *)description{

    return [NSString stringWithFormat:@"%@-%@",self.tid,self.tname];

}

+ (NSArray *)setChannelData{

    //加载bundle文件
    NSString *path = [[NSBundle mainBundle] pathForResource:@"topic_news.json" ofType:nil];
    NSData *data = [NSData dataWithContentsOfFile:path];
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:0 error:NULL];
    
    //字典转模型
    NSArray *dataArr = dict[@"tList"];
    NSMutableArray *channelArrM = [NSMutableArray array];
    for (NSDictionary *dict in dataArr) {
        [channelArrM addObject:[self channelWithDict:dict]];
    }
    //对数组中内容按照tid属性进行排序
    [channelArrM sortUsingComparator:^NSComparisonResult(ZHChannelModel * obj1, ZHChannelModel * obj2) {
       return  [obj1.tid compare:obj2.tid];
    }];

    return channelArrM.copy;
}

@end
