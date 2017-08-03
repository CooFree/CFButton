//
//  CFMenuPopView.h
//  CFButton
//
//  Created by YF on 2017/7/28.
//  Copyright © 2017年 CooFree. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CFItemGroup.h"

typedef NS_ENUM(NSUInteger, MenuPopType) {
    MenuPopTypeScreen,
    MenuPopTypeButton,
};

typedef void (^DidSelectItemBlock) (CFItem * item);


@interface CFMenuPopView : UIView

@property (nonatomic, assign) MenuPopType popType;
/**
 *  如果显示一个带more功能的，请使用此方法
 *
 *  @param view  父view
 *  @param array BHBItem类型的集合
 *  @param block 回调
 *  @return pop视图
 */
+ (instancetype)showToView:(UIView *)view withItems:(NSArray *)array andSelectBlock:(DidSelectItemBlock)block;
+ (instancetype)showToView:(UIView *)view mainButtonFrame:(CGRect)mainBtnFrame withType:(MenuPopType)type andSelectBlock:(DidSelectItemBlock)block;

@end
