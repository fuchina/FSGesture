//
//  FSAppManager.m
//  FSGestureSample
//
//  Created by fudongdong on 2018/12/29.
//  Copyright © 2018年 fudongdong. All rights reserved.
//

#import "FSAppManager.h"

@implementation FSAppManager{
    dispatch_block_t       _delayTask;
}

+ (instancetype)sharedInstance{
    static dispatch_once_t onceToken;
    static FSAppManager *_instance;
    dispatch_once(&onceToken, ^{
        _instance = [[FSAppManager alloc] init];
    });
    return _instance;
}

- (instancetype)init{
    self = [super init];
    if (self) {
        [self addNotifications:
         UIApplicationDidEnterBackgroundNotification,
         UIApplicationDidReceiveMemoryWarningNotification,
         UIApplicationDidBecomeActiveNotification,nil];
    }
    return self;
}

- (void)addNotifications:(NSString *)names,...NS_REQUIRES_NIL_TERMINATION{
    va_list args;
    va_start(args, names);
    if (names){
        NSNotificationCenter *center = NSNotificationCenter.defaultCenter;
        for (NSString *str = names; str != nil; str = va_arg(args, NSString *)) {
            [center addObserver:self selector:@selector(handleNotification:) name:str object:nil];
        }
    }
    va_end(args);
}

- (void)handleNotification:(NSNotification *)notification{
    NSString *name = notification.name;
    if ([name isEqualToString:UIApplicationDidBecomeActiveNotification]) {
        [self handleLockWhenBecomeActive];
    }else if ([name isEqualToString:UIApplicationDidEnterBackgroundNotification]){
        [self handleLockWhenEnterBackground];
    }else if ([name isEqualToString:UIApplicationProtectedDataWillBecomeUnavailable]){
        [self handleLockWhenProtectedDataUnavailable];
    }else if ([name isEqualToString:UIApplicationProtectedDataDidBecomeAvailable]){
        [self handleLockWhenProtectedDataAvailable];
    }else if ([name isEqualToString:UIApplicationDidReceiveMemoryWarningNotification]){
        
    }
}

/************************************************************************************************************************************************/
- (void)handleLockWhenProtectedDataUnavailable{
    
}

- (void)handleLockWhenProtectedDataAvailable{
    
}

- (void)handleLockWhenBecomeActive{
    [self cancelTaske];
}

- (void)handleLockWhenEnterBackground{
    [self cancelTaske];
    [self createTask];
}

- (void)createTask{
    __weak typeof(self)this = self;
    _delayTask = dispatch_block_create(DISPATCH_BLOCK_BARRIER, ^{
        this.open = NO;
        [[NSNotificationCenter defaultCenter] postNotificationName:FSAppManagerLockScreenNotification object:nil];
        
        [this cancelTaske];
    });
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(MAX(self.delay, 3) * NSEC_PER_SEC)), dispatch_get_main_queue(), _delayTask);
}

- (void)cancelTaske{
    if (_delayTask) {
        dispatch_block_cancel(_delayTask);
        _delayTask = nil;
    }
}
/************************************************************************************************************************************************/

+ (void)setup{
    [[FSAppManager sharedInstance] class];
}

@end
