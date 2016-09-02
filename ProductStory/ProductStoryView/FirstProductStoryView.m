//
//  FirstProductStoryView.m
//  MustListen
//
//  Created by 侯琛 on 16/8/6.
//  Copyright © 2016年 MustListen. All rights reserved.
//

#import "FirstProductStoryView.h"

@implementation FirstProductStoryView
- (void)makeUiWithMessage:(NSMutableDictionary *)dic{
    [self setLabelSpace:self.content withValue:dic[@"livejiyu"] withFont:[UIFont fontWithName:@"STHeitiTC-Light" size:13]];
    [self setLabelSpace:self.author withValue:[NSString stringWithFormat:@"作者:%@",dic[@"pro2"]] withFont:[UIFont fontWithName:@"STHeitiTC-Medium" size:12]];
    [self setLabelSpace:self.illustration withValue:[NSString stringWithFormat:@"配图:%@",dic[@"pro3"]] withFont:[UIFont fontWithName:@"STHeitiTC-Medium" size:12]];
    [self setLabel2Space:self.title withValue:dic[@"pro1"] withFont:[UIFont fontWithName:@"STHeitiTC-Medium" size:16]];
}

-(void)setLabelSpace:(UILabel*)label withValue:(NSString*)str withFont:(UIFont*)font {
    
    NSMutableParagraphStyle *paraStyle = [[NSMutableParagraphStyle alloc] init];
    paraStyle.lineBreakMode = NSLineBreakByCharWrapping;
    paraStyle.lineSpacing = 3.0; //设置行间距
    paraStyle.hyphenationFactor = 1.0;
    paraStyle.firstLineHeadIndent = 0.0;
    paraStyle.paragraphSpacingBefore = 0.0;
    paraStyle.headIndent = 0;
    paraStyle.tailIndent = 0;
    paraStyle.alignment = NSTextAlignmentCenter;
    NSDictionary *dic = @{NSFontAttributeName:font, NSParagraphStyleAttributeName:paraStyle, NSKernAttributeName:@3.0f};
    NSAttributedString *attributeStr = [[NSAttributedString alloc] initWithString:str attributes:dic];
    label.attributedText = attributeStr;
    
}
-(void)setLabel2Space:(UILabel*)label withValue:(NSString*)str withFont:(UIFont*)font {
    
    NSMutableParagraphStyle *paraStyle = [[NSMutableParagraphStyle alloc] init];
    paraStyle.lineBreakMode = NSLineBreakByCharWrapping;
    paraStyle.lineSpacing = 5.0; //设置行间距
    paraStyle.hyphenationFactor = 1.0;
    paraStyle.firstLineHeadIndent = 0.0;
    paraStyle.paragraphSpacingBefore = 0.0;
    paraStyle.headIndent = 0;
    paraStyle.tailIndent = 0;
    paraStyle.alignment = NSTextAlignmentCenter;
    NSDictionary *dic = @{NSFontAttributeName:font, NSParagraphStyleAttributeName:paraStyle, NSKernAttributeName:@5.0f};
    NSAttributedString *attributeStr = [[NSAttributedString alloc] initWithString:str attributes:dic];
    label.attributedText = attributeStr;
    
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
