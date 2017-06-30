//
//  HJGameViewController.m
//  LivePlayer-HJ
//
//  Created by huangjian on 17/3/3.
//  Copyright © 2017年 huangjian. All rights reserved.
//

#import "HJGameViewController.h"
#import "HJGameCell.h"
#import "HJGameCellModel.h"
#import "HJGameListController.h"
#import "MJRefresh.h"
#import "MJExtension.h"
#import "HJGameRequest.h"

#define WIDTH [UIScreen mainScreen].bounds.size.width
#define HEIGHT [UIScreen mainScreen].bounds.size.height
@interface HJGameViewController ()<UICollectionViewDataSource,UICollectionViewDelegate>
@property (nonatomic,strong)UICollectionView *gameCollection;

@property (nonatomic,strong)NSMutableArray *gameListData;

@property (nonatomic,assign)int page;
@end

@implementation HJGameViewController

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
    self.gameCollection = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT) collectionViewLayout:layout];
    self.gameCollection.delegate = self;
    self.gameCollection.dataSource = self;
    self.gameCollection.backgroundColor = [UIColor whiteColor];
    self.gameCollection.showsVerticalScrollIndicator = NO;
    
    [self.gameCollection registerClass:[HJGameCell class] forCellWithReuseIdentifier:@"gameCell"];
    [self.view addSubview:self.gameCollection];
    
}
-(void)refresh
{
    self.gameCollection.mj_header=[MJRefreshNormalHeader headerWithRefreshingBlock:^{
        self.page=1;
        [self.gameListData removeAllObjects];
        [self getData];
    }];
    self.gameCollection.mj_footer=[MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        self.page=self.page+1;
        [self getData];
    }];
    [self.gameCollection.mj_header beginRefreshing];
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
    HJGameCell *cell = (HJGameCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"gameCell" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor whiteColor];
    
    cell.model=self.gameListData[indexPath.row];
    
    
    return cell;
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    HJGameListController *gameListVc=[[HJGameListController alloc]init];
    gameListVc.gameID=((HJGameCellModel *)self.gameListData[indexPath.row]).ID;
    [self.navigationController pushViewController:gameListVc animated:YES];
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(10, 10, 10, 10);
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake((WIDTH - 60)/3.0, 153);
}

-(void)getData
{
    [HJGameRequest gameRequestWithPage:[NSString stringWithFormat:@"%d",self.page] Success:^(id responseObject) {
        NSArray *arr=responseObject[@"data"][@"games"];
        [arr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            HJGameCellModel *model = [HJGameCellModel mj_objectWithKeyValues:obj];
            [self.gameListData addObject:model];
        }];
        [self.gameCollection reloadData];
        [self.gameCollection.mj_header endRefreshing];
        [self.gameCollection.mj_footer endRefreshing];
    } failure:^(NSError *error) {
        [self.gameCollection.mj_header endRefreshing];
        [self.gameCollection.mj_footer endRefreshing];
    }];
}


@end
