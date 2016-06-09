//
//  ZHCycleModel.h
//  ZHNews
//
//  Created by guyuexing on 16/6/8.
//  Copyright © 2016年 neu. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^CycleDataBlock)(NSArray *dataArr);

@interface ZHCycleModel : NSObject

@property (nonatomic,copy) NSString *title;

@property (nonatomic,copy) NSString *imgsrc;

+(instancetype)cycleDataWithDict:(NSDictionary *)dict;

+ (void)cycleDataWithURL:(NSString *)URLString andComplete:(CycleDataBlock)cycleDataBlock;

@end
