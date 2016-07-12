//
//  XYZHitViewController.m
//  XY2Player
//
//  Created by zxs on 16/3/25.
//  Copyright © 2016年 YSKS.cn. All rights reserved.
//

#import "XYZHitViewController.h"
#import "XYZHitCell.h"
@interface XYZHitViewController ()<UICollectionViewDataSource,UICollectionViewDelegate> {
    UICollectionView *_collectionViews;
}
@property (nonatomic, strong) NSMutableArray *dateArray;
@end

@implementation XYZHitViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.dateArray = @[].mutableCopy;
    [self dateRequwst];
    [self requCollection];
}

- (void)dateRequwst {
    [BlockSort setRequestUrlStr:[NSString stringWithFormat:@"%@iosts-cps/getVideoRmdList.service",XY2HTTP2] successMethod:^(NSDictionary *requestDic, id responseObject) {
        NSArray *dicArray = requestDic[@"videoRmdList"];
        for (NSDictionary *hitDic in dicArray) {
            XYZHitModel *hit = [[XYZHitModel alloc] init];
            hit.imgUrl = hitDic[@"imgUrl"];
            hit.videoUrl = hitDic[@"videoUrl"];
            [self.dateArray addObject:hit];
        }
        [_collectionViews reloadData];
    } failMethod:^(AFHTTPRequestOperation *operation, NSError *error) {
        BlockSort *block = [[BlockSort alloc] initWithView:self.view];
        [block setRefrecurrentUrl:[NSString stringWithFormat:@"%@iosts-cps/getVideoRmdList.service",XY2HTTP2] Success:^(id responseCode) {
            [self dateRequwst];
        }];
    }];
}

- (void)requCollection {
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    // item大小
    layout.itemSize = CGSizeMake(WIDTH-Leftspacing*2, HitImageHeight);
    layout.minimumLineSpacing = HitTandBspacing;  // 上下间距
    layout.minimumInteritemSpacing = 0;  // 左右间距
    layout.scrollDirection = UICollectionViewScrollDirectionVertical; // 设置滚动方向
    layout.sectionInset = UIEdgeInsetsMake(10, Leftspacing, HitImageHeight, Rightspacing);  // top left bottom right
    // header
    layout.headerReferenceSize = CGSizeMake(WIDTH, 0);
    _collectionViews = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];
    _collectionViews.backgroundColor = [UIColor whiteColor];
    _collectionViews.delegate = self;
    _collectionViews.dataSource = self;
    [self.view addSubview:_collectionViews];
    [_collectionViews registerClass:[XYZHitCell class] forCellWithReuseIdentifier:@"cell"];
}

#pragma mark dataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dateArray.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    XYZHitCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    XYZHitModel *next = self.dateArray[indexPath.row];
    [cell setModelWithNextChannel:next];
    return cell;
}
#pragma mark -- 选中cell
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    XYZHitModel *yySub = self.dateArray[indexPath.row];
    XYZPlayerViewController *player = [[XYZPlayerViewController alloc] init];
    player.mp4Url = yySub.videoUrl;
#warning ~~~~~~~~~~~~~~~~ Temporarily to be determined
    player.picImage = yySub.imgUrl; // 待定
    player.indexMask = INDEXMASK;
    UINavigationController *nac = [[UINavigationController alloc] initWithRootViewController:player];
    [self presentViewController:nac animated:YES completion:nil];
}

@end
