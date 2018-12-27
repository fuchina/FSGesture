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

@property (nonatomic,assign) FSUseGestureViewMode  mode;

- (void)setTitle:(NSString *)title;

@property (nonatomic,copy) void(^buttonClick)(FSUseGestureView *view,BOOL isLeft);

/*
 *  校验，需要传入原密码
 *  结果：verifySuccess为YES表示校验通过
 */
@property (nonatomic,copy) NSString     *password;
@property (nonatomic,copy) void(^verifySuccess)(FSUseGestureView *view,BOOL verifySuccess);

@end

NS_ASSUME_NONNULL_END
