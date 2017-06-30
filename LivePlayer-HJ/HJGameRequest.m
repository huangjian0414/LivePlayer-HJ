//
//  HJGameRequest.m
//  LivePlayer-HJ
//
//  Created by huangjian on 17/3/4.
//  Copyright © 2017年 huangjian. All rights reserved.
//

#import "HJGameRequest.h"
#import "HJHttpTool.h"
@implementation HJGameRequest

+(void)gameRequestWithPage:(NSString *)page Success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure
{
    NSString *live=[NSString stringWithFormat:@"http://www.zhanqi.tv/api/static/game.lists/12-%@.json",page];
    
    [HJHttpTool GET:live parameters:nil success:^(id responseObject) {
        success(responseObject);
    } failure:^(NSError *error) {
        failure(error);
    }];
}
@end
