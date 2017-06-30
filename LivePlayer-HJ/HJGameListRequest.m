//
//  HJGameListRequest.m
//  LivePlayer-HJ
//
//  Created by huangjian on 17/3/4.
//  Copyright © 2017年 huangjian. All rights reserved.
//

#import "HJGameListRequest.h"
#import "HJHttpTool.h"
@implementation HJGameListRequest
+(void)gameListRequestWithPage:(NSString *)page GameId:(NSString *)gameId Success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure
{
    NSString *live=[NSString stringWithFormat:@"http://www.zhanqi.tv/api/static/game.lives//%@/20-%@.json",gameId,page];
    
    [HJHttpTool GET:live parameters:nil success:^(id responseObject) {
        success(responseObject);
    } failure:^(NSError *error) {
        failure(error);
    }];

}
@end
