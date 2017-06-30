//
//  HJGameListRequest.h
//  LivePlayer-HJ
//
//  Created by huangjian on 17/3/4.
//  Copyright © 2017年 huangjian. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HJGameListRequest : NSObject
+(void)gameListRequestWithPage:(NSString *)page GameId:(NSString *)gameId Success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure;
@end
