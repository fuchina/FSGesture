//
//  FSGestureView.m
//  myhome
//
//  Created by FudonFuchina on 2017/8/31.
//  Copyright © 2017年 fuhope. All rights reserved.
//

#import "FSGestureView.h"
#import "FSCircleLayer.h"

@implementation FSGestureView {
    NSMutableArray  *_points;
    NSMutableArray  *_values;
    CGPoint         _currentPoint;
    
    UIColor         *_color;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self gestureDesignViews];
    }
    return self;
}

- (void)gestureDesignViews {
    _color = [UIColor colorWithRed: 18 / 255.0 green: 152 / 255.0 blue: 233 / 255.0 alpha: 1];
    self.backgroundColor = [UIColor whiteColor];
    _points = [[NSMutableArray alloc] init];
    _values = [[NSMutableArray alloc] init];
    
    CGFloat space = 10; //size.width * 2.0 / 17;
    CGFloat layerWidth = 60; //size.width * 3.0 / 17;
    CGFloat zone = 100;//size.width * 5.0 / 17;
    for (int x = 0; x < 9; x ++) {
        FSCircleLayer *layer = [[FSCircleLayer alloc] init];
        layer.index = x;
        layer.frame = CGRectMake(space + (x % 3) * zone, space + (x / 3) * zone, layerWidth, layerWidth);
        layer.cornerRadius = layer.bounds.size.height / 2;
        layer.borderColor = _color.CGColor;
        layer.borderWidth = 1;
        [self.layer addSublayer:layer];
        [_points addObject:layer];
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    [self handleTouches:touches];
    if (self.start) {
        self.start();
    }
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesMoved:touches withEvent:event];
    [self handleTouches:touches];
    [self setNeedsDisplay];
}

- (void)handleTouches:(NSSet<UITouch *>*)touches {
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self];
    _currentPoint = point;
    
    FSCircleLayer *layer = [self pointInCircle:point];
    if (layer && (![_values containsObject:layer])) {
        [_values addObject:layer];
    }
}

- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesEnded:touches withEvent:event];
    [self resetCircleLayes:_values];
    [self setNeedsDisplay];
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesEnded:touches withEvent:event];
    
    NSMutableString *str = [[NSMutableString alloc] init];
    for (FSCircleLayer *layer in _values) {
        [str appendFormat:@"%d",layer.index];
    }
    if (self.result) {
        self.result(str);
        [self resetCircleLayes:_values];
    }
}

- (void)resetCircleLayes:(NSMutableArray<FSCircleLayer *> *)layers {
    for (FSCircleLayer *layer in layers) {
        [layer setStatus:NO];
    }
    
    if ([layers isKindOfClass:NSMutableArray.class]) {
        [layers removeAllObjects];
    }
    [self setNeedsDisplay];
}

- (FSCircleLayer *)pointInCircle:(CGPoint)point {
    for (FSCircleLayer *layer in _points) {
        CGRect frame = layer.frame;
        if (CGRectContainsPoint(frame, point)) {
            return layer;
        }
    }
    return nil;
}

- (void)drawRect:(CGRect)rect {
    if (_values.count == 0) {
        return;
    }
    CGContextRef contextRef = UIGraphicsGetCurrentContext();
    UIBezierPath *path = [UIBezierPath bezierPath];
    [[UIColor blueColor] setFill];
    [[UIColor redColor] setStroke];
    CGContextSetLineWidth(contextRef, 1);
    path.lineJoinStyle = kCGLineJoinMiter;
    [_color set];

    for (int i = 0; i < _values.count; i++) {
        FSCircleLayer *layer = _values[i];
        [layer setStatus:YES];
        CGSize size = layer.frame.size;
        CGPoint origin = layer.frame.origin;
        CGPoint center = CGPointMake(origin.x + size.width / 2, origin.y + size.height / 2);
        if (i == 0) {
            [path moveToPoint:center];
        }else{
            [path addLineToPoint:center];
        }
    }
    [path addLineToPoint:_currentPoint];
    CGContextAddPath(contextRef, path.CGPath);
    CGContextStrokePath(contextRef);
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
