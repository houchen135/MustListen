//
//  FirstStyleView.m
//  MustListen
//
//  Created by 侯琛 on 16/8/5.
//  Copyright © 2016年 MustListen. All rights reserved.
//

#import "FirstStyleView.h"
#import "UIImageView+WebCache.h"
@interface FirstStyleView()
@property (nonatomic,strong)UIImageView *leftImage;
@property (nonatomic,strong)UIImageView *rightImage;
@property (nonatomic,strong)UILabel *leftLabel1;
@property (nonatomic,strong)UILabel *leftLabel2;
@property (nonatomic,strong)UILabel *rightLabel1;
@property (nonatomic,strong)UILabel *rightLabel2;
@property (nonatomic,strong)UILabel *title;
@property (nonatomic,strong)UILabel *tipTitle;
@end
@implementation FirstStyleView
- (void)makeUiWith:(NSDictionary *)messageDic
{
    _leftImage =[[UIImageView alloc]initWithFrame:CGRectMake(0, WIDTH(WINDOW)*0.3, WIDTH(WINDOW)/2-10, WIDTH(WINDOW)/2-10)];
    [_leftImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",BaseUrl,messageDic[@"image_album"]]] placeholderImage:[UIImage imageNamed:@"placeholderImage_00"]];
    _rightImage =[[UIImageView alloc]initWithFrame:CGRectMake(WIDTH(WINDOW)/2+10, WIDTH(WINDOW)*0.3, WIDTH(WINDOW)/2-10, WIDTH(WINDOW)/2-10)];
    [_rightImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",BaseUrl,messageDic[@"image_equip"]]] placeholderImage:[UIImage imageNamed:@"placeholderImage_00"]];
    [self addSubview:_leftImage];
    [self addSubview:_rightImage];
    
    
    _leftLabel1 =[[UILabel alloc]initWithFrame:CGRectMake(0, WIDTH(WINDOW)*0.8+20, WIDTH(WINDOW)/2-20, 20)];
    _leftLabel1.font=[UIFont fontWithName:@"DidotLTStd-Bold" size:19];
    _leftLabel1.textAlignment=NSTextAlignmentCenter;
    _leftLabel1.text=messageDic[@"title_album" ];
    _leftLabel1.textColor=[UIColor blackColor];
    _leftLabel1.backgroundColor=[UIColor whiteColor];
    [self addSubview:_leftLabel1];
    _leftLabel2 =[[UILabel alloc]initWithFrame:CGRectMake(0, WIDTH(WINDOW)*0.8+45, WIDTH(WINDOW)/2-20, 20)];
    _leftLabel2.font=[UIFont fontWithName:@"STHeitiSC-Light" size:12];
    _leftLabel2.textAlignment=NSTextAlignmentCenter;
    _leftLabel2.text=messageDic[@"title_album_for" ];
    _leftLabel2.textColor=Color(136, 136, 136, 1);
    _leftLabel2.backgroundColor=[UIColor whiteColor];
    [self addSubview:_leftLabel2];
    _rightLabel1 =[[UILabel alloc]initWithFrame:CGRectMake(WIDTH(WINDOW)/2+20, WIDTH(WINDOW)*0.8+20, WIDTH(WINDOW)/2-20, 20)];
    _rightLabel1.font=[UIFont fontWithName:@"DidotLTStd-Bold" size:17];
    _rightLabel1.textAlignment=NSTextAlignmentCenter;
    _rightLabel1.text=messageDic[@"title_equip" ];
    _rightLabel1.textColor=[UIColor blackColor];
    _rightLabel1.backgroundColor=[UIColor whiteColor];
    [self addSubview:_rightLabel1];
    _rightLabel2 =[[UILabel alloc]initWithFrame:CGRectMake(WIDTH(WINDOW)/2+20, WIDTH(WINDOW)*0.8+45, WIDTH(WINDOW)/2-20, 20)];
    _rightLabel2.font=[UIFont fontWithName:@"STHeitiSC-Light" size:13];
    _rightLabel2.textAlignment=NSTextAlignmentCenter;
    _rightLabel2.text=messageDic[@"title_equip_for" ];
    _rightLabel2.textColor=Color(136, 136, 136, 1);
    _rightLabel2.backgroundColor=[UIColor whiteColor];
    [self addSubview:_rightLabel2];
    
    
    
    UIImageView *x =[[UIImageView alloc]initWithFrame:CGRectMake((WIDTH(WINDOW)-15)/2, WIDTH(WINDOW)*0.8+35, 15, 15)];
    [x setImage:[UIImage imageNamed:@"x.png"]];
    [self addSubview:x];
    
    
    
    _tipTitle =[[UILabel alloc]initWithFrame:CGRectMake(self.frame.size.width/2-35, self.frame.size.width*0.1-5, 70, 12)];
    [self addSubview:_tipTitle];
    [self setLabelSpace:_tipTitle withValue:@"风格" withFont:[UIFont systemFontOfSize:9]];
    
    
    _title =[[UILabel alloc]initWithFrame:CGRectMake(70, Y(_tipTitle)+HEIGHT(_tipTitle)+5, self.frame.size.width-140, 40)];
    [self addSubview:_title];
    [self setLabelSpace:_title withValue:@"H3的完美拍档" withFont:[UIFont systemFontOfSize:17]];
    
    
    UIView *footerLine =[[UIView alloc]initWithFrame:CGRectMake(0, WIDTH(WINDOW)*0.86+65, WIDTH(self), self.frame.size.width*0.04)];
    footerLine.backgroundColor =Color(235, 235, 245, 1);
    [self addSubview:footerLine];
    UITapGestureRecognizer *tap  =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction)];
    self.userInteractionEnabled=YES;
    [self addGestureRecognizer:tap];
    

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
- (void)tapAction{
    self.selectBestPartner();
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
 
    // Drawing code
}
*/

@end
