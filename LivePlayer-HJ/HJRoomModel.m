//
//  HJRoomModel.m
//  LivePlayer-HJ
//
//  Created by huangjian on 17/2/27.
//  Copyright © 2017年 huangjian. All rights reserved.
//

#import "HJRoomModel.h"
#import "MJExtension.h"
@implementation HJRoomModel

+ (NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{@"ID" : @"id"
             };
}

@end
