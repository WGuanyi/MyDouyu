//
//  HTTPManager.h
//  MyDouYu
//
//  Created by 王冠一 on 16/9/5.
//  Copyright © 2016年 guanyi. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>

@interface HTTPManager : AFHTTPSessionManager

+ (id)sharedInstance;

@end