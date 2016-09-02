//
//  AFMustListenSessionManager.h
//  MustListen
//
//  Created by 侯琛 on 16/8/1.
//  Copyright © 2016年 MustListen. All rights reserved.
//

#import "AFHTTPSessionManager.h"

@interface AFMustListenSessionManager : AFHTTPSessionManager
+(instancetype)sharedClient;
@end
