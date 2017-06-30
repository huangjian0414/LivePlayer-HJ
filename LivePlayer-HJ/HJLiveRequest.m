//
//  HJLiveRequest.m
//  LivePlayer-HJ
//
//  Created by huangjian on 17/3/3.
//  Copyright © 2017年 huangjian. All rights reserved.
//

#import "HJLiveRequest.h"
#import "HJHttpTool.h"
@implementation HJLiveRequest

+(void)liveRequestWithPage:(NSString *)page Success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure
{
    NSString *live=[NSString stringWithFormat:@"http://www.zhanqi.tv/api/static/live.hots/20-%@.json",page];
    
    [HJHttpTool GET:live parameters:nil success:^(id responseObject) {
        success(responseObject);
    } failure:^(NSError *error) {
        failure(error);
    }];
}
@end
