//
//  FirstStyleView.h
//  MustListen
//
//  Created by 侯琛 on 16/8/5.
//  Copyright © 2016年 MustListen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FirstStyleView : UIView
- (void)makeUiWith:(NSDictionary *)messageDic;
@property (nonatomic,copy)void(^selectBestPartner)();
@end
