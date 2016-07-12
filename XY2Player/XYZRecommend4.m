//
//  XYZRecommend4.m
//  XY2Player
//
//  Created by zxs on 16/3/25.
//  Copyright © 2016年 YSKS.cn. All rights reserved.
//

#import "XYZRecommend4.h"
#import "XYZNextRecommend4.h"
#import "XYZRecommend3Cell.h"
@interface XYZRecommend4 ()<UICollectionViewDataSource,UICollectionViewDelegate> {
    UICollectionView *_collectionViews;
}
@property (nonatomic, strong) NSMutableArray *dateArray;
@end

@implementation XYZRecommend4

- (void)viewDidLoad {
    [super viewDidLoad];
    self.dateArray = @[].mutableCopy;
    [self dateRequest];
    [self requCollection];
}

- (void)dateRequest {
    
    AFHTTPRequestOperationManager *headins_manger = [AFHTTPRequestOperationManager manager];
    headins_manger.responseSerializer = [AFHTTPResponseSerializer serializer];
    NSString *loopurlPath = [NSString stringWithFormat:@"%@iosts-cps/qryAllChnl.service?vm=1&isDrama=1&isSpec=1&isMulti=1&isApp=1",XY2HTTP2];
    [headins_manger GET:loopurlPath parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSData *data = operation.responseData;
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:(NSJSONReadingAllowFragments) error:nil];
        NSArray *requestArray = dict[@"allChannelInfoList"];
        for (NSDictionary *recommendDic in requestArray) {
            XYZRecom4Model *recom = [[XYZRecom4Model alloc] init];
            [recom setValuesForKeysWithDictionary:recommendDic];
            [self.dateArray addObject:recom];
        }
        [_collectionViews reloadData];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        BlockSort *block = [[BlockSort alloc] initWithView:self.view];
        [block setRefrecurrentUrl:[NSString stringWithFormat:@"%@iosts-cps/qryAllChnl.service?vm=1&isDrama=1&isSpec=1&isMulti=1&isApp=1",XY2HTTP2] Success:^(id responseCode) {
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
    [_collectionViews registerClass:[XYZRecommend3Cell class] forCellWithReuseIdentifier:@"cell"];
}
#pragma mark dataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dateArray.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    XYZRecommend3Cell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    XYZRecom4Model *recomodel = self.dateArray[indexPath.row];
    [cell setModelWhitRecom4:recomodel];
    return cell;
}
#pragma mark -- 选中cell
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    XYZRecom4Model *yySub = self.dateArray[indexPath.row];
    XYZNextRecommend4 *next = [[XYZNextRecommend4 alloc] init];
    next.channelEnum = yySub.channelEnum;
    next.channelId = yySub.chnlId;
    UINavigationController *nac = [[UINavigationController alloc] initWithRootViewController:next];
    [self presentViewController:nac animated:YES completion:nil];
}

@end
