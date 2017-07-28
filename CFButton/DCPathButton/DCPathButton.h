//
//  DCPathButton.h
//  DCPathButton
//
//  Created by tang dixi on 30/7/14.
//  Copyright (c) 2014 Tangdxi. All rights reserved.
//

#import "DCPathItemButton.h"

@import UIKit;
@import QuartzCore;
@import AudioToolbox;

//按钮散落方向
typedef NS_ENUM(NSUInteger, PathDirection) {
    PathDirectionLeft,
    PathDirectionRight,
    PathDirectionUP,
    PathDirectionDown,
};

@protocol DCPathButtonDelegate <NSObject>

- (void)itemButtonTappedAtIndex:(NSUInteger)index;

@end

@interface DCPathButton : UIView

@property (weak, nonatomic) id<DCPathButtonDelegate> delegate;
@property (nonatomic, assign) PathDirection pathDirection;

@property (strong, nonatomic) NSMutableArray *itemButtonImages;
@property (strong, nonatomic) NSMutableArray *itemButtonHighlightedImages;

@property (strong, nonatomic) UIImage *itemButtonBackgroundImage;
@property (strong, nonatomic) UIImage *itemButtonBackgroundHighlightedImage;

@property (assign, nonatomic) CGFloat bloomRadius;

/**
 按钮的中心位置
 */
@property (assign, nonatomic) CGPoint patnBtnCenter;

- (id)initWithCenterImage:(UIImage *)centerImage hilightedImage:(UIImage *)centerHighlightedImage;
- (void)addPathItems:(NSArray *)pathItemButtons;

@end
