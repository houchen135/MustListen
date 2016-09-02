//
//  ProductStoryViewController.m
//  MustListen
//
//  Created by 侯琛 on 16/8/6.
//  Copyright © 2016年 MustListen. All rights reserved.
//

#import "ProductStoryViewController.h"
#import "FirstProductStoryView.h"
#import "SecondProductStoryView.h"
#import "ThirdProductStoryView.h"
#import "PhotoBroswerVC.h"
#import "AllProductOfBrandViewController.h"
#import "ProductStory.h"
#import "UMMobClick/MobClick.h"
#import "UIImageView+WebCache.h"
#import "SingleProductDetailsViewController.h"
@interface ProductStoryViewController ()<UIScrollViewDelegate>
@property (nonatomic,strong)FirstProductStoryView *firstProductStoryView;
@property(nonatomic,strong)UIScrollView *backGroundScrollWiew;
@property(nonatomic,strong)SecondProductStoryView *secondProductStoryView;
@property(nonatomic,strong)ThirdProductStoryView *thirdProductStoryView;
@property(nonatomic,strong)NSMutableArray *imageArr;
@property(nonatomic,strong)ProductStory *productStoryView;
@property(nonatomic,strong)NSMutableDictionary *productStoryMessage;
@property(nonatomic,strong)NSMutableArray  *brandStoryArr;



@end

@implementation ProductStoryViewController
- (NSMutableDictionary *)baseMessageDic
{
    if (!_baseMessageDic) {
        _baseMessageDic =[[NSMutableDictionary alloc]init];
    }
    return _baseMessageDic;
}
- (NSMutableDictionary *)productStoryMessage
{
    if (!_productStoryMessage) {
        _productStoryMessage =[[NSMutableDictionary alloc]init];
        
    }
    return _productStoryMessage;
}
- (NSMutableArray *)brandStoryArr{
    if (!_brandStoryArr) {
        _brandStoryArr =[[NSMutableArray alloc]init];
    }
    return _brandStoryArr;
}
- (NSMutableArray *)imageArr
{
    if (!_imageArr) {
        _imageArr =[[NSMutableArray alloc]init];
    }
    return _imageArr;
}
- (void)viewWillAppear:(BOOL)animated
{
    // 修改navigationController背景色为纯黑
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    self.navigationController.navigationBar.barTintColor =[UIColor blackColor];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];
    [MobClick beginLogPageView:@"ProductStoryPage"];
}
- (void)viewWillDisappear:(BOOL)animated
{
    [[UIApplication sharedApplication] setStatusBarStyle:
     UIStatusBarStyleDefault];
    [super viewWillDisappear:animated];
    [MobClick endLogPageView:@"ProductStoryPage"];
}
-(UIScrollView *)backGroundScrollWiew
{
    if (!_backGroundScrollWiew) {
        _backGroundScrollWiew =[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, WIDTH(WINDOW), HEIGHT(WINDOW)-64)];
        _backGroundScrollWiew.contentSize=CGSizeMake(WIDTH(WINDOW), 3*(HEIGHT(WINDOW)-64)+WIDTH(WINDOW)*1.13);
        _backGroundScrollWiew.showsVerticalScrollIndicator=NO;
        _backGroundScrollWiew.delegate=self;
        _backGroundScrollWiew.backgroundColor=[UIColor whiteColor];
    }
    return _backGroundScrollWiew;
}
- (FirstProductStoryView *)firstProductStoryView
{
    if (!_firstProductStoryView) {
        _firstProductStoryView =[[[NSBundle mainBundle]loadNibNamed:@"FirstProductStoryView" owner:self options:nil]lastObject];
        _firstProductStoryView.frame =CGRectMake(0, 0, WIDTH(WINDOW), HEIGHT(WINDOW)-64);
    }
    return _firstProductStoryView;
}
- (SecondProductStoryView *)secondProductStoryView
{
    if (!_secondProductStoryView) {
        _secondProductStoryView =[[SecondProductStoryView alloc]initWithFrame:CGRectMake(0, HEIGHT(WINDOW)-64, WIDTH(WINDOW), HEIGHT(WINDOW)-64)];
        _secondProductStoryView.backgroundColor=[UIColor blackColor];
    }
    return _secondProductStoryView;
}
-(ThirdProductStoryView *)thirdProductStoryView
{
    if (!_thirdProductStoryView) {
        _thirdProductStoryView =[[ThirdProductStoryView alloc]initWithFrame:CGRectMake(0, (HEIGHT(WINDOW)-64)*2, WIDTH(WINDOW), HEIGHT(WINDOW)-64)];
    }
    return _thirdProductStoryView;
}
- (ProductStory *)productStoryView
{
    if (!_productStoryView) {
        _productStoryView =[[ProductStory alloc]initWithFrame:CGRectMake(0, (HEIGHT(WINDOW)-64)*3, WIDTH(WINDOW), WIDTH(WINDOW)*1.13)];
        _productStoryView.userInteractionEnabled=YES;
    }
    return _productStoryView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavigationBarLeftBtnWithImageName:@"back1.png"];
//    NSMutableArray *arr =[[NSMutableArray alloc]initWithObjects:@"search1.png",@"heart1.png", nil];
//    [self setNavigationBarRightBtnsWithImageNameArr:arr];
    
    
    
    [self setNavigationBarRightBtnWithImageName:@"heart_01.png"];
    [self getUrl];
    [self setTitleView];
}
- (void)setTitleView{
    UIView *back =[[UIView alloc]initWithFrame:CGRectMake((WIDTH(WINDOW)-200)/2, 0, 200, 20)];
    UIImageView *icon =[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 200, 20)];
    [icon sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",BaseUrl,self.baseMessageDic[@"logo2"]]] placeholderImage:nil];
    [back addSubview:icon];
    self.navigationItem.titleView = back;
    [self.view addSubview:self.backGroundScrollWiew];
}
- (void)getUrl{
    [self sendGetRequestWithUrl:[NSString stringWithFormat:@"%@%@%@",BaseUrl,ProductStoryMessageWithId,self.baseMessageDic[@"third_id"]] andParameters:nil andBlock:^(NSDictionary *result, NSError *error) {
        if (result) {
            
            [self.productStoryMessage setValuesForKeysWithDictionary:result[@"ad_brand"]];
            [self sendGetRequestWithUrl:[NSString stringWithFormat:@"%@%@%@",BaseUrl,ProductStoryPicWithId,self.baseMessageDic[@"third_id"]] andParameters:nil andBlock:^(NSDictionary *result, NSError *error) {
                if (result) {
                    NSArray *arr =(NSArray *)result;
                    if (result.count!=0) {
                        for (NSDictionary *dic in arr) {
                            NSDictionary *dic1 =dic[@"ad_brand_pic"];
                            NSMutableDictionary *picdic =[[NSMutableDictionary alloc]init];
                            if (![dic1[@"pic_content_type"] isEqualToString:@"image/jpeg"]) {
                                [picdic setValue:[NSString stringWithFormat:@"%@/system/pics/adbrand/adbrandpic/%@/original/%@",BaseUrl,dic1[@"id"],dic1[@"pic_file_name"]] forKey:@"picUrl"];
                                [picdic setValue:[NSString stringWithFormat:@"%@/system/pics/adbrand/adbrandpic/%@/thumb/%@",BaseUrl,dic1[@"id"],dic1[@"pic_file_name"]] forKey:@"picUrl_1"];
                            }else{
                                [picdic setValue:[NSString stringWithFormat:@"%@/system/imgs/adbrand/adbrandpic/%@/original/%@",BaseUrl,dic1[@"id"],dic1[@"pic_file_name"]] forKey:@"picUrl"];
                                [picdic setValue:[NSString stringWithFormat:@"%@/system/imgs/adbrand/adbrandpic/%@/thumb/%@",BaseUrl,dic1[@"id"],dic1[@"pic_file_name"]] forKey:@"picUrl_1"];
                            }
                            [picdic setValue:dic1[@"desc"] forKey:@"desc"];
                            [self.imageArr addObject:picdic];
                            if (self.imageArr.count == arr.count) {
                                [self getUrlSecond];
                            }
                        }
                    }else{
                        [self getUrlSecond];
                    }
                }
            }];
        }
        
    }];
    
    
    
}

- (void)getUrlSecond{
    [self sendGetRequestWithUrl:[NSString stringWithFormat:@"%@%@%@",BaseUrl,OtherProductStoryExcept,self.baseMessageDic[@"third_id"]] andParameters:nil andBlock:^(NSDictionary *result, NSError *error) {
        
        if (result) {
            self.brandStoryArr =result[@"home_third"];
            [self.productStoryView makeUi:self.brandStoryArr];
            [self crectUi];
        }
        
    }];
}
- (void)crectUi{
    __weak typeof(self)  weakSelf=self;
    // 故事简介
    self.firstProductStoryView.title.text=self.productStoryMessage[@"pro1"];
    [self.firstProductStoryView makeUiWithMessage:self.productStoryMessage];
    [self.backGroundScrollWiew addSubview:self.firstProductStoryView];
    
    
    
    
    
    // 故事配图加故事详情
    NSString *str=self.productStoryMessage[@"gushi"];
    NSMutableDictionary *dic =[[NSMutableDictionary alloc]init];
    [dic setValue:str forKey:@"message"];
    [dic setValue:self.imageArr forKey:@"imageArr"];
    [self.secondProductStoryView makeUi:dic];
    UILabel *title =[[UILabel alloc]initWithFrame:CGRectMake(70, WIDTH(WINDOW)*0.6*0.3/0.4+40, WIDTH(WINDOW)-90, HEIGHT(WINDOW)-64-WIDTH(WINDOW)*0.6*0.3/0.4-60)];
    CGSize size =[self setLabelSpace:title withValue:str withFont:[UIFont fontWithName:@"STHeitiTC-Light" size:13]];
    self.secondProductStoryView.frame =CGRectMake(0, Y(self.firstProductStoryView)+HEIGHT(self.firstProductStoryView), WIDTH(WINDOW), size.height+WIDTH(WINDOW)*0.6*0.3/0.4+70);
    [self.backGroundScrollWiew addSubview:self.secondProductStoryView];
    self.secondProductStoryView.selectImageNum =^(int a){
        NSLog(@"%d",a);
        [weakSelf checkTheImageWith:a];
    };
    
    
    
    // 里程碑
    self.thirdProductStoryView.frame=CGRectMake(0, Y(self.secondProductStoryView)+HEIGHT(self.secondProductStoryView), WIDTH(WINDOW), HEIGHT(WINDOW)-64);
    [self.backGroundScrollWiew addSubview:self.thirdProductStoryView];
    [self.thirdProductStoryView makeUiWith:dic];
    self.productStoryView.selectImageNum =^(int a){
        [weakSelf productStory:a];
    };
    // 另外一个故事
    self.productStoryView.frame =CGRectMake(0, Y(self.thirdProductStoryView)+HEIGHT(self.thirdProductStoryView), WIDTH(WINDOW), WIDTH(WINDOW)*1.13);
    [self.backGroundScrollWiew addSubview:self.productStoryView];
    
    self.thirdProductStoryView.selectProductNum =^(int a){
        NSLog(@"%d",a);
    };
    self.thirdProductStoryView.moreProduct =^(){
        [weakSelf moreSelfProduct];
    };
    self.backGroundScrollWiew.contentSize=CGSizeMake(WIDTH(WINDOW), Y(self.productStoryView)+HEIGHT(self.productStoryView));
    
}

- (void)checkTheImageWith:(int)a{
    NSArray *imageArr =self.imageArr;
    if (imageArr.count == 0) {
        a =0;
    }
    [PhotoBroswerVC show:self type:PhotoBroswerVCTypeZoom index:a photoModelBlock:^NSArray *{
        
        NSMutableArray *modelsM = [NSMutableArray arrayWithCapacity:imageArr.count];
        for (NSUInteger i = 0; i< imageArr.count; i++) {
            NSDictionary *dic=imageArr[i];
            PhotoModel *pbModel=[[PhotoModel alloc] init];
            pbModel.mid = i + 1;
//            pbModel.title = [NSString stringWithFormat:@"这是标题%@",@(i+1)];
            pbModel.desc = dic[@"desc"];
            pbModel.image_HD_U = dic[@"picUrl"];
            //            查看的图片的小图
            UIImageView *imageV =[self.view viewWithTag:a+232323];
            pbModel.sourceImageView = imageV;
            
            [modelsM addObject:pbModel];
        }
        
        return modelsM;
    }];
}
- (void)productStory:(int)a{
    NSMutableDictionary *dic =self.brandStoryArr[a];
    ProductStoryViewController *productStoryViewController =[[ProductStoryViewController alloc]init];
    productStoryViewController.baseMessageDic =dic;
    [self.navigationController pushViewController:productStoryViewController animated:YES];
}
- (void)selectProductWithNum:(int)a
{
    SingleProductDetailsViewController *singleProductDetailsViewController =[[SingleProductDetailsViewController alloc]init];
    
    [self.navigationController pushViewController:singleProductDetailsViewController animated:YES];
}

- (void)moreSelfProduct{
    AllProductOfBrandViewController *allProductOfBrandViewController =[[AllProductOfBrandViewController alloc]init];
    NSMutableDictionary *dic =[[NSMutableDictionary alloc]init];
    [dic setValue:self.productStoryMessage forKey:@"ad_brand"];
    allProductOfBrandViewController.brandMessageDic =dic;
    [self.navigationController pushViewController:allProductOfBrandViewController animated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(CGSize )setLabelSpace:(UILabel*)label withValue:(NSString*)str withFont:(UIFont*)font {
    NSMutableParagraphStyle *paraStyle = [[NSMutableParagraphStyle alloc] init];
    paraStyle.lineBreakMode = NSLineBreakByCharWrapping;
    paraStyle.lineSpacing = 5.0; //设置行间距
    paraStyle.hyphenationFactor = 1.0;
    paraStyle.firstLineHeadIndent = 0.0;
    paraStyle.paragraphSpacingBefore = 0.0;
    paraStyle.headIndent = 0;
    paraStyle.tailIndent = 0;
    NSDictionary *dic = @{NSFontAttributeName:font, NSParagraphStyleAttributeName:paraStyle, NSKernAttributeName:@1.0f};
    NSAttributedString *attributeStr = [[NSAttributedString alloc] initWithString:str attributes:dic];
    label.attributedText = attributeStr;
    label.numberOfLines=0;
    [label sizeToFit];
    CGSize size =CGSizeMake(label.frame.size.width, label.frame.size.height);
    return size;
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
