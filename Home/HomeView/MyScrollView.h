//
//  MyScrollView.h
//  Demo
//
//  Created by 侯琛 on 16/8/3.
//  Copyright © 2016年 HouChen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyScrollView : UIView
-(void)makeUi:(NSMutableArray *)imageArr;
@property (nonatomic,copy)void(^selectImageNum)(int index);
@end
