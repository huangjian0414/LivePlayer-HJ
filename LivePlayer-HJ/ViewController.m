//
//  ViewController.m
//  LivePlayer-HJ
//
//  Created by huangjian on 17/2/27.
//  Copyright © 2017年 huangjian. All rights reserved.
//

#import "ViewController.h"
#import "HJBanderRequest.h"
#import "HJHomeCell.h"
#import "MJRefresh.h"
#import "HJBannerModel.h"
#import "HJRoomModel.h"
#import "HJHomeCycleView.h"
#import "MJExtension.h"
#import "HJHomeSectionModel.h"
#import "HJCollectionCellModel.h"
#import "HJMenuHeaderView.h"
#import "HJLivePlayerController.h"

#define WIDTH [UIScreen mainScreen].bounds.size.width
#define HEIGHT [UIScreen mainScreen].bounds.size.height
@interface ViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,HJHomeCycleViewDelegate>
@property (nonatomic, strong) UICollectionView *liveCollectionView;

//轮播器
@property (nonatomic, strong) HJHomeCycleView *cycleView;
/**
 *  存放滚动栏信息，包括房间信息
 */
@property (nonatomic, strong) NSMutableArray *banderModelArray;
/**
 *  存放房间信息
 */
@property (nonatomic, strong) NSMutableArray *roomModelArray;

/**
 *  存放组的名字数组
 */
@property (nonatomic, strong) NSMutableArray *sectionTitleDataArray;


/**
 self.avatarDataArray数组  装五个房间的信息
 */
@property (nonatomic, strong) NSMutableArray *avatarDataArray;

/**
 self.sectionDataArray 装多个分类的数组，self.sectionDataArray下装有多个（热门直播，竞技网游，随拍）分类，
 每个分类的数组下有五个房间信息
 */
@property (nonatomic, strong) NSMutableArray *sectionDataArray;

@end

@implementation ViewController

-(NSMutableArray *)banderModelArray
{
    if (!_banderModelArray) {
        _banderModelArray=[NSMutableArray array];
        
    }
    return _banderModelArray;
}

-(NSMutableArray *)roomModelArray
{
    if (!_roomModelArray) {
        _roomModelArray=[NSMutableArray array];
    }
    return _roomModelArray;
}

-(NSMutableArray *)sectionDataArray
{
    if (!_sectionDataArray) {
        _sectionDataArray=[NSMutableArray array];
    }
    return _sectionDataArray;
}
-(NSMutableArray *)avatarDataArray
{
    if (!_avatarDataArray) {
        _avatarDataArray=[NSMutableArray array];
    }
    return _avatarDataArray;
}
-(NSMutableArray *)sectionTitleDataArray
{
    if (!_sectionTitleDataArray) {
        _sectionTitleDataArray=[NSMutableArray array];
    }
    return _sectionTitleDataArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
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
    [self.liveCollectionView registerClass:[HJHomeCycleView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"homeCycleView"];
     [self.liveCollectionView registerClass:[HJMenuHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"menuHeaderView"];
    
    [self.view addSubview:self.liveCollectionView];
    
}
-(void)refresh
{
    self.liveCollectionView.mj_header=[MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self getData];
    }];
    [self.liveCollectionView.mj_header beginRefreshing];
}
-(void)getData
{
    [HJBanderRequest banderRequestSuccess:^(id responseObject) {
        NSDictionary *dic=(NSDictionary *)responseObject;
        NSArray *arr=dic[@"data"];
        [self.banderModelArray removeAllObjects];
        [self.roomModelArray removeAllObjects];
        
        [arr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            HJBannerModel *bannerModel=[HJBannerModel mj_objectWithKeyValues:obj];
            HJRoomModel *roomModel=[HJRoomModel mj_objectWithKeyValues:bannerModel.room];
            [self.banderModelArray addObject:bannerModel];
            [self.roomModelArray addObject:roomModel];
        }];
        
        [self.liveCollectionView reloadData];
        
        
    } failure:^(NSError *error) {
        
    }];
    [HJBanderRequest roomRequestSuccess:^(id responseObject) {
        NSDictionary *dic=responseObject;
        NSArray *arr=dic[@"data"];
        [self.sectionTitleDataArray removeAllObjects];
        [self.sectionDataArray removeAllObjects];
        for (NSDictionary *dict in arr) {
            HJHomeSectionModel *sectionModel=[HJHomeSectionModel mj_objectWithKeyValues:dict];
            [self.sectionTitleDataArray addObject:sectionModel];
            [self.avatarDataArray removeAllObjects];
            for (HJCollectionCellModel *cellModel in sectionModel.lists) {
                [self.avatarDataArray addObject:cellModel];
            }
            [self.sectionDataArray addObject:self.avatarDataArray.copy];
        }
        [self.liveCollectionView reloadData];
        [self.liveCollectionView.mj_header endRefreshing];
        
    } failure:^(NSError *error) {
        [self.liveCollectionView.mj_header endRefreshing];
    }];
    
    
}


- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return self.sectionDataArray.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return ((NSArray *)self.sectionDataArray[section]).count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    HJHomeCell *cell = (HJHomeCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"homeCell" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor whiteColor];
    
    cell.model=self.sectionDataArray[indexPath.section][indexPath.row];
    
    
    return cell;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return CGSizeMake(WIDTH, 180 + 33);
    }else{
        return CGSizeMake(WIDTH, 40);
    }
}
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    UICollectionReusableView *reusableview = nil;
    if (kind == UICollectionElementKindSectionHeader) {
        if (indexPath.section == 0) {
            self.cycleView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"homeCycleView" forIndexPath:indexPath];
            self.cycleView.delegate = self;
            self.cycleView.photoDataArray = self.banderModelArray.copy;
            self.cycleView.titleDataString= ((HJHomeSectionModel *)self.sectionTitleDataArray[indexPath.section]).title;
            self.cycleView.imageUrl = ((HJHomeSectionModel *)self.sectionTitleDataArray[indexPath.section]).icon;
            reusableview = self.cycleView;
        }else{
            HJMenuHeaderView *menuHeaderView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"menuHeaderView" forIndexPath:indexPath];
            menuHeaderView.titleDataString = ((HJHomeSectionModel *)self.sectionTitleDataArray[indexPath.section]).title;
            menuHeaderView.imageUrl = ((HJHomeSectionModel *)self.sectionTitleDataArray[indexPath.section]).icon;
             reusableview = menuHeaderView;
        }
    }
    return reusableview;
    
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    HJLivePlayerController *vc=[[HJLivePlayerController alloc]init];
    vc.videoTitle=((HJCollectionCellModel *)self.sectionDataArray[indexPath.section][indexPath.row]).title;
    NSString *videoID=((HJCollectionCellModel *)self.sectionDataArray[indexPath.section][indexPath.row]).videoId;
    NSString *urlID=((HJCollectionCellModel *)self.sectionDataArray[indexPath.section][indexPath.row]).spic;
    NSString *shutID=[urlID substringWithRange:NSMakeRange(37, 12)];
    if (videoID) {
        vc.videoID=videoID;
    }else
    {
        vc.videoID=shutID;
    }
    [self presentModalViewController:vc animated:YES];
    
}

-(void)HJHomeCycleVieWithRoomId:(NSString *)roomId roomTitle:(NSString *)roomTitle
{
    HJLivePlayerController *vc=[[HJLivePlayerController alloc]init];
    vc.videoTitle=roomTitle;
    vc.videoID=roomId;
    [self presentModalViewController:vc animated:YES];
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(10, 10, 10, 10);
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake((WIDTH - 40)/2.0, 130);
}


@end
