//
//  BlockSort.h
//  Simple__block
//
//  Created by zxs on 16/2/26.
//  Copyright © 2016年 搜影科技. All rights reserved.
//
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

#ifdef DEBUG // 调试阶段
#define XMGLog(...)  NSLog(__VA_ARGS__)

#else // 发布阶段

#define XMGLog(...)

#endif

@interface BlockSort : NSObject {
    NSInteger _codeNum;  // 编码
    UIActivityIndicatorView *action;
}
#pragma mark -- 给字典排序
- (instancetype)initWithCodeNum:(NSInteger)num;
- (NSComparisonResult)compareUsingcodeNum:(BlockSort *)cnum;
- (NSComparisonResult)compareUsingcodeblood:(BlockSort *)blood;
- (NSInteger)conum;
#pragma mark -- 排序(返回一个排序好的数组)
+ (NSArray *)setArray:(NSArray *)string;
+ (NSArray *)setSorted:(NSArray *)sorted;
#pragma mark -- 自定义取消点击cell效果方法   //[cell setSelectedBackgroundView:[ToolView view_bgscells:cell.frame]]
+ (UIView *)view_bgscells:(CGRect)cellframe;
#pragma mark -- 邮箱正则
+ (BOOL) validateEmail:(NSString *)email;
#pragma mark -- 手机正则
+ (BOOL) validateMobile:(NSString *)mobile;
#pragma mark -- 给button添加网络图片
+ (void)setURLImage:(NSURL *)url clickBt:(UIButton *)click;
#pragma mark -- sheetAlerController
+ (void)setAlerController:(UIViewController <UITableViewDelegate>*)alerController actionTilte:(NSString *)action choseAction:(NSString *)chose cancel:(NSString *)cancel block:(void(^)(id responseCode))block choseBlock:(void(^)(id choesbk))choseBlock;
+ (void)choseAlerController:(UIViewController <UITableViewDelegate>*)alerController alerTitle:(NSString *)alerTitle contentTitle:(NSString *)contentTitle cancel:(NSString *)cancel confirm:(NSString *)confirm block:(void(^)(id responseCode))block choseBlock:(void(^)(id choesbk))choseBlock;
#pragma mark -- 网络旋转菊花
- (instancetype)initWithView:(UIView *)View;
- (void)setRefrecurrentUrl:(NSString *)currentUrl Success:(void(^)(id responseCode))succes;
#pragma mark -- 规划路线动画
+ (void)setKeyframeValue:(CGPoint)value sValue:(CGPoint)sValue time:(NSInteger)time layer:(CALayer *)layer;
#pragma mark -- AF
+ (void)setRequestUrlStr:(NSString *)UrlStr successMethod:(void(^)(NSDictionary *requestDic,id responseObject))success failMethod:(void(^)(AFHTTPRequestOperation *operation, NSError *error))fail;
#pragma mark -- 自适应宽度
+ (CGFloat)stringWidth:(NSString *)aString;
+ (void)alertPayView:(UIView *)s_view;
+ (void)sendPay_demo;
@end
