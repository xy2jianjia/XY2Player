//
//  BlockSort.m
//  Simple__block
//
//  Created by zxs on 16/2/26.
//  Copyright © 2016年 搜影科技. All rights reserved.
//


#import "BlockSort.h"

@implementation BlockSort

- (instancetype)initWithCodeNum:(NSInteger)num {
    
    if (self = [super init]) {
        _codeNum = num;
    }
    return self;
}

- (NSString *)description {
    
    return [NSString stringWithFormat:@"%ld",_codeNum];
}
- (NSComparisonResult)compareUsingcodeNum:(BlockSort *)cnum {
    
    if (_codeNum < [cnum conum]) { //返回1
        return NSOrderedDescending;
    }else if(_codeNum == [cnum conum]){ //返回0
        return NSOrderedSame;
    }else{        //返回-1
        return NSOrderedAscending;
    }
}
- (NSComparisonResult)compareUsingcodeblood:(BlockSort *)blood {
    
    if (_codeNum > [blood conum]) { //返回1
        return NSOrderedDescending;
    }else if(_codeNum == [blood conum]){ //返回0
        return NSOrderedSame;
    }else{        //返回-1
        return NSOrderedAscending;
    }
}

- (NSInteger)conum {
    
    return _codeNum;
}


+ (NSArray *)setArray:(NSArray *)string {
    NSArray *(^blackArray)() = ^NSArray *(NSArray *name) {
        return [name sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
            if ([obj1 compare:obj2] == NSOrderedDescending ) {
                return NSOrderedDescending;
            }else if ([obj1 compare:obj2] == NSOrderedSame){
                return NSOrderedSame;
            }else{
                return NSOrderedAscending;
            }
        }];
    };
    NSArray *soreArr = blackArray(string);
    return soreArr;
}

+ (NSArray *)setSorted:(NSArray *)sorted {
    NSArray *(^blackPractice)() = ^NSArray*(NSArray *age) {
        return [age sortedArrayUsingSelector:@selector(compare:)];
    };
    NSArray *soreArry = blackPractice(sorted);
    return soreArry;
}
/**
 *  取消点击cell效果方法
 *
 *  @param cellframe cell.frame
 *
 *  @return UIview
 */
+ (UIView *)view_bgscells:(CGRect)cellframe {
    UIView *view_bg = [[UIView alloc]initWithFrame:cellframe];
    view_bg.backgroundColor = [UIColor clearColor];
    return view_bg;
}

+ (BOOL)validateEmail:(NSString *)email
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}

+ (BOOL)validateMobile:(NSString *)mobile
{
    //手机号以13， 15，18开头，八个 \d 数字字符
    NSString *phoneRegex = @"^((13[0-9])|(15[^4,\\D])|(18[0,0-9]))\\d{8}$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    return [phoneTest evaluateWithObject:mobile];
}
/**
 *  加载图片
 *
 *  @param url   NSURL
 *  @param click button
 */
+ (void)setURLImage:(NSURL *)url clickBt:(UIButton *)click{
    __block UIImage *images = nil;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSData *imageData = [NSData dataWithContentsOfURL:url];
        images = [UIImage imageWithData:imageData];
        dispatch_async(dispatch_get_main_queue(), ^{
            [click setBackgroundImage:images forState:(UIControlStateNormal)];
        });
    });
}
/**
 *  AlerController(AlerSheet)
 *
 *  @param alerController UIViewController && UITableViewController
 *  @param action         点击事件
 *  @param chose          点击事件
 *  @param cancel         取消
 *  @param block          block (第一个点击事件处理)
 *  @param choseBlock     choseBlock (第二个点击事件处理)
 */
+ (void)setAlerController:(UIViewController <UITableViewDelegate>*)alerController actionTilte:(NSString *)action choseAction:(NSString *)chose cancel:(NSString *)cancel block:(void(^)(id responseCode))block choseBlock:(void(^)(id choesbk))choseBlock{
    
    dispatch_async(dispatch_get_main_queue(), ^{
        UIAlertController * alertController = [UIAlertController alertControllerWithTitle: nil                                                                             message: nil                                                                       preferredStyle:UIAlertControllerStyleActionSheet];
        [alertController addAction: [UIAlertAction actionWithTitle:action style: UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            block(action);
        }]];
        [alertController addAction: [UIAlertAction actionWithTitle:chose style: UIAlertActionStyleDefault handler:^(UIAlertAction *action){
            choseBlock(action);
        }]];
        [alertController addAction: [UIAlertAction actionWithTitle:cancel style: UIAlertActionStyleCancel handler:nil]];
        
        [alerController presentViewController: alertController animated: YES completion: nil];
    });
}
/**
 *  AlerController
 *
 *  @param alerController UIViewController && UITableViewController
 *  @param alerTitle      标题
 *  @param contentTitle   内容
 *  @param cancel         取消
 *  @param confirm        确认
 *  @param block          block description (第一个点击事件处理)
 *  @param choseBlock     choseBlock description (第二个点击事件处理)
 */
+ (void)choseAlerController:(UIViewController <UITableViewDelegate>*)alerController alerTitle:(NSString *)alerTitle contentTitle:(NSString *)contentTitle cancel:(NSString *)cancel confirm:(NSString *)confirm block:(void(^)(id responseCode))block choseBlock:(void(^)(id choesbk))choseBlock{
    dispatch_async(dispatch_get_main_queue(), ^{
        UIAlertController *aler = [UIAlertController alertControllerWithTitle:alerTitle message:contentTitle preferredStyle:(UIAlertControllerStyleAlert)];
        [alerController presentViewController:aler animated:true completion:nil];
        UIAlertAction *action = [UIAlertAction actionWithTitle:cancel style:(UIAlertActionStyleCancel) handler:^(UIAlertAction * _Nonnull action) {
            block(action);
        }];
        UIAlertAction *actions = [UIAlertAction actionWithTitle:confirm style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
            choseBlock(action);
        }];
        [aler addAction:action];
        [aler addAction:actions];
    });
}


- (instancetype)initWithView:(UIView *)View {
    if (self = [super init]) {
        action = [[UIActivityIndicatorView alloc] init];
        action.center = CGPointMake([[UIScreen mainScreen] bounds].size.width/2, [[UIScreen mainScreen] bounds].size.height/2);
        action.color = [UIColor redColor];
        [View addSubview:action];
    }
    return self;
}
/**
 *  网络中断出现菊花
 *
 *  @param currentUrl 判断当前的网络状况
 *  @param succes     连接成功后调用的方法
 */
- (void)setRefrecurrentUrl:(NSString *)currentUrl Success:(void(^)(id responseCode))succes{
    
    [self asyncTouchNetWorkingWithUrl:currentUrl Success:^(id responseCode) {
        [action stopAnimating]; // 结束旋转
        [action setHidesWhenStopped:YES]; //当旋转结束时隐藏
        succes(responseCode);
    } falure:^(NSError *error) {
        [action startAnimating]; // 开始旋转
        [self setRefrecurrentUrl:currentUrl Success:^(id responseCode) {
            succes(responseCode);
        }];
        return ;
    }];
    
}
- (void)asyncTouchNetWorkingWithUrl:(NSString *)currentUrl Success:(void(^)(id responseCode))succes falure:(void(^)(NSError *error))falure{
    
   AFHTTPRequestOperationManager *headins_manger = [AFHTTPRequestOperationManager manager];
    headins_manger.responseSerializer = [AFHTTPResponseSerializer serializer];
    NSString *loopurlPath = currentUrl;
    [headins_manger GET:loopurlPath parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        succes(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        falure(error);
    }];
    
}
/**
 *  动画
 *
 *  @param value  第一次规划的路线
 *  @param sValue 第二次规划的路线
 *  @param time   时间限制
 *  @param layer  添加动画
 */
+ (void)setKeyframeValue:(CGPoint)value sValue:(CGPoint)sValue time:(NSInteger)time layer:(CALayer *)layer{
    CAKeyframeAnimation *key1 = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    key1.duration = time;
    NSValue *value1 = [NSValue valueWithCGPoint:value];
    NSValue *value2 = [NSValue valueWithCGPoint:sValue];
    key1.values = @[value1,value2];
    [layer addAnimation:key1 forKey:@"key1"];
}

+ (void)setRequestUrlStr:(NSString *)UrlStr successMethod:(void(^)(NSDictionary *requestDic,id responseObject))success failMethod:(void(^)(AFHTTPRequestOperation *operation, NSError *error))fail {
    AFHTTPRequestOperationManager *headins_manger = [AFHTTPRequestOperationManager manager];
    headins_manger.responseSerializer = [AFHTTPResponseSerializer serializer];
    NSString *loopurlPath = UrlStr;
    [headins_manger GET:loopurlPath parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSData *data = operation.responseData;
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:(NSJSONReadingAllowFragments) error:nil];
        success(dict,operation);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        fail(operation,error);
    }];
}
/**
 *  自适应宽度
 *
 *  @param aString 内容
 *
 *  @return 宽度
 */
+ (CGFloat)stringWidth:(NSString *)aString{
    CGRect r = [aString boundingRectWithSize:CGSizeMake(WIDTH+300, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:18.0f]} context:nil];
    return r.size.width;
}

+ (void)alertPayView:(UIView *)s_view {
    WXPayView *wx = [[WXPayView alloc] init];
    [s_view addSubview:wx];
    [UIView animateWithDuration:0.6 animations:^{
        [wx setFrame:CGRectMake(40, HEIGHT/2-200, WIDTH-80, 250)];
    }];
}

#pragma mark ============ 微信支付 ===========

+ (void)sendPay_demo
{
    //{{{
    //本实例只是演示签名过程， 请将该过程在商户服务器上实现
    //创建支付签名对象
    payRequsestHandler *req = [payRequsestHandler alloc] ;
    //初始化支付签名对象
    [req init:APP_ID mch_id:MCH_ID];
    //设置密钥
    [req setKey:PARTNER_ID];
    
    //}}}
    //获取到实际调起微信支付的参数后，在app端调起支付
    NSMutableDictionary *dict = [req sendPay_demo];
    
    if(dict == nil){
        //错误提示
        NSString *debug = [req getDebugifo];
        
        [self alert:@"提示信息" msg:debug];
        
        NSLog(@"%@\n\n",debug);
    }else{
        NSLog(@"%@\n\n",[req getDebugifo]);
        //[self alert:@"确认" msg:@"下单成功，点击OK后调起支付！"];
        
        NSMutableString *stamp  = [dict objectForKey:@"timestamp"];
        
        //调起微信支付
        PayReq* req             = [[PayReq alloc] init];
        req.openID              = [dict objectForKey:@"appid"];
        req.partnerId           = [dict objectForKey:@"partnerid"];
        req.prepayId            = [dict objectForKey:@"prepayid"];
        req.nonceStr            = [dict objectForKey:@"noncestr"];
        req.timeStamp           = stamp.intValue;
        req.package             = [dict objectForKey:@"package"];
        req.sign                = [dict objectForKey:@"sign"];
        
        [WXApi sendReq:req];
    }
}

//客户端提示信息
+ (void)alert:(NSString *)title msg:(NSString *)msg
{
    UIAlertView *alter = [[UIAlertView alloc] initWithTitle:title message:msg delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    
    [alter show];
    
}
@end
