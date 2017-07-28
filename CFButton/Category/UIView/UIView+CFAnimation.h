//
//  UIView+CFAnimation.h
//  CFButton
//
//  Created by YF on 2017/7/28.
//  Copyright © 2017年 CooFree. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (CFAnimation)

//淡入
- (void)fadeInWithTime:(NSTimeInterval)time;
//淡出
- (void)fadeOutWithTime:(NSTimeInterval)time;
//缩放
- (void)scalingWithTime:(NSTimeInterval)time andscal:(CGFloat)scal;
//旋转
- (void)RevolvingWithTime:(NSTimeInterval)time andDelta:(CGFloat)delta;


@end
