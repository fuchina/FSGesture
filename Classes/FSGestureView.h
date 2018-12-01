//
//  FSGestureView.h
//  myhome
//
//  Created by FudonFuchina on 2017/8/31.
//  Copyright © 2017年 fuhope. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FSGestureView : UIView


@property (nonatomic,copy) void (^start)(void);
// 结果回调
@property (nonatomic,copy) void (^result)(NSString *bResult);

@end
