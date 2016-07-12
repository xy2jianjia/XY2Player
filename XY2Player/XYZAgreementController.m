//
//  XYZAgreementController.m
//  XY2Player
//
//  Created by zxs on 16/3/29.
//  Copyright © 2016年 YSKS.cn. All rights reserved.
//

#import "XYZAgreementController.h"

@interface XYZAgreementController ()

@end

@implementation XYZAgreementController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSError *error;
    NSString *bnouns = [NSString stringWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"协议" ofType:@"txt"]encoding:NSUTF8StringEncoding error:&error];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, WIDTH-30, HEIGHT)];
    [label setText:bnouns];
    [label setFont:[UIFont systemFontOfSize:15]];
    [label setNumberOfLines:0];
    [self.view addSubview:label];
}



@end
