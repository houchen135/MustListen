//
//  ThirdProductStoryView.h
//  
//
//  Created by 侯琛 on 16/8/10.
//
//

#import <UIKit/UIKit.h>

@interface ThirdProductStoryView : UIView
-(void)makeUiWith:(NSMutableDictionary *)dic;
@property (nonatomic,copy)void(^selectProductNum)(int index);
@property (nonatomic,copy)void(^moreProduct)();
@end
