//
//  XYZMaskView.h
//  XY2Player
//
//  Created by zxs on 16/3/30.
//  Copyright © 2016年 YSKS.cn. All rights reserved.
//

#import <UIKit/UIKit.h>
@class XYZMaskView;
@protocol maskViewDelegate <NSObject>

- (void)clickMine:(XYZMaskView *)mask indexInteger:(NSInteger)index;

@end
@interface XYZMaskView : UIView {
    UIImageView *_playerImage;
    
}
@property (nonatomic ,strong) UIButton *stateButton;
@property (nonatomic ,strong) UILabel *timeLabel;
@property (nonatomic ,strong) UISlider *videoSlider;
@property (nonatomic ,strong) UIButton *start_pause;  // 居中按钮
@property (nonatomic ,weak)id<maskViewDelegate>s_maskDelegate;
- (void)sets_Image:(NSString *)image;
@end
