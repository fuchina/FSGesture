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
    UILabel         *_label;
    UILabel         *_titleLabel;
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
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    [button setTitle:@"取消" forState:UIControlStateNormal];
    button.frame = CGRectMake(0, 20, 60, 44);
    button.titleLabel.font = [UIFont systemFontOfSize:17];
    [button addTarget:self action:@selector(cancelClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:button];
    
    UIButton *forget = [UIButton buttonWithType:UIButtonTypeSystem];
    [forget setTitle:@"忘记？" forState:UIControlStateNormal];
    forget.frame = CGRectMake(w - 60, 20, 60, 44);
    forget.tag = 1;
    forget.titleLabel.font = [UIFont systemFontOfSize:17];
    [forget addTarget:self action:@selector(cancelClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:forget];
    
    _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(60, 20, w - 120, 44)];
    if (@available(iOS 8.2, *)) {
        _titleLabel.font = [UIFont systemFontOfSize:17 weight:UIFontWeightBold];
    }
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_titleLabel];
    
    CALayer *layer = CALayer.layer;
    layer.backgroundColor = UIColor.lightGrayColor.CGColor;
    layer.frame = CGRectMake(0, 64, w, 0.4);
    [self.layer addSublayer:layer];
    
    _label = [[UILabel alloc] initWithFrame:CGRectMake(10, 100, w - 20, 40)];
    _label.textColor = UIColor.redColor;
    _label.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_label];
    
    _g = [[FSGestureView alloc] initWithFrame:CGRectMake(20, 150, w - 40, w - 40)];
    [self addSubview:_g];
    __weak typeof(self)weakSelf = self;
    [_g setResult:^(NSString *bResult) {
        [weakSelf handleResult:bResult];
    }];
}

- (void)setTitle:(NSString *)title{
    _titleLabel.text = title;
}

- (void)cancelClick:(UIButton *)button{
    if (self.buttonClick) {
        self.buttonClick(self, button.tag == 0);
    }
}

- (void)handleResult:(NSString *)result{
    if (self.mode == FSUseGestureViewModeVerify) {
        [self handleVerify:result];
    }else if (self.mode == FSUseGestureViewModeChange) {
        [self handleSet:result];
    }else if (self.mode == FSUseGestureViewModeSet){
        [self handleChange:result];
    }
}

- (void)handleSet:(NSString *)result{
    
}

- (void)handleChange:(NSString *)result{
    
}

- (void)handleVerify:(NSString *)result{
    BOOL verifySuccess = self.password && [result isEqualToString:self.password];
    if (self.verifySuccess) {
        self.verifySuccess(self, verifySuccess);
    }
    
    if (verifySuccess == NO) {
        _label.text = @"密码输入错误，请重新输入";
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
