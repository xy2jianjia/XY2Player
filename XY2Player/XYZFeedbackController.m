//
//  XYZFeedbackController.m
//  XY2Player
//
//  Created by zxs on 16/3/28.
//  Copyright © 2016年 YSKS.cn. All rights reserved.
//

#import "XYZFeedbackController.h"
#import "XYZFeedView.h"
@interface XYZFeedbackController ()
@property (nonatomic, strong) XYZFeedView *s_feedView;
@end

@implementation XYZFeedbackController
- (void)loadView {
    self.s_feedView = [[XYZFeedView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.view = self.s_feedView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    __weak typeof(self) weakSelf = self;
    self.s_feedView.s_block = ^(NSInteger inter_block) {
        if (inter_block == 10) {
            [weakSelf showHint:@"提交成功"];
            [weakSelf.s_feedView.s_textView setText:@""];
        }
    };
}

// 点击空白处隐藏按钮
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.s_feedView.s_textView resignFirstResponder];
}

@end
