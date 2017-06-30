//
//  HJGameListController.m
//  LivePlayer-HJ
//
//  Created by huangjian on 17/3/4.
//  Copyright © 2017年 huangjian. All rights reserved.
//

#import "HJGameListController.h"
#import "HJHomeCell.h"
#import "HJCollectionCellModel.h"
#import "MJExtension.h"
#import "MJRefresh.h"
#import "HJLivePlayerController.h"
#import "HJGameListRequest.h"

#define WIDTH [UIScreen mainScreen].bounds.size.width
#define HEIGHT [UIScreen mainScreen].bounds.size.height
@interface HJGameListController ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic, strong) UICollectionView *collectionView;

@property (nonatomic, strong) NSMutableArray *gameListData;

@property (nonatomic, assign) int page;

@end

@implementation HJGameListController

-(NSMutableArray *)gameListData
{
    if (!_gameListData) {
        _gameListData=[NSMutableArray array];
    }
    return _gameListData;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.page=1;
    [self setCollectionView];
    [self refresh];
}
-(void)setCollectionView
{
    UICollectionViewFlowLayout *layout=[[UICollectionViewFlowLayout alloc]init];
    layout.minimumInteritemSpacing=0;
    layout.minimumLineSpacing=0;
    self.collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT) collectionViewLayout:layout];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.backgroundColor = [UIColor whiteColor];
    self.collectionView.showsVerticalScrollIndicator = NO;
    
    [self.collectionView registerClass:[HJHomeCell class] forCellWithReuseIdentifier:@"homeCell"];
    [self.view addSubview:self.collectionView];
    
}
-(void)refresh
{
    self.collectionView.mj_header=[MJRefreshNormalHeader headerWithRefreshingBlock:^{
        self.page=1;
        [self.gameListData removeAllObjects];
        [self getData];
    }];
    self.collectionView.mj_footer=[MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        self.page=self.page+1;
        [self getData];
    }];
    [self.collectionView.mj_header beginRefreshing];
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.gameListData.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    HJHomeCell *cell = (HJHomeCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"homeCell" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor whiteColor];
    
    cell.model=self.gameListData[indexPath.row];
    
    
    return cell;
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    HJLivePlayerController *videoVc=[[HJLivePlayerController alloc]init];
    videoVc.videoID=((HJCollectionCellModel *)self.gameListData[indexPath.row]).videoId;
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
    [HJGameListRequest gameListRequestWithPage:[NSString stringWithFormat:@"%d",self.page] GameId:self.gameID Success:^(id responseObject) {
        NSArray *arr = responseObject[@"data"][@"rooms"];
        [arr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            HJCollectionCellModel *model = [HJCollectionCellModel mj_objectWithKeyValues:obj];
            [self.gameListData addObject:model];
        }];
        [self.collectionView reloadData];
        [self.collectionView.mj_header endRefreshing];
        [self.collectionView.mj_footer endRefreshing];
        
    } failure:^(NSError *error) {
        [self.collectionView.mj_header endRefreshing];
        [self.collectionView.mj_footer endRefreshing];
        
    }];
}


@end
