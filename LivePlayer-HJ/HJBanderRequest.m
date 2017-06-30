//
//  HJBanderRequest.m
//  LivePlayer-HJ
//
//  Created by huangjian on 17/2/27.
//  Copyright © 2017年 huangjian. All rights reserved.
//

#import "HJBanderRequest.h"
#import "HJHttpTool.h"
@implementation HJBanderRequest
+(void)banderRequestSuccess:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure;
{
    [HJHttpTool GET:@"http://www.zhanqi.tv/api/touch/apps.banner?rand=1455848328344" parameters:nil success:^(id responseObject) {
            success(responseObject);
        
    } failure:^(NSError *error) {
            failure(error);

    }];
}


+(void)roomRequestSuccess:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure
{
    [HJHttpTool GET:@"http://www.zhanqi.tv/api/static/live.index/recommend-apps.json?" parameters:nil success:^(id responseObject) {
        success(responseObject);
        
    } failure:^(NSError *error) {
        failure(error);
        
    }];
}

@end
