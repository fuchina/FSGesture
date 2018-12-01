//
//  FSCircleLayer.h
//  myhome
//
//  Created by FudonFuchina on 2017/8/31.
//  Copyright © 2017年 fuhope. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import <UIKit/UIKit.h>

@interface FSCircleLayer : CALayer

@property (nonatomic,assign) int index;

- (void)setStatus:(BOOL)linked;

@end
