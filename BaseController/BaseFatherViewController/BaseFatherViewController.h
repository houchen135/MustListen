//
//  BaseFatherViewController.h
//  MustListen
//
//  Created by 侯琛 on 16/8/1.
//  Copyright © 2016年 MustListen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseFatherViewController : UIViewController
#pragma mark -----------网络请求------------
# pragma  make - POST
- (void)sendPostRequestWithUrl:(NSString *)UrlStr andParameters:(NSDictionary *)parameters andBlock:(void (^)(NSDictionary * result, NSError *error))block;
#pragma mark - GET
- (void)sendGetRequestWithUrl:(NSString *)UrlStr andParameters:(NSDictionary *)parameters andBlock:(void (^)(NSDictionary * result, NSError *error))block;

//设置导航title设置
# pragma  mark - 设置导航Title
- (void)setNavigationTitle:(NSString *)title;
# pragma mark - 设置导航TitleView
- (void)setNavigationTitleView:(UIView *)titleView;
# pragma mark -设置导航TitleView(根据icon)
- (void)setNavigationTitleViewWithIconName:(NSString *)iconName;
//设置导航左按钮
# pragma mark - 根据按钮Title名字 设置导航左按钮
- (void)setNavigationBarLeftBtnWitBtnTitle:(NSString *)BtnTitle;
# pragma mark - 根据按钮图片名字 设置导航左按钮
- (void)setNavigationBarLeftBtnWithImageName:(NSString *)imageStr;
#pragma mark - 导航左按钮 点击事件
- (void)NavigationBarLeftBarButtonAction:(UIButton *)tmpBarBtn;
//设置导航右按钮
# pragma mark - 根据按钮Title名字 设置导航右按钮
- (void)setNavigationBarRightBtnWitBtnTitle:(NSString *)BtnTitle;
# pragma mark - 根据按钮图片名字 设置导航右按钮
- (void)setNavigationBarRightBtnWithImageName:(NSString *)imageStr;
#pragma mark - 导航右按钮 点击事件
- (void)NavigationBarRightBarButtonAction:(UIButton *)tmpBarBtn;
# pragma mark - 设置导航左按钮（多个）
- (void)setNavigationBarLeftBtnsWithImageNameArr:(NSArray *)imageNameArr;
# pragma mark - 设置导航右按钮（多个）
- (void)setNavigationBarRightBtnsWithImageNameArr:(NSArray *)imageNameArr;
@end
