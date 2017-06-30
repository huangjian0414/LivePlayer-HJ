//
//  HJHomeCycleView.m
//  LivePlayer-HJ
//
//  Created by huangjian on 17/2/27.
//  Copyright © 2017年 huangjian. All rights reserved.
//

#import "HJHomeCycleView.h"
#import "SDCycleScrollView.h"
#import "HJBannerModel.h"
#import  "UIImageView+WebCache.h"

@interface HJHomeCycleView()<SDCycleScrollViewDelegate>
@property (nonatomic, strong) SDCycleScrollView *cycleView;

@property (nonatomic, strong) UIImageView *lineView;
@property (nonatomic, strong) UILabel *title;//名称：竞技网游

@property (nonatomic, strong) NSMutableArray *roomIdArr;//房间ID号码
@property (nonatomic, strong) NSMutableArray *roomTitleArr;//房间ID号码
@end
@implementation HJHomeCycleView

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self=[super initWithFrame:frame]) {
        [self setUI];
    }
    return self;
}
- (void)setTitleDataString:(NSString *)titleDataString {
    _titleDataString = titleDataString;
    self.title.text = titleDataString;
}
-(void)setPhotoDataArray:(NSArray *)photoDataArray
{
    _photoDataArray=photoDataArray;
    NSMutableArray *imageArr=[NSMutableArray array];
    self.roomIdArr = [NSMutableArray array];//房间ID
    self.roomTitleArr = [NSMutableArray array];//房间名称
    
    for (HJBannerModel *model in photoDataArray) {
        [imageArr addObject:model.spic];
        [self.roomIdArr addObject:model.roomId];
        [self.roomTitleArr addObject:model.title];
    }
    self.cycleView.imageURLStringsGroup = imageArr;
}
-(void)setImageUrl:(NSString *)imageUrl {
    _imageUrl = imageUrl;
    
    [_lineView sd_setImageWithURL:[NSURL URLWithString:imageUrl]];
}

-(void)setUI
{
    self.cycleView=[[SDCycleScrollView alloc]initWithFrame:CGRectMake(0, 0, self.bounds.size.width, 170)];
    self.cycleView.backgroundColor=[UIColor whiteColor];
    self.cycleView.pageControlAliment=SDCycleScrollViewPageContolAlimentCenter;
    self.cycleView.pageControlStyle=SDCycleScrollViewPageContolStyleClassic;
    self.cycleView.placeholderImage=[UIImage imageNamed:@"ic_logo_big"];
    self.cycleView.delegate=self;
    [self addSubview:self.cycleView];
    
    _lineView = [[UIImageView alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(self.cycleView.frame) + 10, 26, 26)];
    [self addSubview:_lineView];
    
    self.title = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_lineView.frame) + 4, CGRectGetMaxY(self.cycleView.frame) + 10, self.bounds.size.width - 40, 26)];
    self.title.text = @"组的标题";
    self.title.font = [UIFont boldSystemFontOfSize:20];
    self.title.textColor = [UIColor blackColor];
    self.title.textAlignment = NSTextAlignmentLeft;
    [self addSubview:self.title];
}

- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index
{
    if ([self.delegate respondsToSelector:@selector(HJHomeCycleVieWithRoomId:roomTitle:)]) {
        [self.delegate HJHomeCycleVieWithRoomId:self.roomIdArr[index] roomTitle:self.roomTitleArr[index]];
    }
}
@end
