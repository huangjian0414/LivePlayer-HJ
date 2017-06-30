//
//  HJHomeCycleView.h
//  LivePlayer-HJ
//
//  Created by huangjian on 17/2/27.
//  Copyright © 2017年 huangjian. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol HJHomeCycleViewDelegate <NSObject>

-(void)HJHomeCycleVieWithRoomId:(NSString *)roomId roomTitle:(NSString *)roomTitle;

@end

@interface HJHomeCycleView : UICollectionReusableView

@property (nonatomic, strong) NSArray *photoDataArray;

/**
 *  名称：（竞技网游）
 */
@property (nonatomic, strong) NSString *titleDataString;


/**
 *  图片：（竞技网游前面的图片地址）
 */
@property (nonatomic, strong) NSString *imageUrl;

@property (nonatomic,weak)id<HJHomeCycleViewDelegate>delegate;
@end
