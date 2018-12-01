//
//  FSCircleLayer.m
//  myhome
//
//  Created by FudonFuchina on 2017/8/31.
//  Copyright © 2017年 fuhope. All rights reserved.
//

#import "FSCircleLayer.h"

@implementation FSCircleLayer{
    BOOL        _highlighted;
    CALayer     *_subLayer;
}

- (void)dealloc{
    
}

- (void)setStatus:(BOOL)linked{
    _highlighted = linked;
    [self setNeedsDisplay];
}

- (void)drawInContext:(CGContextRef)ctx{
    [super drawInContext:ctx];
    
    if (_highlighted){
        CGRect circleFrame = self.bounds;
        UIBezierPath *circlePath = [UIBezierPath bezierPathWithRoundedRect:circleFrame
                                                              cornerRadius:circleFrame.size.height / 2.0];
        CGContextSetFillColorWithColor(ctx, [FSCircleLayer backColor]);
        CGContextAddPath(ctx, circlePath.CGPath);
        CGContextFillPath(ctx);
        
        CGContextSetFillColorWithColor(ctx, [FSCircleLayer backColor]);
        CGContextAddPath(ctx, circlePath.CGPath);
        CGContextFillPath(ctx);
        
        if (!_subLayer) {
            CGFloat width = self.frame.size.width;
//            CGFloat height = self.frame.size.height;
//            CGFloat subWidth = width - 10;
            CGFloat subWidth = width;
            
//            _subLayer = [CALayer layer];
//            _subLayer.frame = CGRectMake(width / 2 - subWidth / 2, height / 2 - subWidth / 2, subWidth, subWidth);
//            _subLayer.backgroundColor = [FSCircleLayer innerBackgroundColor].CGColor;
//            _subLayer.cornerRadius = subWidth / 2.0;
//            [self addSublayer:_subLayer];
            
            CALayer *centerLayer = [CALayer layer];
            centerLayer.frame = CGRectMake(subWidth / 2 - 5, subWidth / 2 - 5, 10, 10);
            centerLayer.backgroundColor = [FSCircleLayer centerBackgroundColor].CGColor;
            centerLayer.cornerRadius = 5;
            [self addSublayer:centerLayer];
            _subLayer = centerLayer;
        }
    }
    _subLayer.hidden = !_highlighted;
}

+ (CGColorRef)backColor{
    static CGColorRef backColor = nil;
    if (!backColor) {
        backColor = [UIColor clearColor].CGColor;
    }
    return backColor;
}

// 内圆背景颜色
+ (UIColor *)innerBackgroundColor{
    static UIColor *backColor = nil;
    if (!backColor) {
        backColor = [UIColor colorWithRed:209/255.0 green:223/255.0 blue:234/255.0 alpha:1.0];
    }
    return backColor;
}

// 圆心背景颜色
+ (UIColor *)centerBackgroundColor{
    static UIColor *cBackColor = nil;
    if (!cBackColor) {
        cBackColor = [UIColor colorWithRed:54/255.0 green:133/255.0 blue:206/255.0 alpha:1.0];
    }
    return cBackColor;
}

@end
