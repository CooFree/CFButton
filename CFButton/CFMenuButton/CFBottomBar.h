//
//  CFBottomBar.h
//  CFButton
//
//  Created by YF on 2017/8/1.
//  Copyright © 2017年 CooFree. All rights reserved.
//

#import <UIKit/UIKit.h>

#define BHBBOTTOMHEIGHT ((57.0 / 736.0) * [UIScreen mainScreen].bounds.size.height)

typedef void (^BackClick)();
typedef void (^CloseClick)();

@interface CFBottomBar : UIView

@property (nonatomic,assign) BOOL isMoreBar;

@property (nonatomic,copy) BackClick backClick;

@property (nonatomic,copy) CloseClick closeClick;

//恢复按钮位置
- (void)btnResetPosition;

@end
