//
//  FSUseGestureView+Factory.m
//  FSCalculator
//
//  Created by fudongdong on 2018/12/28.
//

#import "FSUseGestureView+Factory.h"
#import "UIView+ModalAnimation.h"
#import <objc/runtime.h>

@implementation FSUseGestureView (Factory)

+ (void)verify:(UIView *)superView password:(NSString *)password success:(void(^)(FSUseGestureView * view, BOOL verifySuccess))success{
    [self verify:superView password:password success:success buttonClick:nil];
}

+ (void)verify:(UIView *)superView password:(NSString *)password success:(void(^)(FSUseGestureView * view, BOOL verifySuccess))success buttonClick:(void(^)(FSUseGestureView * view, BOOL isLeft))buttonClick{
    dispatch_async(dispatch_get_main_queue(), ^{
        const char *_akey = "sort";
        BOOL isPushing = [objc_getAssociatedObject(self, _akey) boolValue];
        if (isPushing) {
            return;
        }
        objc_setAssociatedObject(self, _akey, @YES, OBJC_ASSOCIATION_RETAIN);
        FSUseGestureView *use = [[FSUseGestureView alloc] initWithFrame:CGRectMake(0, 0, UIScreen.mainScreen.bounds.size.width, UIScreen.mainScreen.bounds.size.height)];
        use.mode = FSUseGestureViewModeVerify;
        use.password = password;
        use.titleLabel.text = @"验证手势密码";
        [superView addSubview:use];
        use.backgroundColor = UIColor.whiteColor;
        use.verifySuccess = ^(FSUseGestureView * _Nonnull view, BOOL verifySuccess) {
            if (success) {
                success(view,verifySuccess);
            }
            
            if (verifySuccess) {
                [view popAnimated:YES completion:^(UIView * _Nonnull modalView) {
                    [modalView removeFromSuperview];
                }];
            }
        };
        use.buttonClick = ^(FSUseGestureView * _Nonnull view, BOOL isLeft) {
            if (buttonClick) {
                buttonClick(view,isLeft);
            }else if (!isLeft){
                
            }
            
            if (isLeft) {
                [view popAnimated:YES completion:^(UIView * _Nonnull modalView) {
                    [modalView removeFromSuperview];
                }];
            }
        };
        [use pushAnimated:YES completion:^(UIView * _Nonnull modalView) {
            objc_setAssociatedObject(self, _akey, @NO, OBJC_ASSOCIATION_RETAIN);
        }];
    });
}


+ (void)change:(UIView *)superView password:(NSString *)password completion:(void(^)(FSUseGestureView *view))completion{
    dispatch_async(dispatch_get_main_queue(), ^{
        const char *_akey = "sort";
        BOOL isPushing = [objc_getAssociatedObject(self, _akey) boolValue];
        if (isPushing) {
            return;
        }
        objc_setAssociatedObject(self, _akey, @YES, OBJC_ASSOCIATION_RETAIN);
        
        FSUseGestureView *use = [[FSUseGestureView alloc] initWithFrame:CGRectMake(0, 0, UIScreen.mainScreen.bounds.size.width, UIScreen.mainScreen.bounds.size.height)];
        use.mode = FSUseGestureViewModeChange;
        use.password = password;
        use.showLabel.text = @"请输入原密码";
        use.titleLabel.text = @"修改手势密码";
        [superView addSubview:use];
        use.backgroundColor = UIColor.whiteColor;
        use.changeSuccess = ^(FSUseGestureView * _Nonnull view) {
            if (completion) {
                completion(view);
            }
            
            [view popAnimated:YES completion:^(UIView * _Nonnull modalView) {
                [modalView removeFromSuperview];
            }];
        };
        use.buttonClick = ^(FSUseGestureView * _Nonnull view, BOOL isLeft) {
            if (isLeft) {
                [view popAnimated:YES completion:^(UIView * _Nonnull modalView) {
                    [modalView removeFromSuperview];
                }];
            }else{
                
            }
        };
        [use pushAnimated:YES completion:^(UIView * _Nonnull modalView) {
            objc_setAssociatedObject(self, _akey, @NO, OBJC_ASSOCIATION_RETAIN);
        }];
    });
}

+ (void)setup:(UIView *)superView completion:(void(^)(FSUseGestureView *view))completion{
    dispatch_async(dispatch_get_main_queue(), ^{
        const char *_akey = "sort";
        BOOL isPushing = [objc_getAssociatedObject(self, _akey) boolValue];
        if (isPushing) {
            return;
        }
        objc_setAssociatedObject(self, _akey, @YES, OBJC_ASSOCIATION_RETAIN);
        
        FSUseGestureView *use = [[FSUseGestureView alloc] initWithFrame:CGRectMake(0, 0, UIScreen.mainScreen.bounds.size.width, UIScreen.mainScreen.bounds.size.height)];
        use.mode = FSUseGestureViewModeSet;
        use.showLabel.text = @"请设置新密码";
        use.titleLabel.text = @"设置手势密码";
        [superView addSubview:use];
        use.backgroundColor = UIColor.whiteColor;
        use.setSuccess = ^(FSUseGestureView * view) {
            if (completion) {
                completion(view);
            }
            [view popAnimated:YES completion:^(UIView * _Nonnull modalView) {
                [modalView removeFromSuperview];
            }];
        };
        use.buttonClick = ^(FSUseGestureView * _Nonnull view, BOOL isLeft) {
            if (isLeft) {
                [view popAnimated:YES completion:^(UIView * _Nonnull modalView) {
                    [modalView removeFromSuperview];
                }];
            }else{
                
            }
        };
        [use pushAnimated:YES completion:^(UIView * _Nonnull modalView) {
            objc_setAssociatedObject(self, _akey, @NO, OBJC_ASSOCIATION_RETAIN);
        }];
    });
}


@end
