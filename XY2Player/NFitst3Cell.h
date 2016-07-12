//
//  NFitst3Cell.h
//  XY2
//
//  Created by 朱瀦潴 on 16/3/9.
//  Copyright (c) 2016年 xy2. All rights reserved.
//

#import <UIKit/UIKit.h>
@class NFitst3Cell;
@protocol NFirst3Delegate <NSObject>

- (void)setClick3:(NFitst3Cell *)click topTag:(NSInteger)tag;

@end
@interface NFitst3Cell : UITableViewCell {
    UIButton *_image;
}

@property (weak, nonatomic) id<NFirst3Delegate>firstDelegate;
@property (strong, nonatomic) NSMutableArray *buttonArray;
- (void)setSubiect:(NSMutableArray *)firPic;
+ (CGFloat)first3CellHeight;
@end
