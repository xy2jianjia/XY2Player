//
//  XYZNextChannelController.m
//  XY2Player
//
//  Created by zxs on 16/3/22.
//  Copyright © 2016年 YSKS.cn. All rights reserved.
//

#import "XYZNextChannelController.h"
#import "XYZNexChannelCell.h"
@interface XYZNextChannelController ()<UICollectionViewDataSource,UICollectionViewDelegate> {
    UICollectionView *_collectionViews;
}
@property (nonatomic, strong) NSMutableArray *dateArray;
@end

@implementation XYZNextChannelController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.dateArray = @[].mutableCopy;
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"backIcon"]
                                                                             style:UIBarButtonItemStylePlain
                                                                            target:self
                                                                            action:@selector(leftAction:)];
    [self requCollection];
    [self clickRequest];
}

- (void)clickRequest {
    
    [BlockSort setRequestUrlStr:[NSString stringWithFormat:@"%@/remoteActive/getChannelVideos?userid=82621&version=1.0.0&page=1&column=%@",XY2HTTP,self.channelId] successMethod:^(NSDictionary *requestDic, id responseObject) {
        NSArray *dicArray = requestDic[@"items"];
        for (NSDictionary *channelDic in dicArray) {
            XYZNextChannel *next = [[XYZNextChannel alloc] init];
            [next setValuesForKeysWithDictionary:channelDic];
            [self.dateArray addObject:next];
        }
        [_collectionViews reloadData];
    } failMethod:^(AFHTTPRequestOperation *operation, NSError *error) {
        BlockSort *block = [[BlockSort alloc] initWithView:self.view];
        [block setRefrecurrentUrl:[NSString stringWithFormat:@"%@/remoteActive/getChannelVideos?userid=82621&version=1.0.0&page=1&column=%@",XY2HTTP,self.channelId] Success:^(id responseCode) {
            [self clickRequest];
        }];
    }];
    
    
}
- (void)leftAction:(UIBarButtonItem *)sender {
    [self dismissViewControllerAnimated:true completion:nil];
}
- (void)requCollection {
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    // item大小
    layout.itemSize = CGSizeMake(ImageWidth, ImageHeight+20);
    layout.minimumLineSpacing = TandBspacing;  // 上下间距
    layout.minimumInteritemSpacing = LRspacing;  // 左右间距
    layout.scrollDirection = UICollectionViewScrollDirectionVertical; // 设置滚动方向
    layout.sectionInset = UIEdgeInsetsMake(10, Leftspacing, 0, Rightspacing);  // top left bottom right
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
    XYZNextChannel *next = self.dateArray[indexPath.row];
    [cell setModelWithNextChannel:next];
    return cell;
}
#pragma mark -- 选中cell
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    XYZNextChannel *yySub = self.dateArray[indexPath.row];
    XYZPlayerViewController *player = [[XYZPlayerViewController alloc] init];
    player.mp4Url = yySub.url;
    player.indexMask = INDEXMASKNO;
    player.iamgePic = SECONIMAGENO; // 需要前缀
    player.picImage = yySub.imageurl;
    UINavigationController *nac = [[UINavigationController alloc] initWithRootViewController:player];
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
        
    }
    lastOffsetY = scrollView.contentOffset.y;
}
@end
