//
//  NFitst2Cell.m
//  XY2
//
//  Created by 朱瀦潴 on 16/3/9.
//  Copyright (c) 2016年 xy2. All rights reserved.
//

#import "NFitst2Cell.h"

@implementation NFitst2Cell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.contentView.backgroundColor = [UIColor blackColor];
        _first = [[UIButton alloc] initWithFrame:CGRectMake(5, 2, XYImageWidth, CellHeight*2+5)];
        _first.tag = 0;
        [_first addTarget:self action:@selector(firstAction:) forControlEvents:(UIControlEventTouchUpInside)];
        [self.contentView addSubview:_first];
        
        _secon = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_first.frame)+5, 2, XYImageWidth, CellHeight)];
        _secon.tag = 1;
        [_secon addTarget:self action:@selector(seconAction:) forControlEvents:(UIControlEventTouchUpInside)];
        [self.contentView addSubview:_secon];
        
        _thirt = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_first.frame)+5, CGRectGetMaxY(_secon.frame)+5, XYImageWidth, CellHeight)];
        _thirt.tag = 2;
        [_thirt addTarget:self action:@selector(thirtAction:) forControlEvents:(UIControlEventTouchUpInside)];
        [self.contentView addSubview:_thirt];
        
        _fours = [[UIButton alloc] initWithFrame:CGRectMake(5, CGRectGetMaxY(_thirt.frame)+5, XYImageWidth, CellHeight)];
        _fours.tag = 3;
        [_fours addTarget:self action:@selector(foursAction:) forControlEvents:(UIControlEventTouchUpInside)];
        [self.contentView addSubview:_fours];
        
        _fites = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_fours.frame)+5, CGRectGetMinY(_fours.frame), XYImageWidth, CellHeight)];
        _fites.tag = 4;
        [_fites addTarget:self action:@selector(fitesAction:) forControlEvents:(UIControlEventTouchUpInside)];
        [self.contentView addSubview:_fites];
        
    }
    return self;
}
- (void)firstAction:(UIButton *)sender {
    if ([self.firstDelegate respondsToSelector:@selector(setClick2:topTag:)]) {
        [self.firstDelegate setClick2:self topTag:sender.tag];
    }
}
- (void)seconAction:(UIButton *)sender {
    if ([self.firstDelegate respondsToSelector:@selector(setClick2:topTag:)]) {
        [self.firstDelegate setClick2:self topTag:sender.tag];
    }
}
- (void)thirtAction:(UIButton *)sender {
    if ([self.firstDelegate respondsToSelector:@selector(setClick2:topTag:)]) {
        [self.firstDelegate setClick2:self topTag:sender.tag];
    }
}
- (void)foursAction:(UIButton *)sender {
    if ([self.firstDelegate respondsToSelector:@selector(setClick2:topTag:)]) {
        [self.firstDelegate setClick2:self topTag:sender.tag];
    }
}
- (void)fitesAction:(UIButton *)sender {
    if ([self.firstDelegate respondsToSelector:@selector(setClick2:topTag:)]) {
        [self.firstDelegate setClick2:self topTag:sender.tag];
    }
}
+ (CGFloat)first2CellHeight {
    return CellHeight*2+5+CellHeight+5+4;
}
- (void)setModelWithfirs:(NSMutableArray *)firstModel {
    if (firstModel.count>0) {
        [BlockSort setURLImage:[NSURL URLWithString:firstModel[0]] clickBt:_first];
        [BlockSort setURLImage:[NSURL URLWithString:firstModel[1]] clickBt:_secon];
        [BlockSort setURLImage:[NSURL URLWithString:firstModel[2]] clickBt:_thirt];
        [BlockSort setURLImage:[NSURL URLWithString:firstModel[3]] clickBt:_fours];
        [BlockSort setURLImage:[NSURL URLWithString:firstModel[4]] clickBt:_fites];
    }
}

@end
