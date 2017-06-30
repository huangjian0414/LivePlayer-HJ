//
//  HJHomeSectionModel.m
//  LivePlayer-HJ
//
//  Created by huangjian on 17/2/28.
//  Copyright © 2017年 huangjian. All rights reserved.
//

#import "HJHomeSectionModel.h"
#import "MJExtension.h"
@implementation HJHomeSectionModel

+ (NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{@"ID" : @"id"
             };
}

+(NSDictionary *)mj_objectClassInArray
{
    return @{@"lists":@"HJCollectionCellModel"};
}
@end
