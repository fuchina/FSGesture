//
//  FSUseGestureView+Factory.h
//  FSCalculator
//
//  Created by fudongdong on 2018/12/28.
//

#import "FSUseGestureView.h"


@interface FSUseGestureView (Factory)


// 校验
+ (void)verify:(UIView *)superView password:(NSString *)password;
+ (void)verify:(UIView *)superView password:(NSString *)password success:(void(^)(FSUseGestureView * view, BOOL verifySuccess))success buttonClick:(void(^)(FSUseGestureView * view, BOOL isLeft))buttonClick;

@end

