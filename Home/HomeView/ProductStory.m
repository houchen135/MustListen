//
//  ProductStory.m
//  MustListen
//
//  Created by 侯琛 on 16/8/5.
//  Copyright © 2016年 MustListen. All rights reserved.
//

#import "ProductStory.h"
#import "UIImageView+WebCache.h"
@interface ProductStory()<UIScrollViewDelegate>
@property(nonatomic,strong)UIScrollView *scrollView;
@property (nonatomic,assign)int scrollViewNum;
@property (nonatomic)NSTimer *MouseTimer;
@property (nonatomic,strong)UIView *pageControlBackView;
@property (nonatomic,strong)UIView *pageControlView;
@property(nonatomic,assign)CGFloat scrollWidth;

@end
@implementation ProductStory
- (void)makeUi:(NSMutableArray *)imageArr{
    _scrollView =[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.width*0.86+28)];
    _scrollView.contentSize=CGSizeMake(self.frame.size.width*imageArr.count, 0);
    _scrollView.delegate=self;
    _scrollViewNum=(int)imageArr.count;
    
    
    for (int i =0; i<imageArr.count; i++) {
        NSDictionary *dic =imageArr[i];
    
        UILabel *tipTitle =[[UILabel alloc]initWithFrame:CGRectMake(WIDTH(WINDOW)*i+self.frame.size.width/2-35, WIDTH(WINDOW)*0.1, 70, 12)];
        tipTitle.textColor =[UIColor blackColor];
        [_scrollView addSubview:tipTitle];
        [self setLabelSpace:tipTitle withValue:@"品牌故事" withFont:[UIFont systemFontOfSize:9]];
        UILabel *title =[[UILabel alloc]initWithFrame:CGRectMake(WIDTH(WINDOW)*i+30, Y(tipTitle)+HEIGHT(tipTitle)+WIDTH(WINDOW)*0.06, self.frame.size.width-60, 16)];
        [self setLabelSpace:title withValue:@"BAN & OLUFSEN" withFont:[UIFont systemFontOfSize:17]];
        
        UIImageView *titleIcon =[[UIImageView alloc]initWithFrame:CGRectMake(WIDTH(WINDOW)*i+(WIDTH(WINDOW)-300)/2, Y(tipTitle)+HEIGHT(tipTitle)+WIDTH(WINDOW)*0.06-7, 300, 30)];
        [titleIcon sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",BaseUrl,dic[@"logo"]]] placeholderImage:nil];
        [_scrollView addSubview:titleIcon];
        
        
        
        
        UIImageView *image =[[UIImageView alloc]initWithFrame:CGRectMake(self.frame.size.width*i, Y(title)+HEIGHT(title)+WIDTH(WINDOW)*0.1, self.frame.size.width, WIDTH(WINDOW)*0.75)];
        [image sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",BaseUrl,dic[@"story_img"]]] placeholderImage:[UIImage imageNamed:@"placeholderImage_01"]];
        
        
        
        
        UITapGestureRecognizer *tap =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(touchAction:)];
        image.userInteractionEnabled=YES;
        [image addGestureRecognizer:tap];
        image.tag=i+30000;
        [_scrollView addSubview:image];
        
        
        
        UIView *view =[[UIView alloc]initWithFrame:CGRectMake(0, 0, WIDTH(WINDOW),WIDTH(WINDOW)*0.75)];
        view.alpha=0.3;
        view.backgroundColor =[UIColor blackColor];
        [image addSubview:view];
        
        
        
        UILabel *lable =[[UILabel alloc]initWithFrame:CGRectMake(0, 0, WIDTH(WINDOW), WIDTH(WINDOW)*0.6)];
        lable.textColor=[UIColor whiteColor];
        [self setLabelSpace:lable withValue:[NSString stringWithFormat:@"#%@#",dic[@"story_title"]] withFont:[UIFont fontWithName:@"Helvetica-Bold" size:25]];
        [image addSubview:lable];
        
    }
    _scrollView.showsHorizontalScrollIndicator=NO;
    _scrollView.pagingEnabled=YES;
    [self addSubview:_scrollView];
    [_MouseTimer setFireDate:[NSDate date]];
    
    _pageControlBackView =[[UIView alloc]initWithFrame:CGRectMake(30, HEIGHT(_scrollView)+Y(_scrollView)+WIDTH(WINDOW)*0.1, self.frame.size.width-60, 2)];
    _pageControlBackView.backgroundColor=Color(239, 239, 239, 1);
    [self addSubview:_pageControlBackView];
    
    
    _pageControlView =[[UIView alloc]initWithFrame:CGRectMake(30, HEIGHT(_scrollView)+Y(_scrollView)+WIDTH(WINDOW)*0.1, (self.frame.size.width-60)/imageArr.count, 2)];
    _pageControlView.backgroundColor=Color(139, 139, 139, 1);
    [self addSubview:_pageControlView];

}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat wigth =scrollView.contentOffset.x;
    if (wigth>0) {
        if (wigth<WIDTH(WINDOW)*(_scrollViewNum-1)) {
            CGFloat a =wigth/WIDTH(WINDOW);
            _pageControlView.frame =CGRectMake(30, HEIGHT(_scrollView)+Y(_scrollView)+WIDTH(WINDOW)*0.1, (a+1)*(self.frame.size.width-60)/_scrollViewNum, 2);
        }
        
    }else{
        _pageControlView.frame =CGRectMake(30, HEIGHT(_scrollView)+Y(_scrollView)+WIDTH(WINDOW)*0.1, (self.frame.size.width-60)/_scrollViewNum+wigth, 2);
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
    
    NSDictionary *dic = @{NSFontAttributeName:font, NSParagraphStyleAttributeName:paraStyle, NSKernAttributeName:@5.0f
                          };
    NSAttributedString *attributeStr = [[NSAttributedString alloc] initWithString:str attributes:dic];
    
    label.attributedText = attributeStr;
    

}
- (void)touchAction:(UIGestureRecognizer *)tap{
    
    self.selectImageNum((int)tap.view.tag-30000);
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/


@end
