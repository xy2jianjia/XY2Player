//
//  XYZChannelController.m
//  XY2Player
//
//  Created by zxs on 16/3/21.
//  Copyright © 2016年 YSKS.cn. All rights reserved.
//

#import "XYZChannelController.h"
#import "XYZChannelCell.h"
#import "XYZChanelReusView.h"
#import "XYZNextChannelController.h"

@interface XYZChannelController () <UICollectionViewDataSource,UICollectionViewDelegate> {
    UICollectionView *_collectionViews;
    NSString *_urlImage;
}
@property (nonatomic,strong) NSMutableArray *dateArray;
@end

@implementation XYZChannelController
static NSString *kheaderIdentifier = @"headerIdentifier";
- (void)viewDidLoad {
    [super viewDidLoad];
//    _collectionViews.backgroundColor = [UIColor blackColor];
    self.navigationItem.title = @"两性频道";
    self.dateArray = @[].mutableCopy;
    [self clickRequest];
    [self requCollection];
    
}

- (void)clickRequest {
    [BlockSort setRequestUrlStr:[NSString stringWithFormat:@"%@/remoteActive/getColumnInfo?userid=82621&version=1.0.0&type=2",XY2HTTP] successMethod:^(NSDictionary *requestDic, id responseObject) {
        NSArray *dicArray = requestDic[@"columns"];
        _urlImage = requestDic[@"imgurl"];
        for (NSDictionary *channelDic in dicArray) {
            XYZChannel *channel = [[XYZChannel alloc] init];
            [channel setValuesForKeysWithDictionary:channelDic];
            [self.dateArray addObject:channel];
        }
        [_collectionViews reloadData];
    } failMethod:^(AFHTTPRequestOperation *operation, NSError *error) {
        BlockSort *block = [[BlockSort alloc] initWithView:self.view];
        [block setRefrecurrentUrl:[NSString stringWithFormat:@"%@/remoteActive/getColumnInfo?userid=82621&version=1.0.0&type=2",XY2HTTP] Success:^(id responseCode) {
            [self clickRequest];
        }];
    }];
}
- (void)requCollection {
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    // item大小
    layout.itemSize = CGSizeMake(ImageWidth, ImageHeight+30);
    layout.minimumLineSpacing = TandBspacing;  // 上下间距
    layout.minimumInteritemSpacing = LRspacing;  // 左右间距
    layout.scrollDirection = UICollectionViewScrollDirectionVertical; // 设置滚动方向
    layout.sectionInset = UIEdgeInsetsMake(10, Leftspacing, 0, Rightspacing);  // top left bottom right
    // header
    layout.headerReferenceSize = CGSizeMake(WIDTH, 0);
    
    _collectionViews = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];
    _collectionViews.backgroundColor = [UIColor blackColor];
    
    _collectionViews.delegate = self;
    _collectionViews.dataSource = self;
    [self.view addSubview:_collectionViews];
    [_collectionViews registerClass:[XYZChannelCell class] forCellWithReuseIdentifier:@"cell"];
#pragma mark -- 注册头部视图
    [_collectionViews registerClass:[XYZChanelReusView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:kheaderIdentifier];
}
#pragma mark dataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dateArray.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    XYZChannelCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    XYZChannel *channel = self.dateArray[indexPath.row];
    [cell setModelWithXYZChannel:channel];
    return cell;
}
#pragma mark -- 定制头部视图的内容
-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    UICollectionReusableView *reusableView = nil;
    if (kind == UICollectionElementKindSectionHeader) {
        XYZChanelReusView *header = (XYZChanelReusView *)[collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:kheaderIdentifier forIndexPath:indexPath];
        reusableView = header;
    }
    return reusableView;
}

#pragma mark -- 返回头headerView的大小
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    CGFloat height;
    if (section == 0) {
        height = CarouselHeight;
        UIImageView *image = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, CarouselHeight)];
        [image sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",XY2HTTP,_urlImage]] placeholderImage:[UIImage imageNamed:@""] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            
        }];
        [collectionView addSubview:image];
    }
    CGSize size = CGSizeMake([[UIScreen mainScreen] bounds].size.width, height);
    return size;
}

#pragma mark -- 选中cell
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    XYZChannel *channel = self.dateArray[indexPath.row];
    XYZNextChannelController *next = [[XYZNextChannelController alloc] init];
    next.channelId = channel.id;
    UINavigationController *nac = [[UINavigationController alloc] initWithRootViewController:next];
    nac.navigationBar.barTintColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"xy2_navagation.png"]];
    [nac.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    [self presentViewController:nac animated:YES completion:nil];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if(_collectionViews != scrollView)
        return;
    if(scrollView.frame.size.height >= _collectionViews.contentSize.height)
        return;
    if(scrollView.contentOffset.y > -self.navigationController.navigationBar.frame.size.height && scrollView.contentOffset.y < 0)
        scrollView.contentInset = UIEdgeInsetsMake(-scrollView.contentOffset.y, 0, 0, 0);
    
    else if(scrollView.contentOffset.y >= 0)
        scrollView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
    
    
    if(lastOffsetY < scrollView.contentOffset.y && scrollView.contentOffset.y >= -self.navigationController.navigationBar.frame.size.height){//moving up
        
        if(self.navigationController.navigationBar.frame.size.height + self.navigationController.navigationBar.frame.origin.y  > 0){//not yet hidden
            //不隐藏
            float newY = self.navigationController.navigationBar.frame.origin.y - (scrollView.contentOffset.y - lastOffsetY);
            if(newY < -self.navigationController.navigationBar.frame.size.height)
                newY = -self.navigationController.navigationBar.frame.size.height;
            self.navigationController.navigationBar.frame = CGRectMake(self.navigationController.navigationBar.frame.origin.x,
                                                                       newY,
                                                                       self.navigationController.navigationBar.frame.size.width,
                                                                       self.navigationController.navigationBar.frame.size.height);
            self.tabBarController.tabBar.hidden = YES;
            _collectionViews.frame = CGRectMake(0, 20, WIDTH, HEIGHT);
        }
        
    }else if(self.navigationController.navigationBar.frame.origin.y < [UIApplication sharedApplication].statusBarFrame.size.height  &&
             (_collectionViews.contentSize.height > _collectionViews.contentOffset.y + _collectionViews.frame.size.height)){
        //不显示
        float newY = self.navigationController.navigationBar.frame.origin.y + (lastOffsetY - scrollView.contentOffset.y);
        if(newY > [UIApplication sharedApplication].statusBarFrame.size.height)
            newY = [UIApplication sharedApplication].statusBarFrame.size.height;
        self.navigationController.navigationBar.frame = CGRectMake(self.navigationController.navigationBar.frame.origin.x,
                                                                   newY,
                                                                   self.navigationController.navigationBar.frame.size.width,
                                                                   self.navigationController.navigationBar.frame.size.height);
        self.tabBarController.tabBar.hidden = NO;
    }
    if (scrollView.contentOffset.y <= 0) {
        self.tabBarController.tabBar.hidden = NO;
    }
    lastOffsetY = scrollView.contentOffset.y;
}

@end
