//
//  DHFirstViewController.m
//  XY2
//
//  Created by xy2 on 16/3/8.
//  Copyright © 2016年 xy2. All rights reserved.
//

#import "DHFirstViewController.h"
#import "NFitst2Cell.h"
#import "NFitst3Cell.h"
#import "XYZ_HZRecommendDao.h"
@interface DHFirstViewController ()<NFirst2Delegate,NFirst3Delegate,SDCycleScrollViewDelegate>
@property (nonatomic, strong) NSMutableArray *carouselImage;
@property (nonatomic, strong) NSMutableArray *date1Array;
@property (nonatomic, strong) NSMutableArray *date2Array;
@property (nonatomic, strong) NSMutableArray *date3Array;
@property (nonatomic, strong) NSMutableArray *date4Array;
@property (nonatomic, strong) NSMutableArray *model0Array;
@property (nonatomic, strong) NSMutableArray *model1Array;
@property (nonatomic, strong) NSMutableArray *model2Array;
@property (nonatomic, strong) NSMutableArray *model3Array;
@property (nonatomic, strong) NSMutableArray *modelcarous;
@end

@implementation DHFirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor blackColor];
    
    self.carouselImage = @[].mutableCopy;
    self.date1Array = @[].mutableCopy;   // 存值用
    self.date2Array = @[].mutableCopy;
    self.date3Array = @[].mutableCopy;
    self.date4Array = @[].mutableCopy;
    self.model0Array = @[].mutableCopy;  // 传图片用
    self.model1Array = @[].mutableCopy;
    self.model2Array = @[].mutableCopy;
    self.model3Array = @[].mutableCopy;
    self.modelcarous = @[].mutableCopy;
    [self dateRequest];
    self.tableView.showsVerticalScrollIndicator = false;
    [self.tableView registerClass:[NFitst2Cell class] forCellReuseIdentifier:@"cell2"];
    [self.tableView registerClass:[NFitst3Cell class] forCellReuseIdentifier:@"cell3"];
}

- (void)dateRequest {
    
    [BlockSort setRequestUrlStr:[NSString stringWithFormat:@"%@/remoteActive/userActive?channelID=023&userid=82621&version=1.0.0&sign=0932723CA19D003BDE4F4ADAE6B5EEF3",XY2HTTP] successMethod:^(NSDictionary *requestDic, id responseObject) {
        [[NSUserDefaults standardUserDefaults] setObject:requestDic[@"imgurl"] forKey:@"httpImageUrl"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    } failMethod:^(AFHTTPRequestOperation *operation, NSError *error) {
        XMGLog(@"%@",error);
    }];
    [BlockSort setRequestUrlStr:[NSString stringWithFormat:@"%@web/getvodindex/os/1",XY2HTTP1] successMethod:^(NSDictionary *requestDic, id responseObject) {
        NSArray *carousel = requestDic[@"lb"];  // 轮播
        NSArray *t1Array = requestDic[@"t1"];
        NSArray *t2Array = requestDic[@"t2"];
        NSArray *t3Array = requestDic[@"t3"];
        NSArray *t4Array = requestDic[@"t4"];
        [self setDateWitchArray:carousel mutab:self.carouselImage];
        [self setDateWitchArray:t1Array mutab:self.date1Array];
        [self setDateWitchArray:t2Array mutab:self.date2Array];
        [self setDateWitchArray:t3Array mutab:self.date3Array];
        
        for (NSDictionary *carousdic in t4Array) {
            XYZFirstModel *carousModel = [[XYZFirstModel alloc] init];
            carousModel.title = carousdic[@"title"];
            carousModel.imgurl = carousdic[@"imgurl2"];
            carousModel.videoUrl = carousdic[@"videoUrl"];
            if (![XYZ_HZRecommendDao checkRecommendWithRecommendTitle:carousModel.title]) {
                [XYZ_HZRecommendDao asyncInsertRecommendToDbWithItem:carousModel];
            }
            [self.date4Array addObject:carousModel];
        }
        [self.tableView reloadData];
        [self tableViewHeader];
    } failMethod:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
}

- (void)setDateWitchArray:(NSArray *)array mutab:(NSMutableArray *)mutab {
    for (NSDictionary *carousdic in array) {
        XYZFirstModel *carousModel = [[XYZFirstModel alloc] init];
        carousModel.title = carousdic[@"title"];
        carousModel.imgurl = carousdic[@"imgurl"];
        carousModel.videoUrl = carousdic[@"videoUrl"];
        [mutab addObject:carousModel];
    }
}
/**
 *  MP4
 *
 *  @param dateArrays 所有的。MP4文件
 *  @param videoArray model
 */
- (void)setModelVideo:(NSMutableArray *)dateArrays videoArray:(NSMutableArray *)videoArray {
    for (XYZFirstModel *model in dateArrays) {
        [videoArray addObject:[model videoUrl]];
    }
}
- (void)setClick2:(NFitst2Cell *)click topTag:(NSInteger)tag {
    NSMutableArray *allArray = @[].mutableCopy;
    [self setModelVideo:self.date1Array videoArray:allArray];
    [self setModelVideo:self.date2Array videoArray:allArray];
    [self setModelVideo:self.date3Array videoArray:allArray];
    XYZPlayerViewController *player = [[XYZPlayerViewController alloc] init];
    if (allArray.count > 0) {
        player.mp4Url = allArray[tag];
    }
    player.indexMask = INDEXMASK;
    UINavigationController *nac = [[UINavigationController alloc] initWithRootViewController:player];
    [self presentViewController:nac animated:YES completion:nil];
    
}

- (void)setClick3:(NFitst3Cell *)click topTag:(NSInteger)tag { // 最后一排
    NSMutableArray *allArray = @[].mutableCopy;
    [self setModelmutal:self.date4Array other:allArray];
    XYZPlayerViewController *player = [[XYZPlayerViewController alloc] init];
    NSLog(@"----第一页最后一排---:%@",allArray[tag-1]);
    player.picImage = allArray[tag-1]; // 不需要http
    player.indexMask = INDEXMASKNO;
    player.iamgePic = SECONIMAGE;
    UINavigationController *nac = [[UINavigationController alloc] initWithRootViewController:player];
    [self presentViewController:nac animated:YES completion:nil];
    
}
#pragma mark -- 轮播
- (void)tableViewHeader {
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, CarouselHeight)];
    self.tableView.tableHeaderView = view;
    [self setModelmutal:self.carouselImage other:self.modelcarous];
    // picture run
    if ([self respondsToSelector:@selector(edgesForExtendedLayout)]) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    self.view.userInteractionEnabled=YES;
    // Carousel
    SDCycleScrollView *cscv = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, CGRectGetWidth([[UIScreen mainScreen] bounds]), CarouselHeight) imageURLStringsGroup:self.modelcarous];
    cscv.delegate = self;
    cscv.pageControlAliment = SDCycleScrollViewPageContolAlimentRight;  // dot on right
    cscv.autoScrollTimeInterval = 5.0;
    [view addSubview:cscv];
    
}
#pragma mark ---- 轮播代理
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index {
    NSMutableArray *allArray = @[].mutableCopy;
    [self setModelVideo:self.carouselImage videoArray:allArray];
    XYZPlayerViewController *player = [[XYZPlayerViewController alloc] init];
    player.mp4Url = allArray[index];
    player.indexMask = INDEXMASK;
    UINavigationController *nac = [[UINavigationController alloc] initWithRootViewController:player];
    [self presentViewController:nac animated:YES completion:nil];
}
#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        NFitst2Cell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell2" forIndexPath:indexPath];
        [self setModelmutal:self.date1Array other:self.model0Array];
        [cell setModelWithfirs:self.model0Array];
        cell.firstDelegate = self;
        return cell;
    }else if (indexPath.section == 1) {

        NFitst2Cell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell2" forIndexPath:indexPath];
        cell.firstDelegate = self;
        [self setModelmutal:self.date2Array other:self.model1Array];
        [cell setModelWithfirs:self.model1Array];
        cell.first.tag = 5;cell.secon.tag = 6;
        cell.thirt.tag = 7;cell.fours.tag = 8;cell.fites.tag = 9;
        return cell;
    }else if (indexPath.section == 2) {
        NFitst2Cell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell2" forIndexPath:indexPath];
        cell.firstDelegate = self;
        [self setModelmutal:self.date3Array other:self.model2Array];
        [cell setModelWithfirs:self.model2Array];
        cell.first.tag = 10;cell.secon.tag = 11;
        cell.thirt.tag = 12;cell.fours.tag = 13;cell.fites.tag = 14;
        return cell;
    }else {
        NFitst3Cell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell3" forIndexPath:indexPath];
        cell.firstDelegate = self;
        [self setModelmutal:self.date4Array other:self.model3Array];
        [cell setSubiect:self.model3Array];
        return cell;
    }
}
/**
 *  model
 *
 *  @param mutal 把获取到的分组内容传到cell去显示
 */
- (void)setModelmutal:(NSMutableArray *)mutal other:(NSMutableArray *)other{
    for (XYZFirstModel *model in mutal) {
        [other addObject:[model imgurl]];
    }
}

#pragma mark -- delegata Height
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 3) {
        return [NFitst3Cell first3CellHeight];
    }else  {
        return [NFitst2Cell first2CellHeight];
    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.tableView deselectRowAtIndexPath:indexPath animated:true];
}

#pragma mark --- section header
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 30;
}
- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return [self setWithTitle:@"邻家女孩"];
    }else if (section == 1) {
        return [self setWithTitle:@"女佣少妇"];
    }else if (section == 2) {
        return [self setWithTitle:@"家庭主妇"];
    }else {
        return [self setWithTitle:@"工口直立"];
    }
}

- (UIView *)setWithTitle:(NSString *)title {
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, 30)];
    UIImageView *image = [[UIImageView alloc] initWithFrame:CGRectMake(5, 5, 19, 19)];
//    [image setBackgroundColor:[UIColor grayColor]];
    [image setImage:[UIImage imageNamed:@"burn.png"]];
    [view addSubview:image];
    
    UILabel *labelTex = [[UILabel alloc] init];
    [labelTex setText:title];
    [labelTex setTextColor:kUIColorFromRGB(0x00A5b4)];
    [labelTex setFont:[UIFont systemFontOfSize:15.0f]];
    [view setBackgroundColor:[UIColor clearColor]];
    CGFloat nameW = [self sstringWidth:labelTex.text];
    labelTex.frame = CGRectMake(CGRectGetMaxX(image.frame)+5, 0, nameW, 30);
    [view addSubview:labelTex];
    return view;
}
#pragma mark ---- 自适应宽度
- (CGFloat)sstringWidth:(NSString *)aString{
    CGRect r = [aString boundingRectWithSize:CGSizeMake(200, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:18.0f]} context:nil];
    return r.size.width;
}
#pragma mark --- section header
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    if (section == 3) {
        return 130;
    }return 0;
    
}

@end
