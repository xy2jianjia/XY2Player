//
//  XYZFeedView.h
//  XY2Player
//
//  Created by zxs on 16/3/28.
//  Copyright © 2016年 YSKS.cn. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^tempBlock)(NSInteger s_tag);
@interface XYZFeedView : UIView {
    UILabel *s_content;
    UIButton *s_dot;
    UILabel *s_title;
    UIButton *s_submit;  // 提交
}
@property (nonatomic, strong) UITextView *s_textView;
@property (nonatomic, strong) NSArray *s_titleArray;
@property (nonatomic, strong) NSMutableArray *s_dotArray;
@property (nonatomic, copy)tempBlock s_block;
@end
