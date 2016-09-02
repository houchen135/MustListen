//
//  HomeViewController.m
//  MustListen
//
//  Created by 侯琛 on 16/8/1.
//  Copyright © 2016年 MustListen. All rights reserved.
//

#import "HomeViewController.h"
#import "MyScrollView.h"
#import "FirstStyleView.h"
#import "ProductStory.h"
#import "ProductStoryViewController.h"
#import "BestPartnerViewController.h"
#import "SingleProductDetailsViewController.h"
#import "AllBrandListViewController.h"
#import "UMMobClick/MobClick.h"
#import "LifeViewController.h"
#import "BestPartnerViewController.h"
@interface HomeViewController ()<UIScrollViewDelegate>
@property(nonatomic,strong)NSMutableArray *magazineArr; // 首页滚轮数据
@property(nonatomic,strong)NSMutableDictionary *bestPartnerDic;   // 首页最佳搭配数据
@property(nonatomic,strong)NSMutableArray *productStoryArray;   //首页推荐品牌故事
@property(nonatomic,strong)UIScrollView *backGroundScrollWiew; // 首页整体的scrollView
@property(nonatomic,strong)MyScrollView *myScrollView; // 首页顶部滚轮
@property(nonatomic,strong)FirstStyleView *firstStyleView; // 专辑与设备搭配
@property(nonatomic,strong)ProductStory *productStoryView;  // 产品故事推荐
@property(nonatomic,strong)UIView *footerView; //底部更多设备按钮背景
@property(nonatomic,assign)CGFloat scrollHeight; //当前背景scrollView偏移量
@end

@implementation HomeViewController
- (NSMutableArray *)magazineArr
{
    if (!_magazineArr) {
        _magazineArr =[[NSMutableArray alloc]init];
    }
    return _magazineArr;
}
- (NSMutableDictionary *)bestPartnerDic
{
    if (!_bestPartnerDic) {
        _bestPartnerDic =[[NSMutableDictionary alloc]init];
    }
    return _bestPartnerDic;
}
- (NSMutableArray *)productStoryArray
{
    if (!_productStoryArray) {
        _productStoryArray =[[NSMutableArray alloc]init];
    }
    return _productStoryArray;
}
- (MyScrollView *)myScrollView
{
    if (!_myScrollView) {
        _myScrollView =[[MyScrollView alloc]initWithFrame:CGRectMake(0,0, WIDTH(WINDOW), 1.13*WIDTH(WINDOW))];
        _myScrollView.backgroundColor=[UIColor whiteColor];
    }
    return _myScrollView;
}
-(UIScrollView *)backGroundScrollWiew
{
    if (!_backGroundScrollWiew) {
        _backGroundScrollWiew =[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, WIDTH(WINDOW), HEIGHT(WINDOW)-64)];
        _backGroundScrollWiew.contentSize=CGSizeMake(WIDTH(WINDOW), 3.16*WIDTH(WINDOW)+65+49);
        _backGroundScrollWiew.showsVerticalScrollIndicator=NO;
        _backGroundScrollWiew.delegate=self;
        _backGroundScrollWiew.backgroundColor = Color(250.0f, 250.0f, 250.0f, 1.0f);;
    }
    return _backGroundScrollWiew;
}
- (FirstStyleView *)firstStyleView
{
    if (!_firstStyleView) {
        _firstStyleView= [[FirstStyleView alloc]initWithFrame:CGRectMake(0, 1.13*WIDTH(WINDOW), WIDTH(WINDOW), WIDTH(WINDOW)*0.9+65)];
        _firstStyleView.backgroundColor=[UIColor whiteColor];
    }
    return _firstStyleView;
}
- (ProductStory *)productStoryView
{
    if (!_productStoryView) {
        _productStoryView =[[ProductStory alloc]initWithFrame:CGRectMake(0, 2.03*WIDTH(WINDOW)+65, WIDTH(WINDOW), WIDTH(WINDOW)*1.13)];
        _productStoryView.userInteractionEnabled=YES;
        _productStoryView.backgroundColor=[UIColor whiteColor];
    }
    return _productStoryView;
}
- (UIView *)footerView
{
    if (!_footerView) {
        _footerView =[[UIView alloc]initWithFrame:CGRectMake(0, HEIGHT(WINDOW)-64-49, WIDTH(WINDOW),49)];
        _footerView.backgroundColor=[UIColor blackColor];
        UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame=CGRectMake(0, 0, WIDTH(WINDOW), 49);
        [btn setTitle:@"所有品牌" forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(allProduct) forControlEvents:UIControlEventTouchUpInside];
        [_footerView addSubview:btn];
        btn.titleLabel.font =[UIFont systemFontOfSize:14];
//        _footerView.alpha=0.9;
    }
    return _footerView;
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    // 修改navigationController背景色为纯白
    self.navigationController.navigationBar.barTintColor =[UIColor whiteColor];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor blackColor]}];
   [MobClick beginLogPageView:@"HomePage"];
    
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [MobClick endLogPageView:@"HomePage"];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setNavigationTitleViewWithIconName:@"MustListen"];
    self.scrollHeight=0;
    [self creatUi];
    [self getUrl];
}
- (void)creatUi{
    __weak typeof(self)  weakSelf=self;
    [self.backGroundScrollWiew addSubview:self.myScrollView];
    self.myScrollView.selectImageNum =^(int a){
        [weakSelf scrollViewSelectViewIndex:a];
    };
    [self.backGroundScrollWiew addSubview:self.firstStyleView];
    self.firstStyleView.selectBestPartner =^(){
        [weakSelf perfectMatch];
    };
    [self.backGroundScrollWiew addSubview:self.productStoryView];
    self.productStoryView.selectImageNum =^(int a){
        [weakSelf productStory:a];
    };
    [self.view addSubview:self.backGroundScrollWiew];
    [self.view addSubview:self.footerView];
    
}
- (void)getUrl{
    NSString *url =[NSString stringWithFormat:@"%@%@",BaseUrl,GetHomeData];
    [self sendGetRequestWithUrl:url andParameters:nil andBlock:^(NSDictionary *result, NSError *error) {
        if (result) {
            self.magazineArr =result[@"home_first"];
            self.bestPartnerDic =result[@"home_second"];
            self.productStoryArray =result[@"home_third"];
            [self.myScrollView makeUi:self.magazineArr];
            [self.firstStyleView makeUiWith:self.bestPartnerDic];
            [self.productStoryView makeUi:self.productStoryArray];
        }
    }];
}
// 底部更多产品按钮的隐藏和出现
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat y =scrollView.contentOffset.y;
    if(y>0){
        if (y<3.16*WIDTH(WINDOW)+65+49) {
            if (self.scrollHeight < y) {
                [UIView animateWithDuration:0.3 animations:^{
                    self.footerView.frame = CGRectMake(0, HEIGHT(WINDOW)-64, WIDTH(WINDOW),49);
                }];
            }else{
                [UIView animateWithDuration:0.4 animations:^{
                    self.footerView.frame = CGRectMake(0, HEIGHT(WINDOW)-64-49, WIDTH(WINDOW),49);
                }];
            }
            
        }else{
        }
        self.scrollHeight=y;
    }else{
        
    }
}
// 更多品牌跳转
- (void)allProduct{
    AllBrandListViewController *allBrandListViewController =[[AllBrandListViewController alloc]init];
    [self.navigationController pushViewController:allBrandListViewController animated:YES];
}
// 最佳搭配的跳转
- (void)perfectMatch{
    BestPartnerViewController *productStoryViewController =[[BestPartnerViewController alloc]init];
    productStoryViewController.urlId=[NSString stringWithFormat:@"%@",self.bestPartnerDic[@"second_id"]];
    [self.navigationController pushViewController:productStoryViewController animated:YES];
}
// 产品故事跳转
- (void)productStory:(int)a{
    ProductStoryViewController *productStoryViewController =[[ProductStoryViewController alloc]init];
    productStoryViewController.baseMessageDic =self.productStoryArray[a];
    [self.navigationController pushViewController:productStoryViewController animated:YES];
}
//  顶部滚轮点击跳转
- (void)scrollViewSelectViewIndex:(int)index{
    NSMutableDictionary *dic =self.magazineArr[index];
    LifeViewController *lifeViewController =[[LifeViewController alloc]init];
    lifeViewController.urlId=[NSString stringWithFormat:@"%@",dic[@"first_id"]];
    [self.navigationController pushViewController:lifeViewController animated:YES];
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
