//
//  AFMustListenSessionManager.m
//  MustListen
//
//  Created by 侯琛 on 16/8/1.
//  Copyright © 2016年 MustListen. All rights reserved.
//

#import "AFMustListenSessionManager.h"

static NSString * const APIBaseURLString = BaseUrl;
@implementation AFMustListenSessionManager
+(instancetype)sharedClient{
    static AFMustListenSessionManager *_sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        _sharedClient = [[AFMustListenSessionManager alloc] initWithBaseURL:[NSURL URLWithString:APIBaseURLString]];
        _sharedClient.securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
        _sharedClient.requestSerializer = [ AFHTTPRequestSerializer serializer];
        [_sharedClient.requestSerializer setValue:@"Accept" forHTTPHeaderField:@"text/html"];
        _sharedClient.responseSerializer  = [AFHTTPResponseSerializer serializer];
        
    });
    
    return _sharedClient;
}
@end
