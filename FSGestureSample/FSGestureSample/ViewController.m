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
    FSUseGestureView *use = [[FSUseGestureView alloc] initWithFrame:CGRectMake(0, 0, UIScreen.mainScreen.bounds.size.width, UIScreen.mainScreen.bounds.size.height)];
    use.mode = FSUseGestureViewModeVerify;
    use.password = @"123";
    [use setTitle:@"验证手势密码"];
    [self.view addSubview:use];
    use.backgroundColor = UIColor.whiteColor;
    use.verifySuccess = ^(FSUseGestureView * _Nonnull view, BOOL verifySuccess) {
        if (verifySuccess) {
            [view popAnimated:YES completion:^(UIView * _Nonnull modalView) {
                [modalView removeFromSuperview];
            }];
        }
    };
    use.buttonClick = ^(FSUseGestureView * _Nonnull view, BOOL isLeft) {
        if (isLeft) {
            [view popAnimated:YES completion:^(UIView * _Nonnull modalView) {
                [modalView removeFromSuperview];
            }];            
        }
    };
    [use pushAnimated:YES completion:nil];
}

@end
