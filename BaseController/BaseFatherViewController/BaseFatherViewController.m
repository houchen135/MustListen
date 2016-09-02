//
//  BaseFatherViewController.m
//  MustListen
//
//  Created by 侯琛 on 16/8/1.
//  Copyright © 2016年 MustListen. All rights reserved.
//

#import "BaseFatherViewController.h"
#import "AFMustListenSessionManager.h"

@interface BaseFatherViewController ()

@end

@implementation BaseFatherViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = Color(241.0f, 241.0f, 241.0f, 1.0f);
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark -----------网络请求------------
#pragma mark -----------POST网络请求------------
- (void)sendPostRequestWithUrl:(NSString *)UrlStr andParameters:(NSDictionary *)parameters andBlock:(void (^)(NSDictionary * result, NSError *error))block{
    
    
    if(parameters == nil){
        parameters = [[NSDictionary alloc]init];
    }
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy defaultPolicy];
    securityPolicy.allowInvalidCertificates = YES;
    securityPolicy.validatesDomainName = NO;
    [manager setSecurityPolicy:securityPolicy];
    
    
    [manager POST:UrlStr parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if(!responseObject){
            
            return ;
        }
        
        NSError *serializationError;
        
        id serialObj = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:&serializationError];
        NSDictionary *dict = (NSDictionary *)serialObj;
        
        if(block){
            block(dict,nil);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if(block){
            
            block(nil,error);
        }
    }];

}
#pragma mark -----------GET网络请求------------
- (void)sendGetRequestWithUrl:(NSString *)UrlStr andParameters:(NSDictionary *)parameters andBlock:(void (^)(NSDictionary * result, NSError *error))block{
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy defaultPolicy];
    securityPolicy.allowInvalidCertificates = YES;
    securityPolicy.validatesDomainName = NO;
    [manager setSecurityPolicy:securityPolicy];
    
    [manager GET:UrlStr parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if(!responseObject){
            //没有数据
            
            return ;
        }
        
        NSError *serializationError;
        id serialObj = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:&serializationError];
        if(block){
            block (serialObj,nil);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if(block){
            
            block(nil,error);
            
        }
    }];
}
# pragma  mark ----------设置导航Title--------
- (void)setNavigationTitle:(NSString *)title{
    self.navigationItem.title = title;

}
# pragma mark -------设置导航TitleView--------
- (void)setNavigationTitleView:(UIView *)titleView{

    self.navigationItem.titleView = titleView;
}
# pragma mark -------设置导航TitleView(根据icon)--------
- (void)setNavigationTitleViewWithIconName:(NSString *)iconName{
    
    UIView *back =[[UIView alloc]initWithFrame:CGRectMake((WIDTH(WINDOW)-200)/2, 0, 200, 25)];
    UIImageView *icon =[[UIImageView alloc]initWithFrame:CGRectMake(0, 5, 200, 20)];
    [icon setImage:[UIImage imageNamed:iconName]];
    [back addSubview:icon];
    self.navigationItem.titleView = back;
}
//---------------------------设置导航左按钮-------------------------
# pragma mark ---根据按钮Title名字 设置导航左按钮---
- (void)setNavigationBarLeftBtnWitBtnTitle:(NSString *)BtnTitle{
    
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    leftBtn.frame = CGRectMake(0,0,NavigationBarBtnSizeWide, NavigationBarBtnSizeHeight);
    leftBtn.titleLabel.font = [UIFont systemFontOfSize:NavigationBarBtnTitleFont];
    [leftBtn addTarget:self action:@selector(NavigationBarLeftBarButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [leftBtn setTitle:BtnTitle forState:UIControlStateNormal];
    UIBarButtonItem *leftBarBtn = [[UIBarButtonItem alloc]initWithCustomView:leftBtn];
    self.navigationItem.leftBarButtonItem = leftBarBtn;
    
//
    
    UIView *homeButtonView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 40, 40)];
    UIImageView *homeButtonImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
    homeButtonImageView.image = [UIImage imageNamed:@"nav_btn_home_ipad.png"];
    UIButton *homeButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 40, 40)];
    homeButton.backgroundColor = [UIColor clearColor];
    [homeButton addTarget:self action:@selector(NavigationBarLeftBarButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [homeButtonView addSubview:homeButtonImageView];
    [homeButtonView addSubview:homeButton];
    //创建home按钮
    UIBarButtonItem *homeButtonItem = [[UIBarButtonItem alloc]initWithCustomView:homeButtonView];
    self.navigationItem.leftBarButtonItem=homeButtonItem;

    
    
    
}

# pragma mark ---根据按钮图片名字 设置导航左按钮---
- (void)setNavigationBarLeftBtnWithImageName:(NSString *)imageStr{
    
//    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    leftBtn.frame = CGRectMake(0,0,NavigationBarBtnSizeWide, NavigationBarBtnSizeHeight);
//    [leftBtn addTarget:self action:@selector(NavigationBarLeftBarButtonAction:)
//      forControlEvents:UIControlEventTouchUpInside];
//    UIImageView *icon = [[UIImageView alloc]initWithFrame:CGRectMake(X(leftBtn)+10, Y(leftBtn)+10, 20, 20)];
//    [icon setImage:[UIImage imageNamed:imageStr]];
//    UIView *backBtnView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH(leftBtn), HEIGHT(leftBtn))];
//    [backBtnView addSubview:icon];
//    [backBtnView addSubview:leftBtn];
//    UIBarButtonItem *leftBarBtn = [[UIBarButtonItem alloc]initWithCustomView:backBtnView];
//    self.navigationItem.leftBarButtonItem = leftBarBtn;

    
    
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    /**
     *  设置frame只能控制按钮的大小
     */
    [btn setImage:[UIImage imageNamed:imageStr] forState:UIControlStateNormal];
    btn.frame= CGRectMake(0, 0, 20, 20);
    [btn addTarget:self action:@selector(NavigationBarLeftBarButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *btn_right = [[UIBarButtonItem alloc] initWithCustomView:btn];
    UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]
                                       initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                       target:nil action:nil];
    /**
     *  width为负数时，相当于btn向右移动width数值个像素，由于按钮本身和边界间距为5pix，所以width设为-5时，间距正好调整
     *  为0；width为正数时，正好相反，相当于往左移动width数值个像素
     */
    negativeSpacer.width = -8;
    self.navigationItem.leftBarButtonItems = [NSArray arrayWithObjects:negativeSpacer, btn_right, nil];
    
}
# pragma mark ------设置导航左按钮（多个）-------
- (void)setNavigationBarLeftBtnsWithImageNameArr:(NSArray *)imageNameArr{
    NSMutableArray *btnArray = [[NSMutableArray alloc]init];
    for (int i = 0; i < imageNameArr.count;i++) {
        
        NSString *imageStr = imageNameArr[i];
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(0,0,23, 23);
        [btn setBackgroundImage:[UIImage imageNamed:imageStr] forState:UIControlStateNormal];
        btn.tag = BaseTag + i;
        [btn addTarget:self action:@selector(NavigationBarLeftBarButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        [btnArray addObject:btn];
    }
    self.navigationItem.leftBarButtonItems = btnArray;
    
    
}
#pragma mark - 导航左按钮 点击事件  ---已在 .h 中声明 可在子类中直接调用
- (void)NavigationBarLeftBarButtonAction:(UIButton *)tmpBtn{
    [self.navigationController popViewControllerAnimated:YES];
}

# pragma mark ----根据按钮Title名字 设置导航右按钮------
- (void)setNavigationBarRightBtnWitBtnTitle:(NSString *)BtnTitle{
    
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.frame = CGRectMake(0,0,70, NavigationBarBtnSizeHeight + 15);
    rightBtn.titleLabel.textAlignment = NSTextAlignmentRight;
    rightBtn.titleLabel.font = [UIFont systemFontOfSize:NavigationBarBtnTitleFont];
    [rightBtn addTarget:self action:@selector(NavigationBarRightBarButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [rightBtn setTitle:BtnTitle forState:UIControlStateNormal];
    [rightBtn setTitleColor:[UIColor colorWithRed:255.0/255.0 green:82.0/255.0 blue:79.0/255.0 alpha:1.0f] forState:UIControlStateNormal];
    UIBarButtonItem *rightBarBtn = [[UIBarButtonItem alloc]initWithCustomView:rightBtn];
    self.navigationItem.rightBarButtonItem = rightBarBtn;
    rightBtn.contentEdgeInsets = UIEdgeInsetsMake(0, 0, 0, -48);
    
}
# pragma mark ---根据按钮图片名字 设置导航右按钮---
- (void)setNavigationBarRightBtnWithImageName:(NSString *)imageStr{
    
//    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    rightBtn.frame = CGRectMake(10,0,NavigationBarBtnSizeWide, NavigationBarBtnSizeHeight);
//    [rightBtn addTarget:self action:@selector(NavigationBarRightBarButtonAction:) forControlEvents:UIControlEventTouchUpInside];
//    UIImageView *icon = [[UIImageView alloc]initWithFrame:CGRectMake(X(rightBtn)+20, Y(rightBtn)+10, 20, 20)];
//    [icon setImage:[UIImage imageNamed:imageStr]];
//    UIView *backBtnView = [[UIView alloc] initWithFrame:rightBtn.bounds];
//    [backBtnView addSubview:icon];
//    [backBtnView addSubview:rightBtn];
//    
//    UIBarButtonItem *rightBarBtn = [[UIBarButtonItem alloc]initWithCustomView:backBtnView];
//    self.navigationItem.rightBarButtonItem = rightBarBtn;
    
    
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    /**
     *  设置frame只能控制按钮的大小
     */
    [btn setImage:[UIImage imageNamed:imageStr] forState:UIControlStateNormal];
    btn.frame= CGRectMake(0, 0, 20, 20);
    [btn addTarget:self action:@selector(NavigationBarRightBarButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *btn_right = [[UIBarButtonItem alloc] initWithCustomView:btn];
    UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]
                                       initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                       target:nil action:nil];
    /**
     *  width为负数时，相当于btn向右移动width数值个像素，由于按钮本身和边界间距为5pix，所以width设为-5时，间距正好调整
     *  为0；width为正数时，正好相反，相当于往左移动width数值个像素
     */
    negativeSpacer.width = -8;
    self.navigationItem.rightBarButtonItems = [NSArray arrayWithObjects:negativeSpacer, btn_right, nil];
}
# pragma mark -----设置导航右按钮（多个）-------
- (void)setNavigationBarRightBtnsWithImageNameArr:(NSArray *)imageNameArr{
    
//    NSMutableArray *btnArray = [[NSMutableArray alloc]init];
    
    
    
    UIView *rightBackView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, NavigationBarBtnSizeWide*imageNameArr.count, NavigationBarBtnSizeHeight)];
    
    for (int i = 0; i < imageNameArr.count;i++) {
        
        UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        rightBtn.frame = CGRectMake(NavigationBarBtnSizeWide*i,0,NavigationBarBtnSizeWide, NavigationBarBtnSizeHeight);
        [rightBtn addTarget:self action:@selector(NavigationBarRightBarButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        UIImageView *icon = [[UIImageView alloc]initWithFrame:CGRectMake(X(rightBtn)+20, Y(rightBtn)+10, 20, 20)];
        [icon setImage:[UIImage imageNamed:imageNameArr[i]]];
        rightBtn.tag = BaseTag + i;
        [rightBackView addSubview:icon];
        [rightBackView addSubview:rightBtn];
        
        
        
        
//        NSString *imageStr = imageNameArr[i];
//        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
//        btn.frame = CGRectMake(-10,0,20, 20);
//        [btn setImage:[UIImage imageNamed:imageStr] forState:UIControlStateNormal];
//        btn.tag = BaseTag + i;
//        [btn addTarget:self action:@selector(NavigationBarRightBarButtonAction:) forControlEvents:UIControlEventTouchUpInside];
//        UIBarButtonItem *rightBarBtn = [[UIBarButtonItem alloc]initWithCustomView:btn];
//        [btnArray addObject:rightBarBtn];
        
    }
    UIBarButtonItem *rightBarBtn = [[UIBarButtonItem alloc]initWithCustomView:rightBackView];
    self.navigationItem.rightBarButtonItem =rightBarBtn;
}
#pragma mark ------导航右按钮 点击事件---------
- (void)NavigationBarRightBarButtonAction:(UIButton *)tmpBtn{
    if (tmpBtn.tag == BaseTag) {
        
    }else if(tmpBtn.tag == BaseTag + 1){
        
    }
}
#pragma mark ----------判断网络状态------------
- (NSString *)getNetWorkStates{
    UIApplication *app = [UIApplication sharedApplication];
    NSArray *children = [[[app valueForKeyPath:@"statusBar"]valueForKeyPath:@"foregroundView"]subviews];
    NSString *state = [[NSString alloc]initWithFormat:@"无网络"];
    int netType = 0;
    //获取到网络返回码
    for (id child in children) {
        if ([child isKindOfClass:NSClassFromString(@"UIStatusBarDataNetworkItemView")]) {
            //获取到状态栏
            netType = [[child valueForKeyPath:@"dataNetworkType"]intValue];
            
            switch (netType) {
                case 0:
                    state = @"无网络";
                    break;
                case 1:
                    state = @"2G";
                    break;
                case 2:
                    state = @"3G";
                    break;
                case 3:
                    state = @"4G";
                    break;
                case 5:
                {
                    state = @"WIFI";
                }
                    break;
                default:
                    break;
            }
        }
    }
    //根据状态选择
    return state;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
