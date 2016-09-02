//
//  AppDelegate.m
//  MustListen
//
//  Created by 侯琛 on 16/8/1.
//  Copyright © 2016年 MustListen. All rights reserved.
//

#import "AppDelegate.h"
#import "HomeViewController.h"
#import "UMMobClick/MobClick.h"
#import "UIImageView+WebCache.h"
@interface AppDelegate ()
@property (nonatomic,strong)HomeViewController *home;
@property (nonatomic,strong)UINavigationController *nav;
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    _home =[[HomeViewController alloc]init];
    _nav= [[UINavigationController alloc]initWithRootViewController:_home];
    _nav.navigationBar.translucent=NO;
    self.window.rootViewController = _nav;
    [self logSdk];
    [[SDWebImageManager sharedManager].imageDownloader setValue: nil forHTTPHeaderField:@"Accept"];
    return YES;
}
- (void)logSdk{
    UMConfigInstance.appKey = @"57bbb813e0f55abd4700146f";
    UMConfigInstance.channelId = @"App Store";
    NSString *version = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    [MobClick setAppVersion:version];
    [MobClick startWithConfigure:UMConfigInstance];
//    [MobClick setLogEnabled:YES];
}
- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end

#pragma mark -----------为了使webView加载没有证书的https需要加上------------ 
@implementation NSURLRequest(DataController)

+ (BOOL)allowsAnyHTTPSCertificateForHost:(NSString *)host

{
    
    return YES;
    
}

@end