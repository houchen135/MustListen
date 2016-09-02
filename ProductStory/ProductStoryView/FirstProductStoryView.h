//
//  FirstProductStoryView.h
//  MustListen
//
//  Created by 侯琛 on 16/8/6.
//  Copyright © 2016年 MustListen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FirstProductStoryView : UIView
@property (weak, nonatomic) IBOutlet UILabel *content;
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *author;
@property (weak, nonatomic) IBOutlet UILabel *illustration;
- (void)makeUiWithMessage:(NSMutableDictionary *)dic;
@end
