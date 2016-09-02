//
//  ProductStoryProductListView.m
//  MustListen
//
//  Created by 侯琛 on 16/8/10.
//  Copyright © 2016年 MustListen. All rights reserved.
//

#import "ProductStoryProductListView.h"
#import "UIImageView+WebCache.h"
@implementation ProductStoryProductListView
- (void)makeUiWith:(NSMutableDictionary *)dic{
    UIImageView *imageView=[[UIImageView alloc]initWithFrame:CGRectMake(15, 15, WIDTH(self)-30, HEIGHT(self)*2/3-60)];
    [imageView setImage:[UIImage imageNamed:@"right.jpg"]];

    [imageView sd_setImageWithURL:[NSURL URLWithString:dic[@"image"]] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        [imageView setImage:[self cutImage:image]];
    }];
    [self addSubview:imageView];
    
    
    
    
    UILabel *title =[[UILabel alloc]initWithFrame:CGRectMake(5, Y(imageView)+HEIGHT(imageView)+10, WIDTH(self)-10, 20)];
    title.text=dic[@"title"];
    title.numberOfLines=0;
    title.textAlignment=NSTextAlignmentCenter;
    title.textColor=[UIColor blackColor];
    title.font=[UIFont systemFontOfSize:11];
    [self addSubview:title];
    
    UILabel *time =[[UILabel alloc]initWithFrame:CGRectMake(5, Y(title)+HEIGHT(title)+10, WIDTH(self)-10, 20)];
    time.text=dic[@"time"];
    time.numberOfLines=0;
    time.textAlignment=NSTextAlignmentCenter;
    time.textColor=[UIColor blackColor];
    time.font=[UIFont systemFontOfSize:11];
    [self addSubview:time];
    
    UILabel *message =[[UILabel alloc]initWithFrame:CGRectMake(20, HEIGHT(self)*2/3+30, WIDTH(self)-40, HEIGHT(self)/3-40)];
    message.text=dic[@"message"];
    message.numberOfLines=0;
    message.textAlignment=NSTextAlignmentCenter;
    message.textColor=[UIColor blackColor];
    message.font=[UIFont systemFontOfSize:12];
    [self addSubview:message];
    
}
- (UIImage *)cutImage:(UIImage*)image
{
    //压缩图片
    CGSize newSize;
    CGImageRef imageRef = nil;
    
    if ((image.size.width / image.size.height) < ((WIDTH(self)-30) / (HEIGHT(self)*2/3-30))) {
        newSize.width = image.size.width;
        newSize.height = image.size.width * (HEIGHT(self)*2/3-30)/ (WIDTH(self)-30);
        
        imageRef = CGImageCreateWithImageInRect([image CGImage], CGRectMake(0, fabs(image.size.height - newSize.height) / 2, newSize.width, newSize.height));
        
    } else {
        newSize.height = image.size.height;
        newSize.width = image.size.height * (WIDTH(self)-30)/ (HEIGHT(self)*2/3-30);
        
        imageRef = CGImageCreateWithImageInRect([image CGImage], CGRectMake(fabs(image.size.width - newSize.width) / 2, 0, newSize.width, newSize.height));
        
    }
    
    return [UIImage imageWithCGImage:imageRef];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
