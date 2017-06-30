//
//  HJGameCellModel.m
//  LivePlayer-HJ
//
//  Created by huangjian on 17/3/3.
//  Copyright © 2017年 huangjian. All rights reserved.
//

#import "HJGameCellModel.h"
#import "MJExtension.h"
@implementation HJGameCellModel

+(NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{@"ID" : @"id"
             };
}
@end
