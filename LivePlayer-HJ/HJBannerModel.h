//
//  HJBannerModel.h
//  LivePlayer-HJ
//
//  Created by huangjian on 17/2/27.
//  Copyright © 2017年 huangjian. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HJBannerModel : NSObject
/**
 *  游戏ID
 */
@property (nonatomic, strong) NSString *gameId;

/**
 *  ID
 */
@property (nonatomic, strong) NSString *ID;

/**
 *  房间ID
 */
@property (nonatomic, strong) NSString *roomId;

/**
 *  图片
 */
@property (nonatomic, strong) NSString *spic;

/**
 *  名称
 */
@property (nonatomic, strong) NSString *title;

/**
 *  网址
 */
@property (nonatomic, strong) NSString *url;

/**
 *  房间信息（字典）
 */
@property (nonatomic, strong) NSDictionary *room;

@end
