//
//  CFTopButtonView.h
//  CFButton
//
//  Created by YF on 2017/8/3.
//  Copyright © 2017年 CooFree. All rights reserved.
//

#import <UIKit/UIKit.h>

//delegate
@protocol CFTopButtonViewDelegate <NSObject>
@optional
- (void)didSelectTopButtonViewMainButton;
- (void)didSelectTopButtonViewItemButton;
@end

@interface CFTopButtonView : UIView

@property (nonatomic,weak) id<CFTopButtonViewDelegate> delegate;

- (void)dismis;
- (void)reloadData;

@end
