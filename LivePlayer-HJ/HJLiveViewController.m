//
//  HJLiveViewController.m
//  LivePlayer-HJ
//
//  Created by huangjian on 17/3/3.
//  Copyright © 2017年 huangjian. All rights reserved.
//

#import "HJLiveViewController.h"
#import "HJHomeCell.h"
#import "MJRefresh.h"
#import "HJLiveRequest.h"
#import "HJCollectionCellModel.h"
#import "MJExtension.h"
#import "HJLivePlayerController.h"
#define WIDTH [UIScreen mainScreen].bounds.size.width
#define HEIGHT [UIScreen mainScreen].bounds.size.height
@interface HJLiveViewController ()<UICollectionViewDataSource,UICollectionViewDelegate>
@property (nonatomic, strong) UICollectionView *liveCollectionView;

@property (nonatomic, strong) NSMutableArray *liveListData;

@property (nonatomic,assign)int page;
@end

@implementation HJLiveViewController
-(NSMutableArray *)liveListData
{
    if (!_liveListData) {
        _liveListData=[NSMutableArray array];
    }
    return _liveListData;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.page=1;
    [self setCollectionView];
    [self refresh];
    
}
-(void)setCollectionView
{
    UICollectionViewFlowLayout *layout=[[UICollectionViewFlowLayout alloc]init];
    layout.minimumInteritemSpacing=0;
    layout.minimumLineSpacing=0;
    self.liveCollectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT) collectionViewLayout:layout];
    self.liveCollectionView.delegate = self;
    self.liveCollectionView.dataSource = self;
    self.liveCollectionView.backgroundColor = [UIColor whiteColor];
    self.liveCollectionView.showsVerticalScrollIndicator = NO;
    
    [self.liveCollectionView registerClass:[HJHomeCell class] forCellWithReuseIdentifier:@"homeCell"];
    [self.view addSubview:self.liveCollectionView];
    
}
-(void)refresh
{
    self.liveCollectionView.mj_header=[MJRefreshNormalHeader headerWithRefreshingBlock:^{
        self.page=1;
        [self.liveListData removeAllObjects];
        [self getData];
    }];
    self.liveCollectionView.mj_footer=[MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        self.page=self.page+1;
        [self.liveListData removeAllObjects];
        [self getData];
    }];
    [self.liveCollectionView.mj_header beginRefreshing];
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.liveListData.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    HJHomeCell *cell = (HJHomeCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"homeCell" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor whiteColor];
    
    cell.model=self.liveListData[indexPath.row];
    
    
    return cell;
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    HJLivePlayerController *videoVc=[[HJLivePlayerController alloc]init];
    videoVc.videoID=((HJCollectionCellModel *)self.liveListData[indexPath.row]).videoId; 
    [self presentModalViewController:videoVc animated:YES];
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(10, 10, 10, 10);
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake((WIDTH - 40)/2.0, 130);
}

-(void)getData
{
    [HJLiveRequest liveRequestWithPage:[NSString stringWithFormat:@"%d",self.page] Success:^(id responseObject) {
        NSArray *arr=responseObject[@"data"][@"rooms"];
        [arr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            HJCollectionCellModel *model=[HJCollectionCellModel mj_objectWithKeyValues:obj];
            [self.liveListData addObject:model];
        }];
        [self.liveCollectionView reloadData];
        [self.liveCollectionView.mj_header endRefreshing];
        [self.liveCollectionView.mj_footer endRefreshing];
    } failure:^(NSError *error) {
        [self.liveCollectionView.mj_header endRefreshing];
        [self.liveCollectionView.mj_footer endRefreshing];
    }];
}

@end
