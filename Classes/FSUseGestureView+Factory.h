//
//  FSUseGestureView+Factory.h
//  FSCalculator
//
//  Created by fudongdong on 2018/12/28.
//

#import "FSUseGestureView.h"

@interface FSUseGestureView (Factory)


// 校验
+ (void)verify:(UIView *)superView password:(NSString *)password success:(void(^)(FSUseGestureView * view, BOOL verifySuccess))success;

// 修改
+ (void)change:(UIView *)superView password:(NSString *)password completion:(void(^)(FSUseGestureView *view))completion;

// 设置
+ (void)setup:(UIView *)superView completion:(void(^)(FSUseGestureView *view))completion;

@end

