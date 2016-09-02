//
//  AllProductOfBrandViewController.m
//  MustListen
//
//  Created by 侯琛 on 16/8/12.
//  Copyright © 2016年 MustListen. All rights reserved.
//

#import "AllProductOfBrandViewController.h"
#import "ProductCollectionViewCell.h"
#import "ProductReusableView.h"
#import "SingleProductDetailsViewController.h"
#import "UMMobClick/MobClick.h"
#import "UIImageView+WebCache.h"
#import "SelectProductKindTableViewCell.h"
#import "ProductReusableViewFooter.h"
@interface AllProductOfBrandViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UIScrollViewDelegate,UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong)NSMutableArray *allBrandListArr;
@property(nonatomic,strong)UIView *productKindBackView;
@property(nonatomic,strong)UIView *productKindBackViewHeader;
@property(nonatomic,strong)UICollectionView *productCollrctionView;
@property(nonatomic,assign)CGFloat productCollrctionViewHeigth;
@property(nonatomic,assign)BOOL ifTouchSelect;
@property(nonatomic,strong)UIImageView *trademarkIcon;
@property (nonatomic,strong)NSMutableArray *allBrandListArrCopy;
@property (nonatomic,strong)UIButton *sure;
@property (nonatomic,strong)UIButton *allSelect;
@property (nonatomic,strong)UITableView *tableView;
@end

@implementation AllProductOfBrandViewController
-(NSMutableDictionary *)brandMessageDic
{
    if (!_brandMessageDic) {
        _brandMessageDic =[[NSMutableDictionary alloc]init];
    }
    return _brandMessageDic;
}
- (NSMutableArray *)allBrandListArr
{
    if (!_allBrandListArr) {
        _allBrandListArr =[[NSMutableArray alloc]init];
    }
    return _allBrandListArr;
}
- (NSMutableArray *)allBrandListArrCopy
{
    if (!_allBrandListArrCopy) {
        _allBrandListArrCopy =[[NSMutableArray alloc]init];
    }
    return _allBrandListArrCopy;
}
- (UIView *)productKindBackViewHeader
{
    if (!_productKindBackViewHeader) {
        _productKindBackViewHeader =[[UIView alloc]initWithFrame:CGRectMake(0,0, WIDTH(WINDOW), (HEIGHT(WINDOW)-64)/2)];
        _productKindBackViewHeader.backgroundColor =[UIColor clearColor];
        _productKindBackViewHeader.userInteractionEnabled=YES;
        UITapGestureRecognizer *tap =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(removeProductKindBackView)];
        [_productKindBackViewHeader addGestureRecognizer:tap];
        
    }
    return _productKindBackViewHeader;
}
- (UICollectionView *)productCollrctionView
{
    if (!_productCollrctionView ){
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
        layout.itemSize = CGSizeMake((WIDTH(WINDOW)-30)/2,((WIDTH(WINDOW)-30)/2-30)*5/4+58);
        layout.minimumInteritemSpacing = 0;
        layout.minimumLineSpacing = 0;
        layout.headerReferenceSize=CGSizeMake(WIDTH(WINDOW)-30, 56);
        _productCollrctionView=[[UICollectionView alloc]initWithFrame:CGRectMake(15, 40, WIDTH(WINDOW)-30, HEIGHT(WINDOW)-64-40) collectionViewLayout:layout];
        _productCollrctionView.delegate=self;
        _productCollrctionView.dataSource=self;
        _productCollrctionView.showsVerticalScrollIndicator = NO;
        [_productCollrctionView registerNib:[UINib nibWithNibName:@"ProductCollectionViewCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"ProductCollectionViewCellName"];
        _productCollrctionView.backgroundColor=Color(255, 255, 255, 1);
        
        
        [_productCollrctionView registerClass:[ProductReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"ProductReusableViewName"];
        [_productCollrctionView registerClass:[ProductReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"ProductReusableViewFotterName"];

        

    }
    return _productCollrctionView;
}
- (UIView *)productKindBackView
{
    if (!_productKindBackView) {
        _productKindBackView =[[UIView alloc]initWithFrame:CGRectMake(0, HEIGHT(WINDOW)-64-40, WIDTH(WINDOW), (HEIGHT(WINDOW)-64)/2)];
        _productKindBackView.backgroundColor=[UIColor clearColor];
        UIView *a =[[UIView alloc]initWithFrame:CGRectMake(0, 0, WIDTH(WINDOW), (HEIGHT(WINDOW)-64)/2)];
        a.backgroundColor=[UIColor whiteColor];
        a.alpha=0.95;
        [_productKindBackView addSubview:a];
        
        
        UIView *b=[[UIView alloc]initWithFrame:CGRectMake(0, 0, WIDTH(WINDOW), 40)];
        b.backgroundColor=[UIColor blackColor];
        [_productKindBackView addSubview:b];
        UILabel *lable =[[UILabel alloc]initWithFrame:CGRectMake(50, 0, WIDTH(WINDOW)-100, 40)];
        lable.font =[UIFont fontWithName:@"STHeitiTC-Light" size:14];
        lable.textAlignment=NSTextAlignmentCenter;
        lable.textColor=[UIColor whiteColor];
        lable.backgroundColor=[UIColor blackColor];
        lable.text=@"筛选";
        [_productKindBackView addSubview:lable];
        lable.userInteractionEnabled=YES;
        UITapGestureRecognizer *tap =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(selectionAction)];
        [lable addGestureRecognizer:tap];
        
        
        _allSelect =[UIButton buttonWithType:UIButtonTypeCustom];
        _allSelect.frame =CGRectMake(0, 0, 50, 40);
        [_allSelect setTitle:@"清空" forState:UIControlStateNormal];
        [_allSelect setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_allSelect addTarget:self action:@selector(selectAllKind) forControlEvents:UIControlEventTouchUpInside];
        _allSelect.titleLabel.font =[UIFont fontWithName:@"STHeitiTC-Light" size:14];
        _allSelect.backgroundColor=[UIColor blackColor];
        [_productKindBackView addSubview:_allSelect];
        
        _sure =[UIButton buttonWithType:UIButtonTypeCustom];
        _sure.frame =CGRectMake(WIDTH(WINDOW)-50, 0, 50, 40);
        [_sure setTitle:@"确定" forState:UIControlStateNormal];
        [_sure setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_sure addTarget:self action:@selector(sureAction) forControlEvents:UIControlEventTouchUpInside];
        _sure.titleLabel.font =[UIFont fontWithName:@"STHeitiTC-Light" size:14];
        _sure.backgroundColor=[UIColor blackColor];
        [_productKindBackView addSubview:_sure];
        
        
        
        _tableView =[[UITableView alloc]initWithFrame:CGRectMake(0, 40, WIDTH(WINDOW), (HEIGHT(WINDOW)-64)/2-40) style:UITableViewStylePlain];
        _tableView.delegate =self;
        _tableView.dataSource=self;
        [_productKindBackView addSubview:_tableView];
        _tableView.bounces=NO;
        _tableView.separatorStyle =NO;
        _allSelect.hidden=YES;
        _sure.hidden=YES;

    }
    return _productKindBackView;
}
- (UIImageView *)trademarkIcon{
    if (!_trademarkIcon) {
        _trademarkIcon=[[UIImageView alloc]initWithFrame:CGRectMake((WIDTH(WINDOW)-300)/2, 5, 300, 30)];
    }
    return _trademarkIcon;
}
- (void)viewWillAppear:(BOOL)animated
{
    // 修改navigationController背景色为纯白
    self.navigationController.navigationBar.barTintColor =[UIColor whiteColor];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor blackColor]}];
    [MobClick beginLogPageView:@"AllProductListPage"];
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [MobClick endLogPageView:@"AllProductListPage"];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setNavigationTitleViewWithIconName:@"MustListen"];
//    [self setNavigationBarRightBtnWithImageName:@"search2.png"];
    [self setNavigationBarLeftBtnWithImageName:@"back2.png"];
    self.ifTouchSelect =NO;
    self.view.backgroundColor=[UIColor whiteColor];

    
    
    NSString *jsonName;
    NSError *error;
    NSString *filePath;
    if ([self.brandMessageDic[@"ad_brand"][@"id"] integerValue] == 1) {
        
    }else if ([self.brandMessageDic[@"ad_brand"][@"id"] integerValue] == 2){
        jsonName =@"shure";
        filePath = [[NSBundle mainBundle]pathForResource:jsonName ofType:@"json"];
        //根据文件路径读取数据
        NSData *jdata = [[NSData alloc]initWithContentsOfFile:filePath];
        //格式化成json数据
        id jsonObject = [NSJSONSerialization JSONObjectWithData:jdata options:NSJSONReadingMutableContainers error:&error];
        
        
        self.allBrandListArr =(NSMutableArray *)jsonObject;
        for (NSMutableDictionary *dic in self.allBrandListArr) {
            [dic setObject:@"0" forKey:@"ifSelected"];
        }
        self.allBrandListArrCopy =self.allBrandListArr;
    }else if ([self.brandMessageDic[@"ad_brand"][@"id"] integerValue] == 3){
        jsonName =@"harman";
        filePath = [[NSBundle mainBundle]pathForResource:jsonName ofType:@"json"];
        //根据文件路径读取数据
        NSData *jdata = [[NSData alloc]initWithContentsOfFile:filePath];
        //格式化成json数据
        id jsonObject = [NSJSONSerialization JSONObjectWithData:jdata options:NSJSONReadingMutableContainers error:&error];
        
        
        self.allBrandListArr =(NSMutableArray *)jsonObject;
        for (NSMutableDictionary *dic in self.allBrandListArr) {
            [dic setObject:@"0" forKey:@"ifSelected"];
        }
        self.allBrandListArrCopy =self.allBrandListArr;
    }else if ([self.brandMessageDic[@"ad_brand"][@"id"] integerValue] == 4){
        
    }else if ([self.brandMessageDic[@"ad_brand"][@"id"] integerValue] == 5){
        jsonName =@"beoplay";
        filePath = [[NSBundle mainBundle]pathForResource:jsonName ofType:@"json"];
        //根据文件路径读取数据
        NSData *jdata = [[NSData alloc]initWithContentsOfFile:filePath];
        //格式化成json数据
        id jsonObject = [NSJSONSerialization JSONObjectWithData:jdata options:NSJSONReadingMutableContainers error:&error];
        
        
        self.allBrandListArr =(NSMutableArray *)jsonObject;
        for (NSMutableDictionary *dic in self.allBrandListArr) {
            [dic setObject:@"0" forKey:@"ifSelected"];
        }
        self.allBrandListArrCopy =self.allBrandListArr;
    }else if ([self.brandMessageDic[@"ad_brand"][@"id"] integerValue] == 6){
        
    }else if ([self.brandMessageDic[@"ad_brand"][@"id"] integerValue] == 7){
        
    }
    

    
    
    
    
    
    
    [self creatUi];
}
- (void)creatUi{
    UIView *trademarkView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, WIDTH(WINDOW), 40)];
    NSDictionary *dic =self.brandMessageDic[@"ad_brand"];
    [self.trademarkIcon sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",BaseUrl,dic[@"logo"]]] placeholderImage:nil];
    [trademarkView addSubview:self.trademarkIcon];
    [self.view addSubview:trademarkView];
    
    [self.view addSubview:self.productCollrctionView];
    [self.view addSubview:self.productKindBackView];
}

#pragma mark ——————————
#pragma mark collectionView协议的实现
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return self.allBrandListArrCopy.count;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    NSMutableDictionary *dic =self.allBrandListArrCopy[section];
    NSMutableArray *arr =dic[@"product_list"];
    return arr.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"ProductCollectionViewCellName";
    ProductCollectionViewCell *cell = (ProductCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    NSMutableDictionary *dic =self.allBrandListArr[indexPath.section];
    NSMutableDictionary *dic1 =dic[@"product_list"][indexPath.row];
    cell.name.text =dic1[@"product_model"];
    [cell.image sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",BaseUrl,dic1[@"product_imag"]]] placeholderImage:[UIImage imageNamed:@"placeholderImage_01"]];
    return cell;
}
- (UICollectionReusableView *) collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    UICollectionReusableView *reusableview = nil;
    
    if (kind == UICollectionElementKindSectionHeader)
    {
        NSMutableDictionary *dic =self.allBrandListArrCopy[indexPath.section];
        ProductReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"ProductReusableViewName" forIndexPath:indexPath];
        [headerView setLabelText:dic[@"product_classification_name"]];
        reusableview = headerView;
    }else{
        ProductReusableViewFooter *footerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"ProductReusableViewFotterName" forIndexPath:indexPath];
        reusableview = footerView;
    }
    
    return reusableview;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    CGSize size =CGSizeMake(WIDTH(WINDOW)-30, 55);
    return size;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section
{
    if (section==self.allBrandListArrCopy.count-1) {
        CGSize size =CGSizeMake(WIDTH(WINDOW)-30, 55);
        return size;
    }else{
        CGSize size =CGSizeMake(WIDTH(WINDOW)-30,0);
        return size;
    }
}

#pragma mark ——————————
#pragma mark tableView协议的实现

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.allBrandListArr.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat higth =(HEIGHT(WINDOW)-64)/8-10;
    return higth;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellName =@"SelectProductKindTableViewCellName";
    SelectProductKindTableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:cellName];
    NSMutableDictionary *dic =self.allBrandListArr[indexPath.row];
    if (cell == nil) {
        cell =[[[NSBundle mainBundle]loadNibNamed:@"SelectProductKindTableViewCell" owner:self options:nil]lastObject];
        
//        cell.kindTitle.text=dic[@"product_classification_name"];
        
        [self setLabelSpace:cell.kindTitle withValue:dic[@"product_classification_name"] withFont:[UIFont fontWithName:@"STHeitiTC-Medium" size:25]];
        cell.selectionStyle=NO;
    }
    if ([dic[@"ifSelected"] isEqualToString:@"1"]) {
        cell.kindTitle.textColor = Color(0,0, 0, 1);
    }else{
        cell.kindTitle.textColor = Color(204, 204, 204, 1);
    }
    return cell;
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView == self.productCollrctionView) {
        CGFloat y =scrollView.contentOffset.y;
        if (y >0) {
            if (self.productCollrctionViewHeigth < y) {
                [UIView animateWithDuration:0.3 animations:^{
                    self.productKindBackView.frame=CGRectMake(0, HEIGHT(WINDOW)-64,WIDTH(WINDOW), (HEIGHT(WINDOW)-64)/2);
                }];
            }else{
                if (!self.ifTouchSelect) {
                    [UIView animateWithDuration:0.4 animations:^{
                        self.productKindBackView.frame=CGRectMake(0, HEIGHT(WINDOW)-64-40,WIDTH(WINDOW), (HEIGHT(WINDOW)-64)/2);
                    }];
                }
            }
            self.productCollrctionViewHeigth=y;
        }
    }
}
#pragma mark ——————————
#pragma mark 筛选界面的弹出与收回
- (void)selectionAction{
    if (self.ifTouchSelect) {
        
    }else{
        [self pushProductKindBackView];
        
        
    }
}



- (void)pushProductKindBackView{
    self.ifTouchSelect =YES;
    [self.view addSubview:self.productKindBackViewHeader];
    [UIView animateWithDuration:0.4 animations:^{
        self.productKindBackView.frame=CGRectMake(0, (HEIGHT(WINDOW)-64)/2,WIDTH(WINDOW), (HEIGHT(WINDOW)-64)/2);
        _allSelect.hidden=NO;
        _sure.hidden=NO;
    }];
}
- (void)removeProductKindBackView{
    self.ifTouchSelect =NO;
    [self.productKindBackViewHeader removeFromSuperview];
    [UIView animateWithDuration:0.4 animations:^{
        self.productKindBackView.frame=CGRectMake(0, HEIGHT(WINDOW)-64-40,WIDTH(WINDOW), (HEIGHT(WINDOW)-64)/2);
        _allSelect.hidden=YES;
        _sure.hidden=YES;
    }];
}
- (void)selectAllKind{
    for (NSMutableDictionary *dic in self.allBrandListArr) {
        [dic setObject:@"0" forKey:@"ifSelected"];
    }
    self.allBrandListArrCopy =self.allBrandListArr;
    [_tableView reloadData];
}
- (void)sureAction{
    NSMutableArray *arr =[[NSMutableArray alloc]init];
    for (NSMutableDictionary *dic in self.allBrandListArr) {
        if ([dic[@"ifSelected"] isEqualToString:@"1"]) {
            [arr addObject:dic];
        }
    }
    if (arr.count==0) {
        self.allBrandListArrCopy =self.allBrandListArr;
    }else{
       self.allBrandListArrCopy =arr;
    }
    [self removeProductKindBackView];
    [self.productCollrctionView reloadData];
}
#pragma mark ——————————
#pragma mark tableView与collectionView的选中
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSMutableDictionary *dic =self.allBrandListArr[indexPath.section];
    NSMutableDictionary *dic1 =dic[@"product_list"][indexPath.row];
    
    SingleProductDetailsViewController *productStoryViewController =[[SingleProductDetailsViewController alloc]init];
    productStoryViewController.urlId =dic1[@"product_id"];
    [self.navigationController pushViewController:productStoryViewController animated:YES];
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSMutableDictionary *dic =self.allBrandListArr[indexPath.row];
    if ([dic[@"ifSelected"] isEqualToString:@"1"]) {
        [dic setObject:@"0" forKey:@"ifSelected"];
    }else{
        [dic setObject:@"1" forKey:@"ifSelected"];
    }
    [tableView reloadData];
}

-(void)setLabelSpace:(UILabel*)label withValue:(NSString*)str withFont:(UIFont*)font {
    
    NSMutableParagraphStyle *paraStyle = [[NSMutableParagraphStyle alloc] init];
    
    paraStyle.lineBreakMode = NSLineBreakByCharWrapping;
    
    paraStyle.alignment = NSTextAlignmentCenter;
    
    paraStyle.lineSpacing = 0; //设置行间距
    
    paraStyle.hyphenationFactor = 1.0;
    
    paraStyle.firstLineHeadIndent = 0.0;
    
    paraStyle.paragraphSpacingBefore = 0.0;
    
    paraStyle.headIndent = 0;
    
    paraStyle.tailIndent = 0;
    
    NSDictionary *dic = @{NSFontAttributeName:font, NSParagraphStyleAttributeName:paraStyle, NSKernAttributeName:@2.0f
                          };
    NSAttributedString *attributeStr = [[NSAttributedString alloc] initWithString:str attributes:dic];
    
    label.attributedText = attributeStr;
    
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
