//
//  MyScrollView.m
//  Demo
//
//  Created by 侯琛 on 16/8/3.
//  Copyright © 2016年 HouChen. All rights reserved.
//

#import "MyScrollView.h"
#import "LazyFadeInView.h"
#import "UIImageView+WebCache.h"
@interface MyScrollView()<UIScrollViewDelegate>
@property(nonatomic,strong)UIScrollView *scrollView;
@property (nonatomic,assign)int scrollViewNum;
@property (nonatomic,strong)UIView *pageControlBackView;
@property (nonatomic,strong)UIView *pageControlView;
@property(nonatomic,assign)CGFloat scrollWidth;
@end
@implementation MyScrollView
-(void)makeUi:(NSMutableArray *)imageArr{
    _scrollView =[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, WIDTH(WINDOW)*0.86+28)];
    _scrollView.contentSize=CGSizeMake(self.frame.size.width*imageArr.count, 0);
    _scrollView.delegate=self;
    _scrollViewNum=(int)imageArr.count;
    for (int i =0; i<imageArr.count; i++) {
        
        
        NSDictionary *dic =imageArr[i];
        UILabel *tipTitle =[[UILabel alloc]initWithFrame:CGRectMake(self.frame.size.width*i+self.frame.size.width/2-35, self.frame.size.width*0.1, 70, 12)];
        tipTitle.textColor =[UIColor blackColor];
        [_scrollView addSubview:tipTitle];
        
        [self setLabelSpace:tipTitle withValue:@"品质生活" withFont:[UIFont systemFontOfSize:9]];
        
        UILabel *title =[[UILabel alloc]initWithFrame:CGRectMake(self.frame.size.width*i+30, Y(tipTitle)+HEIGHT(tipTitle)+self.frame.size.width*0.06, self.frame.size.width-60, 16)];
        [_scrollView addSubview:title];
    
        
        [self setLabelSpace:title withValue:dic[@"topic"] withFont:[UIFont systemFontOfSize:17]];
        UIImageView *image =[[UIImageView alloc]initWithFrame:CGRectMake(self.frame.size.width*i, Y(title)+HEIGHT(title)+WIDTH(WINDOW)*0.1, self.frame.size.width, self.frame.size.width*0.6)];
        [image sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",BaseUrl,dic[@"maingraphic"]]] placeholderImage:[UIImage imageNamed:@"placeholderImage_01"]];
        

        
        
        UITapGestureRecognizer *tap =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(touchAction:)];
        image.userInteractionEnabled=YES;
        [image addGestureRecognizer:tap];
        image.tag=i+20000;
        [_scrollView addSubview:image];
    }
    _scrollView.showsHorizontalScrollIndicator=NO;
    _scrollView.pagingEnabled=YES;
    [self addSubview:_scrollView];
    
    _pageControlBackView =[[UIView alloc]initWithFrame:CGRectMake(30,HEIGHT(_scrollView)+0.09*WIDTH(WINDOW), self.frame.size.width-60, 2)];
    _pageControlBackView.backgroundColor=Color(239, 239, 239, 1);
    [self addSubview:_pageControlBackView];
    
    
    _pageControlView =[[UIView alloc]initWithFrame:CGRectMake(30, HEIGHT(_scrollView)+0.09*WIDTH(WINDOW), (self.frame.size.width-60)/imageArr.count, 2)];
    _pageControlView.backgroundColor=Color(139, 139, 139, 1);
    [self addSubview:_pageControlView];
    
    
    UIView *footerLine =[[UIView alloc]initWithFrame:CGRectMake(0, Y(_pageControlView)+0.066*WIDTH(WINDOW), WIDTH(self), self.frame.size.width*0.04)];
    footerLine.backgroundColor =Color(235, 235, 245, 1);
    [self addSubview:footerLine];
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat wigth =scrollView.contentOffset.x;
    if (wigth>0) {
        if (wigth<WIDTH(WINDOW)*(_scrollViewNum-1)) {
            CGFloat a =wigth/WIDTH(WINDOW);
            _pageControlView.frame =CGRectMake(30, HEIGHT(_scrollView)+0.09*WIDTH(WINDOW), (a+1)*(self.frame.size.width-60)/_scrollViewNum, 2);
        }
        
    }else{
        _pageControlView.frame =CGRectMake(30, HEIGHT(_scrollView)+0.09*WIDTH(WINDOW), (self.frame.size.width-60)/_scrollViewNum+wigth/2, 2);
    }
    CGFloat a = wigth-_scrollWidth;
    if (a!=0) {
        [UIView animateWithDuration:0.2 animations:^{
            _pageControlView.backgroundColor=Color(50, 50, 50, 1);
        }];
    }
    _scrollWidth=wigth;
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    CGFloat wigth =scrollView.contentOffset.x;
    CGFloat a = wigth-_scrollWidth;
    if (a==0) {
        [UIView animateWithDuration:0.2 animations:^{
            _pageControlView.backgroundColor=Color(139, 139, 139, 1);
        }];
        
    }
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
    
    NSDictionary *dic = @{NSFontAttributeName:font, NSParagraphStyleAttributeName:paraStyle, NSKernAttributeName:@5.0f};
    NSAttributedString *attributeStr = [[NSAttributedString alloc] initWithString:str attributes:dic];
    label.attributedText = attributeStr;
}


- (void)touchAction:(UIGestureRecognizer *)tap{

    self.selectImageNum((int)tap.view.tag-20000);
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
