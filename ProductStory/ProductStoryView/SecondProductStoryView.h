//
//  SecondProductStoryView.h
//  MustListen
//
//  Created by 侯琛 on 16/8/9.
//  Copyright © 2016年 MustListen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SecondProductStoryView : UIView
@property (nonatomic,strong)UIScrollView *imageScrollView;
@property (nonatomic,copy)void(^selectImageNum)(int index);
-(void)makeUi:(NSMutableDictionary *)dic;
@end
