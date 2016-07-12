//
//  XYZRecommend.m
//  XY2Player
//
//  Created by zxs on 16/3/21.
//  Copyright © 2016年 YSKS.cn. All rights reserved.
//

#import "XYZRecommend.h"
#import "XYZRecommendCell.h"
#import "XYZHeaderReusableView.h"

@interface XYZRecommend ()<UICollectionViewDataSource,UICollectionViewDelegate,SDCycleScrollViewDelegate> {
    UICollectionView *_collectionViews;
}
@property (nonatomic, strong) NSMutableArray *dateArray;
@property (nonatomic, strong) NSMutableArray *recomment0;
@property (nonatomic, strong) NSMutableArray *recomment1;
@property (nonatomic, strong) NSMutableArray *recomment2;
@property (nonatomic, strong) NSMutableArray *recomment3;
@property (nonatomic, strong) NSMutableArray *recomment4;
@property (nonatomic, strong) NSMutableArray *carouselImageArray;
@end
static NSString *kheaderIdentifier = @"headerIdentifier";

@implementation XYZRecommend

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"精品推荐";
    self.dateArray  = @[].mutableCopy;
    self.recomment0 = @[].mutableCopy;
    self.recomment1 = @[].mutableCopy;
    self.recomment2 = @[].mutableCopy;
    self.recomment3 = @[].mutableCopy;
    self.recomment4 = @[].mutableCopy;
    [self.dateArray addObject:self.recomment0];
    [self.dateArray addObject:self.recomment1];
    [self.dateArray addObject:self.recomment2];
    [self.dateArray addObject:self.recomment3];
    [self.dateArray addObject:self.recomment4];
    self.carouselImageArray = @[].mutableCopy;
    [self requCollection];
    [self addRequestDate];
    
//    UIButton *releaseButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
//    releaseButton.frame = CGRectMake(0, 0, 40, 30);
//    [releaseButton setTitle:@"返回" forState:normal];
//    [releaseButton setTitleColor:[UIColor redColor] forState:normal];
//    [releaseButton addTarget:self action:@selector(releaseInfo:) forControlEvents:UIControlEventTouchUpInside];
//    UIBarButtonItem *releaseButtonItem = [[UIBarButtonItem alloc] initWithCustomView:releaseButton];
//    self.navigationItem.leftBarButtonItem = releaseButtonItem;
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"backIcon"] style:UIBarButtonItemStylePlain target:self action:@selector(releaseInfo:)];
}
- (void)releaseInfo:(UIButton *)sender {
    [self dismissViewControllerAnimated:true completion:nil];
}

- (void)requCollection {
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    // item大小
    layout.itemSize = CGSizeMake(ImageWidth, ImageHeight);
    layout.minimumLineSpacing = TandBspacing;  // 上下间距
    layout.minimumInteritemSpacing = LRspacing;  // 左右间距
    layout.scrollDirection = UICollectionViewScrollDirectionVertical; // 设置滚动方向
    layout.sectionInset = UIEdgeInsetsMake(0, Leftspacing, 0, Rightspacing);  // top left bottom right
    // header
    layout.headerReferenceSize = CGSizeMake(WIDTH, 0);
    _collectionViews = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];
    _collectionViews.backgroundColor = [UIColor whiteColor];
    _collectionViews.delegate = self;
    _collectionViews.dataSource = self;
    [self.view addSubview:_collectionViews];
    [_collectionViews registerClass:[XYZRecommendCell class] forCellWithReuseIdentifier:@"cell"];
#pragma mark -- 注册头部视图
    [_collectionViews registerClass:[XYZHeaderReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:kheaderIdentifier];
}
- (void)addRequestDate { // 获取图片URL 后面图片需要用这个拼接
    
    
    [BlockSort setRequestUrlStr:[NSString stringWithFormat:@"%@/remoteActive/getColumnInfo?userid=82621&version=1.0.0&type=0",XY2HTTP] successMethod:^(NSDictionary *requestDic, id responseObject) {
        NSArray *requestArray = requestDic[@"columns"]; 
        NSArray *carouselArray = requestDic[@"headitems"];
        
        for (int i = 0; i<requestArray.count; i++) { // 按照顺序添加
            NSDictionary *tempDic = requestArray[i];
            NSArray *tempArray = tempDic[@"items"];
            for (NSDictionary *columDic in tempArray) {
                XYZRecommendModel *recom = [[XYZRecommendModel alloc] init];
                [recom setValuesForKeysWithDictionary:columDic];
                [self.dateArray[i] addObject:recom];
            }
        }
        for (NSDictionary *headDic in carouselArray) { // 轮播
            XYZRecommendModel *recom = [[XYZRecommendModel alloc] init];
            [recom setValuesForKeysWithDictionary:headDic];
            [self.carouselImageArray addObject:recom];
        }
        [_collectionViews reloadData];
    } failMethod:^(AFHTTPRequestOperation *operation, NSError *error) {
        BlockSort *block = [[BlockSort alloc] initWithView:self.view];
        [block setRefrecurrentUrl:[NSString stringWithFormat:@"%@/remoteActive/getColumnInfo?userid=82621&version=1.0.0&type=0",XY2HTTP] Success:^(id responseCode) {
            [self addRequestDate];
        }];
    }];
}
#pragma mark dataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 5;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (section == 0) {
        return self.recomment4.count;
    }else if (section == 1) {
        return self.recomment0.count;
    }else if (section == 2) {
        return self.recomment1.count;
    }else if (section == 3) {
        return self.recomment2.count;
    }else {
        return self.recomment3.count;
    }
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    XYZRecommendCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    if (indexPath.section == 0) {
        XYZRecommendModel *recom = self.recomment4[indexPath.row];
        [cell setModelWithRecommend:recom];
    }else if (indexPath.section == 1) {
        XYZRecommendModel *recom = self.recomment0[indexPath.row];
        [cell setModelWithRecommend:recom];
    }else if (indexPath.section == 2) {
        XYZRecommendModel *recom = self.recomment1[indexPath.row];
       [cell setModelWithRecommend:recom];
    }else if (indexPath.section == 3) {
        XYZRecommendModel *recom = self.recomment2[indexPath.row];
        [cell setModelWithRecommend:recom];
    }else {
        XYZRecommendModel *recom = self.recomment3[indexPath.row];
        [cell setModelWithRecommend:recom];
    }
    return cell;
}
#pragma mark -- 设置头尾部内容
-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    UICollectionReusableView *reusableView = nil;
#pragma mark -- 定制头部视图的内容
    if (kind == UICollectionElementKindSectionHeader) {
        XYZHeaderReusableView *header = (XYZHeaderReusableView *)[collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:kheaderIdentifier forIndexPath:indexPath];
        if (indexPath.section == 0) {
        }else if (indexPath.section == 1) {
            [header setTitle:@"会员专区"];
        }else if (indexPath.section == 2) {
            [header setTitle:@"岛国专区"];
        }else if (indexPath.section == 3) {
            [header setTitle:@"大陆专区"];
        }else {
            [header setTitle:@"欧美专区"];
        }
        reusableView = header;
    }
    return reusableView;
}
#pragma mark -- 返回头headerView的大小
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    CGFloat height;
    if (section == 0) {
        height = CarouselHeight + 40;
        UIImageView *image = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, CarouselHeight)];
        [collectionView addSubview:image];
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(image.frame)+5, WIDTH-10-20, 30)];
        titleLabel.font = [UIFont systemFontOfSize:14];
        titleLabel.textColor = [UIColor darkGrayColor];
        [titleLabel setText:@"非会员专区"];
        [collectionView addSubview:titleLabel];
        
        // picture run
        if ([self respondsToSelector:@selector(edgesForExtendedLayout)]) {
            self.edgesForExtendedLayout = UIRectEdgeNone;
        }
        self.view.userInteractionEnabled=YES;
        NSMutableArray *arr = [NSMutableArray array];
        for (XYZRecommendModel *recom in self.carouselImageArray) {
            [arr addObject:[NSString stringWithFormat:@"%@%@",XY2HTTP,[recom imageurl]]];
        }
        // Carousel
        SDCycleScrollView *cscv = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, CGRectGetWidth([[UIScreen mainScreen] bounds]), CarouselHeight) imageURLStringsGroup:arr];
        cscv.delegate = self;
        cscv.pageControlAliment = SDCycleScrollViewPageContolAlimentRight;  // dot on right
        cscv.autoScrollTimeInterval = 5.0;
        [image addSubview:cscv];
        
    }else {
        height = 40;
    }
    CGSize size = CGSizeMake([[UIScreen mainScreen] bounds].size.width, height);
    return size;
}
#pragma mark ---- 轮播代理
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index {
      NSMutableArray *m_url = @[].mutableCopy;
    NSMutableArray *m_image = @[].mutableCopy;
    for (XYZRecommendModel *recom in self.carouselImageArray) {
        [m_url addObject:[recom url]];
        [m_image addObject:[NSString stringWithFormat:@"%@%@",XY2HTTP,[recom imageurl]]];
        
    }
    NSString *mp4Url;
    NSString *i_mage;
    switch (index) {
        case 0: {
            mp4Url = m_url[0];
            i_mage = m_image[0];
        }
            break;
        case 1: {
            mp4Url = m_url[1];
            i_mage = m_image[1];
        }
            break;
        case 2: {
            mp4Url = m_url[2];
            i_mage = m_image[2];
        }
            break;
        case 3: {
            mp4Url = m_url[3];
            i_mage = m_image[3];
        }
            break;
        case 4: {
            mp4Url = m_url[4];
            i_mage = m_image[4];
        }
            break;
        default:
            break;
    }
    XYZPlayerViewController *player = [[XYZPlayerViewController alloc] init];
    player.mp4Url = mp4Url;
    player.picImage = i_mage;
    player.indexMask = INDEXMASKNO;
    player.iamgePic = SECONIMAGE;  
    UINavigationController *nac = [[UINavigationController alloc] initWithRootViewController:player];
    [self presentViewController:nac animated:YES completion:nil];
}
#pragma mark -- 选中cell
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSString *str;
    NSString *picImage;
    if (indexPath.section == 0) {
        XYZRecommendModel *recom = self.recomment4[indexPath.row];
        str = recom.url;
        picImage = recom.imageurl;
    }else if (indexPath.section == 1) {
        XYZRecommendModel *recom = self.recomment0[indexPath.row];
        str = recom.url;
        picImage = recom.imageurl;
    }else if (indexPath.section == 2) {
        XYZRecommendModel *recom = self.recomment1[indexPath.row];
        str = recom.url;
        picImage = recom.imageurl;
    }else if (indexPath.section == 3) {
        XYZRecommendModel *recom = self.recomment2[indexPath.row];
        str = recom.url;
        picImage = recom.imageurl;
    }else {
        XYZRecommendModel *recom = self.recomment3[indexPath.row];
        str = recom.url;
        picImage = recom.imageurl;
    }
    XYZPlayerViewController *player = [[XYZPlayerViewController alloc] init];
    player.mp4Url = str;
    player.picImage = picImage;
    player.indexMask = INDEXMASKNO;
    player.iamgePic = SECONIMAGENO;  // 需要前缀
    UINavigationController *nac = [[UINavigationController alloc] initWithRootViewController:player];
    [self presentViewController:nac animated:YES completion:nil];
}




@end
