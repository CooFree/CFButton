//
//  CFTopButtonView.m
//  CFButton
//
//  Created by YF on 2017/8/3.
//  Copyright © 2017年 CooFree. All rights reserved.
//

#import "CFTopButtonView.h"
#import "CFItem.h"
#import "UIButton+ImageTitleSpacing.h"
#import "UIView+CFAnimation.h"

@interface CFTopButtonView () {
    UIButton *mainButton;
}
@property (nonatomic,strong) NSMutableArray * visableBtnArray;
@property (nonatomic, assign) CGRect originFrame;
@end

@implementation CFTopButtonView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
//        self.backgroundColor = [UIColor lightGrayColor];
        mainButton = [UIButton buttonWithType:UIButtonTypeCustom];
        mainButton.frame = CGRectMake(0, frame.size.width*2, frame.size.width, frame.size.width);
        self.originFrame = mainButton.frame;

        [mainButton setImage:[UIImage imageNamed:@"miyou_icon_+_fabu"] forState:UIControlStateNormal];
//        [button setImage:[UIImage imageNamed:@"miyou_icon_close"] forState:UIControlStateSelected];
//        button.selected = YES;
        [mainButton addTarget:self action:@selector(mainButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [mainButton RevolvingWithTime:.25 andDelta:(-M_PI_4)];

        [self addSubview:mainButton];
    }
    return self;
}
- (void)reloadData {
    [self layoutBtns];
    [self btnPositonAnimation:NO];
}
- (void)layoutBtns {
    CFItem * item32 = [[CFItem alloc]initWithTitle:@"Weibo Camera" Icon:@"images.bundle/tabbar_compose_wbcamera"];
    CFItem * item33 = [[CFItem alloc]initWithTitle:@"Music" Icon:@"images.bundle/tabbar_compose_music"];
    NSArray *items = @[item32,item33];

    CFItem * item;
    for (int i = 0; i < items.count; i ++) {
        item = items[i];
        UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
        //        [btn bhb_setImage:[NSString stringWithFormat:@"%@",item.icon]];
        UIImage * image = [UIImage imageNamed:[NSString stringWithFormat:@"%@",item.icon]];
        [btn setImage:image forState:UIControlStateNormal];
        [btn.imageView setContentMode:UIViewContentModeCenter];
//        [btn setTitle:item.title forState:UIControlStateNormal];
        btn.titleLabel.textAlignment = NSTextAlignmentCenter;
        [btn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:14];

//        CGFloat x = (i % 3) * self.frame.size.width / 3.0;
        CGFloat y = i * self.frame.size.height / 3.0 ;

        CGFloat width = self.originFrame.size.width;
        CGFloat height = self.originFrame.size.height;
        [btn addTarget:self action:@selector(didClickBtn:) forControlEvents:UIControlEventTouchUpInside];
        [btn addTarget:self action:@selector(didTouchBtn:) forControlEvents:UIControlEventTouchDown];
        [btn addTarget:self action:@selector(didCancelBtn:) forControlEvents:UIControlEventTouchDragInside];
        [self addSubview:btn];
        btn.frame = CGRectMake(0, y, width, height);
//        btn.backgroundColor = [UIColor colorWithRed:arc4random_uniform(255)/255.0 green:arc4random_uniform(255)/255.0 blue:arc4random_uniform(255)/255.0 alpha:arc4random_uniform(255)/255.0];
//        [btn layoutButtonWithEdgeInsetsStyle:CFButtonEdgeInsetsStyleTop imageTitleSpace:5];
        [self.visableBtnArray addObject:btn];

    }
}
- (void)mainButtonClick:(UIButton *)sender {
    [self btnPositonAnimation:YES];

    if ([self.delegate respondsToSelector:@selector(didSelectTopButtonViewMainButton)]) {
        [self.delegate didSelectTopButtonViewMainButton];
    }
}
- (void)dismis {
    [self btnPositonAnimation:YES];
}
- (void)didTouchBtn:(UIButton *)btn{
    [btn scalingWithTime:.15 andscal:1.2];
}

- (void)didCancelBtn:(UIButton *)btn{
    [btn scalingWithTime:.15 andscal:1];
}
- (void)didClickBtn:(UIButton *)btn{
    [btn scalingWithTime:.25 andscal:1.7];
    [btn fadeOutWithTime:.25];
    [self.visableBtnArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        UIButton * b = obj;
        if (b != btn) {
            [b scalingWithTime:.25 andscal:0.3];
            [b fadeOutWithTime:.25];
        }
    }];

    [self mainButtonClose];

    if ([self.delegate respondsToSelector:@selector(didSelectTopButtonViewItemButton)]) {
        [self.delegate didSelectTopButtonViewItemButton];
    }
}
- (void)mainButtonClose {
    [mainButton RevolvingWithTime:.25 andDelta:(M_PI_2)];
}
- (void)btnPositonAnimation:(BOOL)isDismis{

    self.superview.superview.userInteractionEnabled = YES;

    if (isDismis) {
        [self mainButtonClose];
        [self removeAnimation];
    }else{
        [self moveInAnimation];
    }

}
- (void)removeAnimation{
    [self.visableBtnArray enumerateObjectsWithOptions:NSEnumerationReverse usingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        UIButton * btn = obj;
        CGFloat x = btn.frame.origin.x;
//        CGFloat y = btn.frame.origin.y;
        CGFloat width = btn.frame.size.width;
        CGFloat height = btn.frame.size.height;
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)((self.visableBtnArray.count - idx) * 0.03 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [UIView animateWithDuration:.5 delay:0 usingSpringWithDamping:0.9 initialSpringVelocity:5 options:0 animations:^{
                btn.alpha = 0;
                btn.frame = CGRectMake(x, self.originFrame.origin.y, width, height);
            } completion:^(BOOL finished) {
                if ([btn isEqual:[self.visableBtnArray firstObject]]) {
                    self.superview.superview.userInteractionEnabled = YES;
                }
            }];
        });

    }];

}
- (void)moveInAnimation{

    [self.visableBtnArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        UIButton * btn = obj;
        CGFloat x = btn.frame.origin.x;
        CGFloat y = btn.frame.origin.y;
        CGFloat width = btn.frame.size.width;
        CGFloat height = btn.frame.size.height;
        btn.frame = CGRectMake(x,  self.originFrame.origin.y, width, height);
        btn.alpha = 0.0;
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(idx * 0.03 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [UIView animateWithDuration:0.75 delay:0 usingSpringWithDamping:0.5 initialSpringVelocity:1 options:UIViewAnimationOptionCurveEaseIn animations:^{
                btn.alpha = 1;
                btn.frame = CGRectMake(x, y, width, height);
            } completion:^(BOOL finished) {
                if ([btn isEqual:[self.visableBtnArray lastObject]]) {
                    self.superview.superview.userInteractionEnabled = YES;
                }
            }];

        });

    }];
}

-(NSMutableArray *)visableBtnArray
{
    if (!_visableBtnArray) {
        _visableBtnArray = [NSMutableArray array];
    }
    return _visableBtnArray;
}
@end
