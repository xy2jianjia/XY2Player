//
//  XYZRecommend2.m
//  XY2Player
//
//  Created by zxs on 16/3/25.
//  Copyright © 2016年 YSKS.cn. All rights reserved.
//

#import "XYZRecommend2.h"
#import "XYZNexChannelCell.h"
@interface XYZRecommend2 () <UICollectionViewDataSource,UICollectionViewDelegate> {
    UICollectionView *_collectionViews;
}
@property (nonatomic, strong) NSMutableArray *dateArray;
@end

@implementation XYZRecommend2

- (void)viewDidLoad {
    [super viewDidLoad];
    self.dateArray = @[].mutableCopy;
    [self requCollection];
    [self dateRequest];
}
- (void)dateRequest {
    
    AFHTTPRequestOperationManager *headins_manger = [AFHTTPRequestOperationManager manager];
    headins_manger.responseSerializer = [AFHTTPResponseSerializer serializer];
    NSString *loopurlPath = [NSString stringWithFormat:@"%@web/getmv",XY2HTTP1];
    [headins_manger GET:loopurlPath parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSData *data = operation.responseData;
        NSArray *dictArray = [NSJSONSerialization JSONObjectWithData:data options:(NSJSONReadingAllowFragments) error:nil];
        for (NSDictionary *remmendDic in dictArray) {
            XYZRecom2Model *recomodel = [[XYZRecom2Model alloc] init];
            recomodel.title = remmendDic[@"title"];
            recomodel.imgurl = remmendDic[@"imgurl"];
            recomodel.videoUrl = remmendDic[@"videoUrl"];
            [self.dateArray addObject:recomodel];
        }
        [_collectionViews reloadData];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        BlockSort *block = [[BlockSort alloc] initWithView:self.view];
        [block setRefrecurrentUrl:[NSString stringWithFormat:@"%@web/getmv",XY2HTTP1] Success:^(id responseCode) {
            [self dateRequest];
        }];
    }];
}
- (void)requCollection {
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    // item大小
    layout.itemSize = CGSizeMake(ImageWidth, ImageHeight+20);
    layout.minimumLineSpacing = TandBspacing;  // 上下间距
    layout.minimumInteritemSpacing = LRspacing;  // 左右间距
    layout.scrollDirection = UICollectionViewScrollDirectionVertical; // 设置滚动方向
    layout.sectionInset = UIEdgeInsetsMake(10, Leftspacing, ImageHeight+20, Rightspacing);  // top left bottom right
    // header
    layout.headerReferenceSize = CGSizeMake(WIDTH, 0);
    _collectionViews = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];
    _collectionViews.backgroundColor = [UIColor whiteColor];
    _collectionViews.delegate = self;
    _collectionViews.dataSource = self;
    [self.view addSubview:_collectionViews];
    [_collectionViews registerClass:[XYZNexChannelCell class] forCellWithReuseIdentifier:@"cell"];
    
}
#pragma mark dataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dateArray.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    XYZNexChannelCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    XYZRecom2Model *recomodel = self.dateArray[indexPath.row];
    [cell setmodelWITHRemmend:recomodel];
    return cell;
}
#pragma mark -- 选中cell
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    XYZRecom2Model *yySub = self.dateArray[indexPath.row];
    XYZPlayerViewController *player = [[XYZPlayerViewController alloc] init];
    player.mp4Url = yySub.videoUrl;
    player.indexMask = INDEXMASK;  // 不需要遮罩
    player.picImage = yySub.imgurl;
    UINavigationController *nac = [[UINavigationController alloc] initWithRootViewController:player];
    [self presentViewController:nac animated:YES completion:nil];
}
@end
