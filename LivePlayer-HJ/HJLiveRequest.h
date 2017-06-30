//
//  HJLiveRequest.h
//  LivePlayer-HJ
//
//  Created by huangjian on 17/3/3.
//  Copyright © 2017年 huangjian. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HJLiveRequest : NSObject
+(void)liveRequestWithPage:(NSString *)page Success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure;
@end
