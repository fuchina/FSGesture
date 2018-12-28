//
//  ViewController.m
//  FSGestureSample
//
//  Created by fudongdong on 2018/12/27.
//  Copyright © 2018年 fudongdong. All rights reserved.
//

#import "ViewController.h"
#import "FSUseGestureView.h"
#import "UIView+ModalAnimation.h"
#import "FSUseGestureView+Factory.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    button.backgroundColor = UIColor.redColor;
    button.frame = CGRectMake(10, 100, self.view.frame.size.width - 20, 50);
    [button setTitle:@"TEST" forState:UIControlStateNormal];
    [self.view addSubview:button];
    [button addTarget:self action:@selector(buttonClick) forControlEvents:UIControlEventTouchUpInside];
}

- (void)buttonClick{
    [self verify];
}

- (void)set{
    FSUseGestureView *use = [[FSUseGestureView alloc] initWithFrame:CGRectMake(0, 0, UIScreen.mainScreen.bounds.size.width, UIScreen.mainScreen.bounds.size.height)];
    use.mode = FSUseGestureViewModeSet;
    use.showLabel.text = @"请设置新密码";
    use.titleLabel.text = @"设置手势密码";
    [self.view addSubview:use];
    use.backgroundColor = UIColor.whiteColor;
    use.setSuccess = ^(FSUseGestureView * _Nonnull view) {
        [view popAnimated:YES completion:^(UIView * _Nonnull modalView) {
            [modalView removeFromSuperview];
        }];
    };
    use.buttonClick = ^(FSUseGestureView * _Nonnull view, BOOL isLeft) {
        if (isLeft) {
            [view popAnimated:YES completion:^(UIView * _Nonnull modalView) {
                [modalView removeFromSuperview];
            }];
        }
    };
    [use pushAnimated:YES completion:^(UIView * _Nonnull modalView) {
        NSLog(@"modalView");
    }];
}

- (void)change{
    FSUseGestureView *use = [[FSUseGestureView alloc] initWithFrame:CGRectMake(0, 0, UIScreen.mainScreen.bounds.size.width, UIScreen.mainScreen.bounds.size.height)];
    use.mode = FSUseGestureViewModeChange;
    use.password = @"123";
    use.showLabel.text = @"请输入原密码";
    use.titleLabel.text = @"修改手势密码";
    [self.view addSubview:use];
    use.backgroundColor = UIColor.whiteColor;
    use.changeSuccess = ^(FSUseGestureView * _Nonnull view) {
        [view popAnimated:YES completion:^(UIView * _Nonnull modalView) {
            [modalView removeFromSuperview];
        }];
    };
    use.buttonClick = ^(FSUseGestureView * _Nonnull view, BOOL isLeft) {
        if (isLeft) {
            [view popAnimated:YES completion:^(UIView * _Nonnull modalView) {
                [modalView removeFromSuperview];
            }];
        }
    };
    [use pushAnimated:YES completion:^(UIView * _Nonnull modalView) {
        NSLog(@"modalView");
    }];
}

- (void)verify{
    [FSUseGestureView verifyOnSuperView:self.view password:@"123" titleText:@"验证手势密码" success:^(FSUseGestureView * _Nonnull view, BOOL verifySuccess) {
        
    } buttonClick:^(FSUseGestureView * _Nonnull view, BOOL isLeft) {
        
    }];
}

@end
