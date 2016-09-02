//
//  ThirdProductStoryView.m
//  
//
//  Created by 侯琛 on 16/8/10.
//
//

#import "ThirdProductStoryView.h"
#import "ProductStoryProductListView.h"
@interface ThirdProductStoryView ()
@property (nonatomic,strong)UIScrollView *productScrollView;
@property (nonatomic,strong)UILabel *timeLable;
@end
@implementation ThirdProductStoryView
-(void)makeUiWith:(NSMutableDictionary *)dic{
    
    NSMutableDictionary *dic1=[[NSMutableDictionary alloc]init];
    [dic1 setValue:@"EARPHONES & EARSET 3i" forKey:@"title"];
    [dic1 setValue:@"8克-这是它的重量\n\n舒适随身-运动中的人体工程学" forKey:@"message"];
    [dic1 setValue:@"http://imgsrc.baidu.com/forum/w%3D580/sign=cd0c26a249fbfbeddc59367748f1f78e/d8529e2f0708283888936b89ba99a9014d08f1bb.jpg" forKey:@"image"];
    [dic1 setValue:@"1990.01" forKey:@"time"];
    
    NSMutableDictionary *dic2=[[NSMutableDictionary alloc]init];
    [dic2 setValue:@"BeoPlay H3" forKey:@"title"];
    [dic2 setValue:@"独特声学设计-大声音、小体积\n金属-坚固耐用、无比轻盈" forKey:@"message"];
    [dic2 setValue:@"http://img.pconline.com.cn/images/upload/upc/tx/piebbs/1308/02/c0/24052422_1375424449373_4_1024x1024.jpg" forKey:@"image"];
    [dic2 setValue:@"1992.03" forKey:@"time"];
    NSMutableDictionary *dic3=[[NSMutableDictionary alloc]init];
    [dic3 setValue:@"EARPHONES & EARSET 3i" forKey:@"title"];
    [dic3 setValue:@"8克-这是它的重量\n舒适随身-运动中的人体工程学" forKey:@"message"];
    [dic3 setValue:@"http://imgsrc.baidu.com/forum/w%3D580/sign=cd0c26a249fbfbeddc59367748f1f78e/d8529e2f0708283888936b89ba99a9014d08f1bb.jpg" forKey:@"image"];
    [dic3 setValue:@"1992.04" forKey:@"time"];
    NSMutableDictionary *dic4=[[NSMutableDictionary alloc]init];
    [dic4 setValue:@"BeoPlay H3" forKey:@"title"];
    [dic4 setValue:@"独特声学设计-大声音、小体积\n金属-坚固耐用、无比轻盈" forKey:@"message"];
    [dic4 setValue:@"http://img.pconline.com.cn/images/upload/upc/tx/piebbs/1308/02/c0/24052422_1375424449373_4_1024x1024.jpg" forKey:@"image"];
    [dic4 setValue:@"2004.01" forKey:@"time"];
    NSMutableDictionary *dic5=[[NSMutableDictionary alloc]init];
    [dic5 setValue:@"EARPHONES & EARSET 3i" forKey:@"title"];
    [dic5 setValue:@"8克-这是它的重量\n舒适随身-运动中的人体工程学" forKey:@"message"];
    [dic5 setValue:@"http://imgsrc.baidu.com/forum/w%3D580/sign=cd0c26a249fbfbeddc59367748f1f78e/d8529e2f0708283888936b89ba99a9014d08f1bb.jpg" forKey:@"image"];
    [dic5 setValue:@"2016.01" forKey:@"time"];
    
    NSMutableArray *arr =[[NSMutableArray alloc]init];
    [arr addObject:dic1];
    [arr addObject:dic2];
    [arr addObject:dic3];
    [arr addObject:dic4];
    [arr addObject:dic5];

    
    UILabel *title =[[UILabel alloc]initWithFrame:CGRectMake(20, 30, 120, 40)];
    title.text=@"里程碑";
    title.font =[UIFont systemFontOfSize:24];
    title.textColor=[UIColor blackColor];
    [self addSubview:title];
    _timeLable =[[UILabel alloc]initWithFrame:CGRectMake(WIDTH(WINDOW)-120, 40, 100, 20)];
    _timeLable.textColor=[UIColor blackColor];
    _timeLable.textAlignment =NSTextAlignmentRight;
    _timeLable.font=[UIFont systemFontOfSize:13];
    _timeLable.text=@"1925-2016";
    [self addSubview:_timeLable];
    
    
    _productScrollView =[[UIScrollView alloc]initWithFrame:CGRectMake(5, 90, WIDTH(WINDOW)-10, HEIGHT(WINDOW)-64-170)];
    
    [self addSubview:_productScrollView];
    _productScrollView.pagingEnabled=YES;
    
    _productScrollView.contentSize= CGSizeMake((WIDTH(WINDOW)-10)*arr.count/2, HEIGHT(WINDOW)-64-170);
    _productScrollView.showsHorizontalScrollIndicator=NO;
    for (int i =0; i <arr.count; i ++) {
        UITapGestureRecognizer *tap =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(nextProductSelect:)];
        ProductStoryProductListView *productStoryProductListView =[[ProductStoryProductListView alloc]initWithFrame:CGRectMake(WIDTH(_productScrollView)/2*i, 0, WIDTH(_productScrollView)/2, HEIGHT(_productScrollView))];
        NSMutableDictionary *dic =arr[i];
        [productStoryProductListView makeUiWith:dic];
        [_productScrollView addSubview:productStoryProductListView];
        productStoryProductListView.userInteractionEnabled=YES;
        [productStoryProductListView addGestureRecognizer:tap];
        productStoryProductListView.tag =33333+i;
    }
    
    
    
    
    UIView *line1 =[[UIView alloc]initWithFrame:CGRectMake(20, HEIGHT(WINDOW)-64-80, WIDTH(WINDOW)-20, 1.5)];
    line1.backgroundColor=[UIColor blackColor];
    [self addSubview:line1];
    
    UIView *line2 =[[UIView alloc]initWithFrame:CGRectMake(20, 110+(HEIGHT(WINDOW)-64-170)*2/3, WIDTH(WINDOW)-20, 2.5)];
    line2.backgroundColor=[UIColor blackColor];
    [self addSubview:line2];
    
    UIButton *moreProduct =[UIButton buttonWithType:UIButtonTypeCustom];
    moreProduct.frame =CGRectMake(20, HEIGHT(WINDOW)-120, 130, 35);
    moreProduct.backgroundColor=[UIColor blackColor];
    [moreProduct setTitle:@"更多产品" forState:UIControlStateNormal];
    [moreProduct setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [moreProduct addTarget:self action:@selector(moreAction) forControlEvents:UIControlEventTouchUpInside];
    moreProduct.titleLabel.font=[UIFont systemFontOfSize:15];
    [self addSubview:moreProduct];
}
- (void)nextProductSelect:(UITapGestureRecognizer *)tap{
    NSInteger a =tap.view.tag;
    NSLog(@"第%ld张图",(long)a);
    self.selectProductNum((int)a-33333);
    
}
- (void)moreAction{
    self.moreProduct();
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
