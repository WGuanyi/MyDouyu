//
//  HTTPManager.m
//  MyDouYu
//
//  Created by 王冠一 on 16/9/5.
//  Copyright © 2016年 guanyi. All rights reserved.
//

#import "HTTPManager.h"

@implementation HTTPManager
static HTTPManager *_sharedInstance = nil;

+ (id)sharedInstance {
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        _sharedInstance = [self manager];
        _sharedInstance.requestSerializer = [AFHTTPRequestSerializer serializer];
        _sharedInstance.responseSerializer = [AFHTTPResponseSerializer serializer];
        _sharedInstance.requestSerializer.timeoutInterval = 10;
        
    });
    
    return _sharedInstance;
}

@end
