//
//  ViewController.m
//  FSGestureSample
//
//  Created by fudongdong on 2018/12/27.
//  Copyright © 2018年 fudongdong. All rights reserved.
//

#import "ViewController.h"
#import "FSAppManager.h"

@interface ViewController ()

@end

@implementation ViewController{
    UIView  *_showView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notiHandle) name:FSAppManagerLockScreenNotification object:nil];
    
    CGFloat wh = self.view.frame.size.width;
    CGFloat w = wh / 2;
    for (int x = 0; x < 2; x ++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
        button.backgroundColor = UIColor.redColor;
        button.tag = x;
        button.frame = CGRectMake(x + w * x, 100, w - x, 50);
        [button setTitle:x?@"unlock":@"test" forState:UIControlStateNormal];
        [self.view addSubview:button];
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    _showView = [[UIView alloc] initWithFrame:CGRectMake(self.view.frame.size.width / 2 - 5, 180, 10, 10)];
    _showView.layer.cornerRadius = 5;
    _showView.backgroundColor = UIColor.redColor;
    [self.view addSubview:_showView];
    
    FSAppManager.sharedInstance.delay = 5;
}

- (void)buttonClick:(UIButton *)button{
    if (button.tag == 0) {

    }else{
        FSAppManager.sharedInstance.open = YES;
        _showView.backgroundColor = UIColor.greenColor;
    }
}

- (void)notiHandle{
    BOOL open = FSAppManager.sharedInstance.open;
    if (open) {
        _showView.backgroundColor = UIColor.greenColor;
    }else{
        _showView.backgroundColor = UIColor.redColor;
    }
}

@end
