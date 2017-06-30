//
//  HJBanderRequest.h
//  LivePlayer-HJ
//
//  Created by huangjian on 17/2/27.
//  Copyright © 2017年 huangjian. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HJBanderRequest : NSObject
+(void)banderRequestSuccess:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure;

+(void)roomRequestSuccess:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure;

@end
