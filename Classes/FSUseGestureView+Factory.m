//
//  FSUseGestureView+Factory.m
//  FSCalculator
//
//  Created by fudongdong on 2018/12/28.
//

#import "FSUseGestureView+Factory.h"
#import "UIView+ModalAnimation.h"

@implementation FSUseGestureView (Factory)

+ (void)verify:(UIView *)superView password:(NSString *)password{
    [self verify:superView password:password success:nil buttonClick:nil];
}

+ (void)verify:(UIView *)superView password:(NSString *)password success:(void(^)(FSUseGestureView * view, BOOL verifySuccess))success buttonClick:(void(^)(FSUseGestureView * view, BOOL isLeft))buttonClick{
    FSUseGestureView *use = [[FSUseGestureView alloc] initWithFrame:CGRectMake(0, 0, UIScreen.mainScreen.bounds.size.width, UIScreen.mainScreen.bounds.size.height)];
    use.mode = FSUseGestureViewModeVerify;
    use.password = password;
    use.titleLabel.text = @"验证手势密码";
    [superView addSubview:use];
    use.backgroundColor = UIColor.whiteColor;
    use.verifySuccess = ^(FSUseGestureView * _Nonnull view, BOOL verifySuccess) {
        if (success) {
            success(view,verifySuccess);
        }else{
            if (verifySuccess) {
                [view popAnimated:YES completion:^(UIView * _Nonnull modalView) {
                    [modalView removeFromSuperview];
                }];
            }
        }
    };
    use.buttonClick = ^(FSUseGestureView * _Nonnull view, BOOL isLeft) {
        if (buttonClick) {
            buttonClick(view,isLeft);
        }else{
            if (isLeft) {
                [view popAnimated:YES completion:^(UIView * _Nonnull modalView) {
                    [modalView removeFromSuperview];
                }];
            }else{
                
            }
        }
    };
    [use pushAnimated:YES completion:^(UIView * _Nonnull modalView) {

    }];
}

@end
