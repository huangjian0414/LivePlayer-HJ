//
//  HJCollectionCellModel.m
//  LivePlayer-HJ
//
//  Created by huangjian on 17/2/28.
//  Copyright © 2017年 huangjian. All rights reserved.
//

#import "HJCollectionCellModel.h"
#import "MJExtension.h"
@implementation HJCollectionCellModel
+ (NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{@"ID" : @"id"
             };
}
@end
