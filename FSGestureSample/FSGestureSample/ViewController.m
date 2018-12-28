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
    [self set];
}

- (void)set{
    [FSUseGestureView setup:self.view completion:^(FSUseGestureView *view) {
        
    }];
}

- (void)change{
    [FSUseGestureView change:self.view password:@"123" completion:^(FSUseGestureView *view) {
        
    }];
}

- (void)verify{
    [FSUseGestureView verify:self.view password:@"123" success:^(FSUseGestureView *view, BOOL verifySuccess) {
        
    }];
}

@end
