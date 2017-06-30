//
//  HJLivePlayerController.m
//  LivePlayer-HJ
//
//  Created by huangjian on 17/2/28.
//  Copyright © 2017年 huangjian. All rights reserved.
//

#import "HJLivePlayerController.h"
#import "WSPlayer.h"
#import "UIView+SMScreenRecording.h"

#define VIDEO_URL @"http://dlhls.cdn.zhanqi.tv/zqlive/"
#define WIDTH [UIScreen mainScreen].bounds.size.width
@interface HJLivePlayerController ()
@property (nonatomic,strong)WSPlayer *player;
@end

@implementation HJLivePlayerController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    [self creatPlayer];
}
-(WSPlayer *)player
{
    if (!_player) {
        _player=[[WSPlayer alloc]initWithFrame:CGRectMake(0, 0, WIDTH,9.0*WIDTH/16.0)];
        [_player showInSuperView:self.view andSuperVC:self];
    }
    return _player;
}

-(void)creatPlayer
{
    NSString *urlStr=[NSString stringWithFormat:@"%@%@.m3u8",VIDEO_URL,self.videoID];
    urlStr=[urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    self.player.titleString=self.videoTitle;
    [self.player updatePlayerWith:[NSURL URLWithString:urlStr]];
    __weak typeof(self) weakSelf=self;
    [self.player setBlock:^void (NSString *text){
        
        [weakSelf dismissModalViewControllerAnimated:YES];
        [weakSelf.player pause];
    }];
   
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
