//
//  HJHomeSectionModel.h
//  LivePlayer-HJ
//
//  Created by huangjian on 17/2/28.
//  Copyright © 2017年 huangjian. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HJHomeSectionModel : NSObject
@property (nonatomic, strong) NSString *keyword;

/**
 *  标题：热门直播
 */
@property (nonatomic, strong) NSString *title;

/**
 *  图片
 */
@property (nonatomic, strong) NSString *icon;


@property (nonatomic, strong) NSString *channelIds;
@property (nonatomic, strong) NSString *gameIds;
@property (nonatomic, strong) NSString *moreUrl;
@property (nonatomic, strong) NSString *nums;

/**
 *  列表
 */
@property (nonatomic, strong) NSArray *lists;


@end
