//
//  FSUseGestureView.m
//  FSCalculator
//
//  Created by fudongdong on 2017/12/27.
//

#import "FSUseGestureView.h"
#import "FSGestureView.h"

@implementation FSUseGestureView{
    FSGestureView   *_g;
    
    // 用于修改密码
    NSInteger       _changeFlag;
    NSString        *_modifyPassword;
    
    // 用于设置密码
    NSInteger       _setFlag;
    NSString        *_setPassword;
}

#if DEBUG
- (void)dealloc{
    NSLog(@"FSUseGestureView dealloc");
}
#endif

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self designViews];
    }
    return self;
}

- (void)designViews{
    CGFloat w = UIScreen.mainScreen.bounds.size.width;
    CGFloat statusBarHeight = UIApplication.sharedApplication.statusBarFrame.size.height;
    
    _leftButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [_leftButton setTitle:@"取消" forState:UIControlStateNormal];
    _leftButton.frame = CGRectMake(0, statusBarHeight, 60, 44);
    _leftButton.titleLabel.font = [UIFont systemFontOfSize:17];
    [_leftButton addTarget:self action:@selector(cancelClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_leftButton];
    
    _rightButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [_rightButton setTitle:@"忘记？" forState:UIControlStateNormal];
    _rightButton.frame = CGRectMake(w - 60, statusBarHeight, 60, 44);
    _rightButton.titleLabel.font = [UIFont systemFontOfSize:17];
    [_rightButton addTarget:self action:@selector(cancelClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_rightButton];
    
    _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(60, statusBarHeight, w - 120, 44)];
    if (@available(iOS 8.2, *)) {
        _titleLabel.font = [UIFont systemFontOfSize:17 weight:UIFontWeightBold];
    }
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_titleLabel];
    
    CALayer *layer = CALayer.layer;
    layer.backgroundColor = UIColor.lightGrayColor.CGColor;
    layer.frame = CGRectMake(0, statusBarHeight + 44, w, 0.4);
    [self.layer addSublayer:layer];
    
    _showLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, statusBarHeight + 80, w - 20, 40)];
    _showLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_showLabel];
    
    _g = [[FSGestureView alloc] initWithFrame:CGRectMake(20, statusBarHeight + 130, w - 40, w - 40)];
    [self addSubview:_g];
    __weak typeof(self)this = self;
    [_g setResult:^(NSString *bResult) {
        [this handleResult:bResult];
    }];
    _g.start = ^{
        this.showLabel.text = nil;
    };    
}

- (void)cancelClick:(UIButton *)button{
    if (self.buttonClick) {
        self.buttonClick(self, button == _leftButton);
    }
}

- (void)handleResult:(NSString *)result{
    if (self.mode == FSUseGestureViewModeVerify) {
        [self handleVerify:result];
    }else if (self.mode == FSUseGestureViewModeChange) {
        [self handleChange:result];
    }else if (self.mode == FSUseGestureViewModeSet){
        [self handleSet:result];
    }
}

- (void)handleSet:(NSString *)result{
    if (_setFlag == 0) {
        _setFlag ++;
        _setPassword = result;
        [self showLabelText:@"请再次输入确认" textColor:UIColor.blackColor];
    }else if (_setFlag == 1){
        if ([result isEqualToString:_setPassword]) {
            if (self.setSuccess) {
                self.setSuccess(self);
            }
        }else{
            _setFlag = 0;
            [self showLabelText:@"两次输入不一致，请重新输入" textColor:UIColor.redColor];
        }
    }
}

- (void)handleChange:(NSString *)result{
    if (_changeFlag == 0) {
        if ([result isEqualToString:self.password]) {
            _changeFlag ++;
            [self showLabelText:@"请设置新的手势密码" textColor:UIColor.blackColor];
        }else{
            [self showLabelText:@"原密码校验错误，请重新输入" textColor:UIColor.redColor];
        }
    }else if (_changeFlag == 1){
        _changeFlag ++;
        _modifyPassword = result;
        [self showLabelText:@"请再次输入确认" textColor:UIColor.blackColor];
    }else if (_changeFlag == 2){
        if ([result isEqualToString:_modifyPassword]) {
            if (self.changeSuccess) {
                self.changeSuccess(self);
            }
        }else{
            _changeFlag = 1;
            [self showLabelText:@"两次输入不一致，请重新输入" textColor:UIColor.redColor];
        }
    }
}

- (void)handleVerify:(NSString *)result{
    BOOL verifySuccess = self.password && [result isEqualToString:self.password];
    if (self.verifySuccess) {
        self.verifySuccess(self, verifySuccess);
    }
    
    if (verifySuccess == NO) {
        [self showLabelText:@"密码输入错误，请重新输入" textColor:UIColor.redColor];
    }
}

- (void)showLabelText:(NSString *)text textColor:(UIColor *)color{
    _showLabel.text = text;
    _showLabel.textColor = color;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
