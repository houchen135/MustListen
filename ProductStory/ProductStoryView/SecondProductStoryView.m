//
//  SecondProductStoryView.m
//  MustListen
//
//  Created by 侯琛 on 16/8/9.
//  Copyright © 2016年 MustListen. All rights reserved.
//

#import "SecondProductStoryView.h"
#import "AtlasBtnView.h"
#import "ImageNumView.h"
#import "UIImageView+WebCache.h"
@interface SecondProductStoryView()<UIScrollViewDelegate>

@property (nonatomic,strong)UILabel *messageLable;
@property (nonatomic,strong)ImageNumView *num;
@end
@implementation SecondProductStoryView
-(void)makeUi:(NSMutableDictionary *)dic{
    _imageScrollView =[[UIScrollView alloc]initWithFrame:CGRectMake(10, 15, WIDTH(WINDOW)*0.6, WIDTH(WINDOW)*0.6*0.3/0.4)];
    _imageScrollView.backgroundColor=[UIColor whiteColor];
    _imageScrollView.delegate=self;
    [self addSubview:_imageScrollView];
    _imageScrollView.bounces=YES;
    NSArray *networkImages=dic[@"imageArr"];
    _imageScrollView.contentSize =CGSizeMake(WIDTH(_imageScrollView)*networkImages.count, HEIGHT(_imageScrollView));
    for (int i =0; i<networkImages.count; i++) {
        NSMutableDictionary *imageDic=networkImages[i];
        UITapGestureRecognizer *tap =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(theImageSelected:)];
        UIImageView *imageView =[[UIImageView alloc]initWithFrame:CGRectMake(WIDTH(_imageScrollView)*i, 0, WIDTH(_imageScrollView), HEIGHT(_imageScrollView))];
        [imageView sd_setImageWithURL:[NSURL URLWithString:imageDic[@"picUrl"]] placeholderImage:[UIImage imageNamed:@"placeholderImage_02"]];
        [_imageScrollView addSubview:imageView];
        imageView.userInteractionEnabled=YES;
        imageView.tag=232323+i;
        [imageView addGestureRecognizer:tap];
    }
    _imageScrollView.showsHorizontalScrollIndicator=NO;
    _imageScrollView.pagingEnabled=YES;
    
    UIView *line=[[UIView alloc]initWithFrame:CGRectMake(10+WIDTH(WINDOW)*0.6,WIDTH(WINDOW)*0.6*0.3/0.4/2+12.5 , WIDTH(WINDOW)*0.4-10, 2)];
    line.backgroundColor=[UIColor whiteColor];
    [self addSubview:line];
    
    
    _messageLable =[[UILabel alloc]initWithFrame:CGRectMake(70, WIDTH(WINDOW)*0.6*0.3/0.4+40, WIDTH(WINDOW)-90, HEIGHT(self)-WIDTH(WINDOW)*0.6*0.3/0.4-60)];
    _messageLable.numberOfLines=0;
    _messageLable.textColor=[UIColor whiteColor];
    NSLog(@"%@",dic);
    [self setLabelSpace:_messageLable withValue:dic[@"message"] withFont:[UIFont fontWithName:@"STHeitiTC-Light" size:13]];
    [self addSubview:_messageLable];
    [_messageLable sizeToFit];
    _num =[[[NSBundle mainBundle]loadNibNamed:@"ImageNumView" owner:self options:nil]lastObject];
    _num.frame=CGRectMake(0.8*WIDTH(WINDOW)-35,WIDTH(WINDOW)*0.6*0.3/0.4/2+12.5-70, 70, 70);
    if (networkImages.count==0) {
        _num.currentNum.text=@"0";
//        [self setLabelSpace:_num.currentNum withValue:@"0" withFont:[UIFont fontWithName:@"STHeitiTC-Light" size:33]];
    }else{
       _num.currentNum.text=@"1";
//        [self setLabelSpace:_num.currentNum withValue:@"1" withFont:[UIFont fontWithName:@"STHeitiTC-Light" size:33]];
    }
    _num.allNum.text =[NSString stringWithFormat:@"/%d",(int)networkImages.count];
    
    
//    [self setLabelSpace:_num.allNum withValue:[NSString stringWithFormat:@"/%d",(int)networkImages.count] withFont:[UIFont fontWithName:@"STHeitiTC-Light" size:33]];
    
    [self addSubview:_num];
    AtlasBtnView *view =[[[NSBundle mainBundle]loadNibNamed:@"AtlasBtnView" owner:self options:nil]lastObject];
    view.frame =CGRectMake(0.8*WIDTH(WINDOW)-35, Y(line)+HEIGHT(line)+10, 70, 70);
    [self addSubview:view];
}
- (void)theImageSelected:(UITapGestureRecognizer *)tap
{
    NSInteger a =tap.view.tag;
    NSLog(@"第%ld张",(long)a-232323);
    self.selectImageNum((int)a-232323);
}
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    CGFloat x =scrollView.contentOffset.x;
    _num.currentNum.text =[NSString stringWithFormat:@"%d",(int)(x/WIDTH(_imageScrollView)/0.9)+1];
//    [self setLabelSpace:_num.currentNum withValue:[NSString stringWithFormat:@"%d",(int)(x/WIDTH(_imageScrollView)/0.9)+1] withFont:[UIFont fontWithName:@"STHeitiTC-Light" size:33]];
}
- (UIImage *)cutImage:(UIImage*)image
{
    //压缩图片
    CGSize newSize;
    CGImageRef imageRef = nil;
    
    if ((image.size.width / image.size.height) < (4 / 3)) {
        newSize.width = image.size.width;
        newSize.height = image.size.width * 3 / 4;
        
        imageRef = CGImageCreateWithImageInRect([image CGImage], CGRectMake(0, fabs(image.size.height - newSize.height) / 2, newSize.width, newSize.height));
        
    } else {
        newSize.height = image.size.height;
        newSize.width = image.size.height * 4 / 3;
        
        imageRef = CGImageCreateWithImageInRect([image CGImage], CGRectMake(fabs(image.size.width - newSize.width) / 2, 0, newSize.width, newSize.height));
        
    }
    
    return [UIImage imageWithCGImage:imageRef];
}

-(void)setLabelSpace:(UILabel*)label withValue:(NSString*)str withFont:(UIFont*)font {
    
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
    
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
