//
//  CFCenterView.h
//  CFButton
//
//  Created by YF on 2017/7/28.
//  Copyright © 2017年 CooFree. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CFItem,CFItemGroup;
@class CFCenterView;

// dataSource
@protocol CFCenterViewDataSource <NSObject>
@required
- (NSInteger)numberOfItemsWithCenterView:(CFCenterView *)centerView;
- (CFItem *)itemWithCenterView:(CFCenterView *)centerView item:(NSInteger)item;
@end

//delegate
@protocol CFCenterViewDelegate <NSObject,UIScrollViewDelegate>
@optional
- (void)didSelectItemWithCenterView:(CFCenterView *)centerView andItem:(CFItem *)item;
- (void)didSelectMoreWithCenterView:(CFCenterView *)centerView andItem:(CFItemGroup *)group;
@end

@interface CFCenterView : UIScrollView

@property (nonatomic,weak) id<CFCenterViewDataSource> dataSource;
@property (nonatomic,weak) id<CFCenterViewDelegate> delegate;

//重新加载数据
- (void)reloadData;
//
- (void)scrollBack;
//消失
- (void)dismis;

@end
