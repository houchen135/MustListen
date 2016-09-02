//
//  LifeViewController.m
//  MustListen
//
//  Created by 侯琛 on 16/8/26.
//  Copyright © 2016年 MustListen. All rights reserved.
//

#import "LifeViewController.h"
#import "UMMobClick/MobClick.h"
@interface LifeViewController ()<UIWebViewDelegate>
@property (nonatomic,strong)UIWebView *webView;

@end

@implementation LifeViewController
- (void)viewWillAppear:(BOOL)animated
{
    // 修改navigationController背景色为纯白
    self.navigationController.navigationBar.barTintColor =[UIColor whiteColor];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor blackColor]}];
    [MobClick beginLogPageView:@"SingleProductDetailsPage"];
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [MobClick endLogPageView:@"SingleProductDetailsPage"];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavigationBarLeftBtnWithImageName:@"back2.png"];
    [self setNavigationBarRightBtnWithImageName:@"heart_02.png"];
    [self setNavigationTitleViewWithIconName:@"MustListen"];
    // Do any additional setup after loading the view.
    [self creatUi];
}
- (void)creatUi{
    _webView =[[UIWebView alloc]initWithFrame:CGRectMake(0, 0, WIDTH(WINDOW), HEIGHT(WINDOW)-64)];
    [self.view addSubview:_webView];
    _webView.scalesPageToFit=YES;
    _webView.delegate=self;
    NSURL *url =[[NSURL alloc]initWithString:[NSString stringWithFormat:@"%@%@%@",BaseUrl,H5PageUrlMag,self.urlId]];
    NSURLRequest *resquest =[[NSMutableURLRequest alloc]initWithURL:url];
    [_webView loadRequest:resquest];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
