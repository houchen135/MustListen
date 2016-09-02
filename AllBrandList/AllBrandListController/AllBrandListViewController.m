//
//  AllBrandListViewController.m
//  MustListen
//
//  Created by 侯琛 on 16/8/12.
//  Copyright © 2016年 MustListen. All rights reserved.
//

#import "AllBrandListViewController.h"
#import "AllBrandListTableViewCell.h"
#import "AllProductOfBrandViewController.h"
#import "ProductNameSelectView.h"
#import "UMMobClick/MobClick.h"
#import "UIImageView+WebCache.h"
@interface AllBrandListViewController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>
@property (nonatomic,strong)NSMutableArray *allBrandListArr;
@property (nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)ProductNameSelectView *productNameSelectView;
@property(nonatomic,strong)UIView *touchOver;
@end

@implementation AllBrandListViewController
- (NSMutableArray *)allBrandListArr
{
    if (!_allBrandListArr) {
        _allBrandListArr =[[NSMutableArray alloc]init];
    }
    return _allBrandListArr;
}
-(ProductNameSelectView *)productNameSelectView
{
    if (!_productNameSelectView) {
        _productNameSelectView =[[[NSBundle mainBundle]loadNibNamed:@"ProductNameSelectView" owner:self options:nil]lastObject];
        _productNameSelectView.frame =CGRectMake(0, 0, WIDTH(WINDOW), 73+64);
        _productNameSelectView.selectMessage.delegate=self;
        _productNameSelectView.selectMessage.keyboardType=UIReturnKeyDefault;
    }
    return _productNameSelectView;
}
- (void)viewWillAppear:(BOOL)animated
{
    // 修改navigationController背景色为纯白
    self.navigationController.navigationBar.barTintColor =[UIColor whiteColor];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor blackColor]}];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyBoardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [MobClick beginLogPageView:@"AllBrandListPage"];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [[NSNotificationCenter defaultCenter]removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [super viewWillDisappear:animated];
    [MobClick endLogPageView:@"AllBrandListPage"];
}
- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView =[[UITableView alloc]initWithFrame:CGRectMake(0, 0, WIDTH(WINDOW), HEIGHT(WINDOW)-64) style:UITableViewStylePlain];
        _tableView.delegate=self;
        _tableView.dataSource=self;
        _tableView.separatorStyle =UITableViewCellSeparatorStyleNone;
    }
    return _tableView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setNavigationTitleViewWithIconName:@"MustListen"];
//    [self setNavigationBarRightBtnWithImageName:@"search2.png"];
    [self setNavigationBarLeftBtnWithImageName:@"back2.png"];
    [self creatUi];
    [self getUrl];
}
- (void)creatUi{
//    [self.view addSubview:self.productNameSelectView];
    [self.view addSubview:self.tableView];
}
- (void)getUrl{
    [self sendGetRequestWithUrl:[NSString stringWithFormat:@"%@/appdata/brand/getBrandByName?name=%@",BaseUrl,self.productNameSelectView.selectMessage.text] andParameters:nil andBlock:^(NSDictionary *result, NSError *error) {
        if (result) {
            NSMutableArray *arr =(NSMutableArray *)result;
            for (NSDictionary *dic in arr) {
                [self.allBrandListArr addObject:dic];
            }
            if (self.allBrandListArr.count == arr.count) {
                [self.tableView reloadData];
            }
        }
    }];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return WIDTH(WINDOW)/4;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.allBrandListArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellName =@"AllBrandListTableViewCellName";
    AllBrandListTableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:cellName];
    if (cell==nil) {
        cell =[[[NSBundle mainBundle]loadNibNamed:@"AllBrandListTableViewCell" owner:self options:nil]lastObject];
        UIView *a=[[UIView alloc]initWithFrame:CGRectMake(0, 0, WIDTH(WINDOW), 0.5)];
        a.backgroundColor =[UIColor blackColor];
//        [cell addSubview:a];
        
        
        
        UIView *b=[[UIView alloc]initWithFrame:CGRectMake(0, WIDTH(WINDOW)/4-0.5, WIDTH(WINDOW), 0.5)];
        b.backgroundColor =[UIColor blackColor];
//        [cell addSubview:b];
        
        
        
        NSMutableDictionary *dic =self.allBrandListArr[indexPath.row];
        NSMutableDictionary *dic1 =dic[@"ad_brand"];
        [cell.icon sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",BaseUrl,dic1[@"logo3"]]] placeholderImage:nil];
        
        
    }
    cell.selectionStyle=NO;
    return cell;
}
- (void)textFieldDidBeginEditing:(UITextField *)textField{
    self.productNameSelectView.selectIcon.hidden=YES;
    self.productNameSelectView.selectTitle.hidden=YES;
}
- (void)textFieldDidEndEditing:(UITextField *)textField{
    if(self.productNameSelectView.selectMessage.text.length == 0){
        self.productNameSelectView.selectIcon.hidden=NO;
        self.productNameSelectView.selectTitle.hidden=NO;
    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    AllProductOfBrandViewController *allProductOfBrandViewController =[[AllProductOfBrandViewController alloc]init];
    allProductOfBrandViewController.brandMessageDic=self.allBrandListArr[indexPath.row];
    [self.navigationController pushViewController:allProductOfBrandViewController animated:YES];
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    
    [self.productNameSelectView.selectMessage resignFirstResponder];
    [_touchOver removeFromSuperview];
}
-(void)keyBoardWillShow:(NSNotification *)notification{
    NSDictionary *dict = notification.userInfo;
    NSValue *aValue = [dict objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardRect = [aValue CGRectValue];
    _touchOver =[[UIView alloc]initWithFrame:CGRectMake(0, 73, WIDTH(WINDOW), HEIGHT(WINDOW)-73-64-keyboardRect.size.height)];
    [self.view addSubview:_touchOver];
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{

    if ([string isEqualToString:@"\n"]) {//按下return键
        //这里隐藏键盘，不做任何处理
        [textField resignFirstResponder];
        return NO;
    }else if (1 == range.length){
        // 按下空格
        if (0 == textField.text.length) {
            return NO;
        }else{
            [self getUrl];
            return YES;
        }
    }else{
        [self getUrl];
        return YES;
    }
    
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
