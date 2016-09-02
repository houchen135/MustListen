//
//  ProductReusableView.m
//  MustListen
//
//  Created by 侯琛 on 16/8/15.
//  Copyright © 2016年 MustListen. All rights reserved.
//

#import "ProductReusableView.h"

@interface ProductReusableView ()
@property (strong, nonatomic) UILabel *label;
@end
@implementation ProductReusableView
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        _label = [[UILabel alloc] init];
        _label.frame=CGRectMake(0, 0, WIDTH(WINDOW)-30, 55);
        [self addSubview:_label];
        
    }
    return self;
}

- (void) setLabelText:(NSString *)text
{
    
    [self setLabelSpace:_label withValue:text withFont:[UIFont fontWithName:@"STHeitiTC-Medium" size:22]];
    
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
    
    NSDictionary *dic = @{NSFontAttributeName:font, NSParagraphStyleAttributeName:paraStyle, NSKernAttributeName:@6.0f};// 字号与字间距
    NSAttributedString *attributeStr = [[NSAttributedString alloc] initWithString:str attributes:dic];
    label.attributedText = attributeStr;
}

@end
