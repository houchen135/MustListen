//
//  ProductStory.h
//  MustListen
//
//  Created by 侯琛 on 16/8/5.
//  Copyright © 2016年 MustListen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProductStory : UIView
- (void)makeUi:(NSMutableArray *)imageArr;
@property (nonatomic,copy)void(^selectImageNum)(int index);
@end
