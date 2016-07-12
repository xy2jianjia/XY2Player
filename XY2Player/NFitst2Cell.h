//
//  NFitst2Cell.h
//  XY2
//
//  Created by 朱瀦潴 on 16/3/9.
//  Copyright (c) 2016年 xy2. All rights reserved.
//

#import <UIKit/UIKit.h>

@class NFitst2Cell;
@protocol NFirst2Delegate <NSObject>

- (void)setClick2:(NFitst2Cell *)click topTag:(NSInteger)tag;

@end
@interface NFitst2Cell : UITableViewCell
@property (nonatomic, strong) UIButton *first;
@property (nonatomic, strong) UIButton *secon;
@property (nonatomic, strong) UIButton *thirt;
@property (nonatomic, strong) UIButton *fours;
@property (nonatomic, strong) UIButton *fites;
@property (weak, nonatomic) id<NFirst2Delegate>firstDelegate;

- (void)setModelWithfirs:(NSMutableArray *)firstModel;
+ (CGFloat)first2CellHeight;

@end
