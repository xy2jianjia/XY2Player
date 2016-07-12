//
//  NFitst3Cell.m
//  XY2
//
//  Created by 朱瀦潴 on 16/3/9.
//  Copyright (c) 2016年 xy2. All rights reserved.
//

#import "NFitst3Cell.h"

@implementation NFitst3Cell



- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.buttonArray = @[].mutableCopy;
        self.contentView.backgroundColor = [UIColor blackColor];
        for (int i = 1; i<=6; i++) {
            _image = [[UIButton alloc] initWithFrame:CGRectMake(i%2>0?5:XYImageWidth+5+5,(i)>2?i%2*XYImageWidthT+i/2*XYImageWidthT-CellHeight:2, XYImageWidth, CellHeight)];
            _image.tag = i;
            [_image addTarget:self action:@selector(imageAction:) forControlEvents:(UIControlEventTouchUpInside)];
            [self.buttonArray addObject:_image];
            [self.contentView addSubview:_image];
        }
    }
    return self;
}

- (void)imageAction:(UIButton *)sender {
    if ([self.firstDelegate respondsToSelector:@selector(setClick3:topTag:)]) {
        [self.firstDelegate setClick3:self topTag:sender.tag];
    }
}
- (void)setSubiect:(NSMutableArray *)firPic {
    if (firPic.count > 0) {
        for (UIButton *button in self.buttonArray) {
            switch (button.tag) {
                case 1: {
                    [BlockSort setURLImage:[NSURL URLWithString:firPic[0]] clickBt:button];
                }
                    break;
                case 2: {
                     [BlockSort setURLImage:[NSURL URLWithString:firPic[1]] clickBt:button];
                }
                    break;
                case 3: {
                     [BlockSort setURLImage:[NSURL URLWithString:firPic[2]] clickBt:button];
                }
                    break;
                case 4: {
                     [BlockSort setURLImage:[NSURL URLWithString:firPic[3]] clickBt:button];
                }
                    break;
                case 5: {
                     [BlockSort setURLImage:[NSURL URLWithString:firPic[4]] clickBt:button];
                }
                    break;
                case 6: {
                     [BlockSort setURLImage:[NSURL URLWithString:firPic[5]] clickBt:button];
                }
                    break;
                default:
                    break;
            }
        }
    }
    
}


+ (CGFloat)first3CellHeight {
    return CellHeight*3+10+4;
}
@end
