//
//  FSUseGestureView.h
//  FSCalculator
//
//  Created by fudongdong on 2017/12/27.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, FSUseGestureViewMode) {
    FSUseGestureViewModeUndefine,         // 未定义
    FSUseGestureViewModeVerify,           // 校验
    FSUseGestureViewModeSet,              // 设置
    FSUseGestureViewModeChange,           // 修改
};

@interface FSUseGestureView : UIView

@property (nonatomic,strong) UIButton   *leftButton;
@property (nonatomic,strong) UIButton   *rightButton;
@property (nonatomic,strong) UILabel    *titleLabel;
@property (nonatomic,strong) UILabel    *showLabel;

@property (nonatomic,assign) FSUseGestureViewMode  mode;
@property (nonatomic,copy) void(^buttonClick)(FSUseGestureView *view,BOOL isLeft);

/*
 * 外部设置的原密码，用于修改密码、校验密码；当设置密码时，不能从外部设置
 */
@property (nonatomic,copy) NSString     *password;

/*
 *  校验，需要传入原密码
 *  结果：verifySuccess为YES表示校验通过
 */
@property (nonatomic,copy) void(^verifySuccess)(FSUseGestureView *view,BOOL verifySuccess);
@property (nonatomic,copy) void(^changeSuccess)(FSUseGestureView *view);
@property (nonatomic,copy) void(^setSuccess)(FSUseGestureView *view);

@end

NS_ASSUME_NONNULL_END
