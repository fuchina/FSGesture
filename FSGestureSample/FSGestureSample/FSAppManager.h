//
//  FSAppManager.h
//  FSGestureSample
//
//  Created by fudongdong on 2018/12/29.
//  Copyright © 2018年 fudongdong. All rights reserved.
//

#import <UIKit/UIKit.h>

static NSString *FSAppManagerLockScreenNotification = @"FSAppManagerLockScreenNotification";

@interface FSAppManager : NSObject

+ (instancetype)sharedInstance;
+ (void)setup;

@property (nonatomic,assign) NSInteger  delay;// 退到后台后，多久锁屏
@property (assign,nonatomic) BOOL       open;

@end
