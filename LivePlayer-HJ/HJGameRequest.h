//
//  HJGameRequest.h
//  LivePlayer-HJ
//
//  Created by huangjian on 17/3/4.
//  Copyright © 2017年 huangjian. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HJGameRequest : NSObject
+(void)gameRequestWithPage:(NSString *)page Success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure;
@end
