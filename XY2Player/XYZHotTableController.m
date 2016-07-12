//
//  XYZHotTableController.m
//  XY2Player
//
//  Created by zxs on 16/3/21.
//  Copyright © 2016年 YSKS.cn. All rights reserved.
//  成为会员专享特权优惠

#import "XYZHotTableController.h"
#import "XYZHotViewCell.h"
#import "XYZ_HZHotDao.h"

@interface XYZHotTableController () 
@property (nonatomic, strong) NSMutableArray *dateArray;
@end

@implementation XYZHotTableController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"火热频道";
    self.dateArray = @[].mutableCopy;
    self.view.backgroundColor = [UIColor colorWithWhite:0.980 alpha:1];
    self.tableView.separatorStyle = UITableViewCellEditingStyleNone;
    [self.tableView registerClass:[XYZHotViewCell class] forCellReuseIdentifier:@"XY"];
    [self clickRequest];
}

- (void)clickRequest {
    
    [BlockSort setRequestUrlStr:[NSString stringWithFormat:@"%@/remoteActive/getColumnInfo?userid=82621&version=1.0.0&type=1",XY2HTTP] successMethod:^(NSDictionary *requestDic, id responseObject) {
        NSArray *yyArray = requestDic[@"items"];
        for (NSDictionary *hotdic in yyArray) {
            XYZHotModel *yySub = [[XYZHotModel alloc] init];
            [yySub setValuesForKeysWithDictionary:hotdic];
            if (![XYZ_HZHotDao checkHotWithHottId:[NSString stringWithFormat:@"%@",yySub.id]]) {
                [XYZ_HZHotDao asyncInsertHotToDbWithItem:yySub];
            }
            
            [self.dateArray addObject:yySub];
        }
        [self.tableView reloadData];
    } failMethod:^(AFHTTPRequestOperation *operation, NSError *error) {
        BlockSort *block = [[BlockSort alloc] initWithView:self.view];
        [block setRefrecurrentUrl:[NSString stringWithFormat:@"%@/remoteActive/getColumnInfo?userid=82621&version=1.0.0&type=1",XY2HTTP] Success:^(id responseCode) {
            [self clickRequest];
        }];
    }];
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dateArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    XYZHotModel *yySub = self.dateArray[indexPath.section];
    XYZHotViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"XY" forIndexPath:indexPath];
    [cell setHotModel:yySub];
    [self.tableView setRowHeight:120];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.tableView deselectRowAtIndexPath:indexPath animated:true];
    XYZHotModel *yySub = self.dateArray[indexPath.section];
    XYZPlayerViewController *player = [[XYZPlayerViewController alloc] init];
    player.mp4Url = yySub.url;
    player.indexMask = INDEXMASK;
    UINavigationController *nac = [[UINavigationController alloc] initWithRootViewController:player];
    [self presentViewController:nac animated:YES completion:nil];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if(self.tableView != scrollView)
        return;
    if(scrollView.frame.size.height >= self.tableView.contentSize.height)
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
            self.tableView.frame = CGRectMake(0, 20, WIDTH, HEIGHT);
        }
        
    }else if(self.navigationController.navigationBar.frame.origin.y < [UIApplication sharedApplication].statusBarFrame.size.height  &&
             (self.tableView.contentSize.height > self.tableView.contentOffset.y + self.tableView.frame.size.height)){
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
