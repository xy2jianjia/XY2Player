//
//  XYZMemberController.m
//  XY2Player
//
//  Created by zxs on 16/3/21.
//  Copyright © 2016年 YSKS.cn. All rights reserved.
//

#import "XYZMemberController.h"
#import "XYZFeedbackController.h"
#import "XYZAgreementController.h"
#import "XYZServiceController.h"
#import "XYZMemberCell.h"
@interface XYZMemberController ()
@property (nonatomic, strong) NSArray *titleArray;
@property (nonatomic, strong) NSArray *s_iamgeArray;
@end

@implementation XYZMemberController

- (NSArray *)s_iamgeArray {
    return @[@"s_ervice",@"C_set_12",@"phone_s"];
}

- (NSArray *)titleArray {
    return @[@"意见反馈",@"会员协议",@"联系客服"];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.tableFooterView = [[UIView alloc]init];
//    self.view.backgroundColor = [UIColor blackColor];
    self.title = @"会员专区";
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:YES];
//    self.tabBarController.tabBar.hidden = YES;
    [self.tableView registerClass:[XYZMemberCell class] forCellReuseIdentifier:@"YY"];
    self.navigationController.navigationBar.barTintColor = [UIColor blackColor];
    UIView *footerView = [[UIView alloc]init];
    footerView.frame = CGRectMake(0, 0, CGRectGetWidth([[UIScreen mainScreen] bounds]), CGRectGetHeight([[UIScreen mainScreen] bounds]) - 60*3 -64);
//    footerView.backgroundColor = [UIColor yellowColor];
    
//    UILabel *labelcopyright = [[UILabel alloc]init];
//    labelcopyright.frame = CGRectMake(0, CGRectGetMaxY(footerView.bounds)-120, CGRectGetWidth(footerView.bounds), 40);
//    //    label.backgroundColor = [UIColor greenColor];
//    labelcopyright.font = [UIFont systemFontOfSize:13];
//    labelcopyright.textColor = [UIColor lightGrayColor];
//    labelcopyright.textAlignment = NSTextAlignmentCenter;
//    labelcopyright.text = @"Copyright ©2015-2016";
//    [footerView addSubview:labelcopyright];
//    
//    UILabel *label = [[UILabel alloc]init];
//    label.frame = CGRectMake(0, CGRectGetMaxY(labelcopyright.frame), CGRectGetWidth(footerView.bounds), 40);
////    label.backgroundColor = [UIColor greenColor];
//    label.font = [UIFont systemFontOfSize:13];
//    label.textColor = [UIColor lightGrayColor];
//    label.textAlignment = NSTextAlignmentCenter;
//    label.text = @"东莞市虎门天宇服装厂 版权所有";
//    [footerView addSubview:label];
//    self.tableView.tableFooterView = footerView;
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    XYZMemberCell *cell = [tableView dequeueReusableCellWithIdentifier:@"YY" forIndexPath:indexPath];
    [self.tableView setRowHeight:60];
    [cell s_Image:self.s_iamgeArray[indexPath.row] title:self.titleArray[indexPath.row]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.tableView deselectRowAtIndexPath:indexPath animated:true];
    if (indexPath.row == 0) {
        XYZFeedbackController *feed = [[XYZFeedbackController alloc] init];
        [self.navigationController pushViewController:feed animated:true];
    }else if (indexPath.row == 1){
        XYZAgreementController *agreem = [[XYZAgreementController alloc] init];
        [self.navigationController pushViewController:agreem animated:true];
    }else if (indexPath.row == 2){
        XYZServiceController *service= [[XYZServiceController alloc] init];
        [self.navigationController pushViewController:service animated:true];
    }
}


@end
