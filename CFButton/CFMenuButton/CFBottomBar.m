//
//  CFBottomBar.m
//  CFButton
//
//  Created by YF on 2017/8/1.
//  Copyright © 2017年 CooFree. All rights reserved.
//

#import "CFBottomBar.h"
#import "UIView+CFAnimation.h"

@interface CFBottomBar ()

@property (nonatomic,weak) UIImageView * background;
@property (nonatomic,weak) UIButton * closeBtn;
@property (nonatomic,weak) UIButton * backBtn;
@property (nonatomic,weak) UIButton * secondCloseBtn;

@end

@implementation CFBottomBar

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UIImageView * back = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
//        [back bhb_setImageWithResourcePath:@"images.bundle/tabbar_compose_below_background" AutoSize:NO];
        [back setImage:[UIImage imageNamed:@"images.bundle/tabbar_compose_below_background"]];
        //        back.backgroundColor=[UIColor whiteColor];
        [self addSubview:back];
        self.background = back;

        UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(0, 0, BHBBOTTOMHEIGHT / 2, BHBBOTTOMHEIGHT / 2);
        btn.center = CGPointMake(frame.size.width / 2, frame.size.height / 2);
//        [btn bhb_setImage:@"images.bundle/tabbar_compose_background_icon_add"];
        [btn setImage:[UIImage imageNamed:@"images.bundle/tabbar_compose_background_icon_add"] forState:UIControlStateNormal];
        btn.userInteractionEnabled = NO;
        [self addSubview:btn];
        [btn RevolvingWithTime:.25 andDelta:(M_PI_4)];
        self.closeBtn = btn;

        UIButton * backbtn = [UIButton buttonWithType:UIButtonTypeCustom];
        backbtn.frame = CGRectMake(0, 0, frame.size.width / 2, frame.size.height);
//        [backbtn bhb_setImage:@"images.bundle/tabbar_compose_background_icon_return"];
        [backbtn setImage:[UIImage imageNamed:@"images.bundle/tabbar_compose_background_icon_return"] forState:UIControlStateNormal];

        //  [backbtn bhb_setBGImage:@"images.bundle/tabbar_compose_left_button"];
        [self addSubview:backbtn];
        [backbtn addTarget:self action:@selector(back:) forControlEvents:UIControlEventTouchUpInside];
        backbtn.alpha = 0;
        backbtn.userInteractionEnabled = NO;
        self.backBtn = backbtn;

        UIButton * secCloseBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        secCloseBtn.frame = CGRectMake(frame.size.width / 2, 0, frame.size.width / 2, frame.size.height);
//        [secCloseBtn bhb_setImage:@"images.bundle/tabbar_compose_background_icon_close"];
        [secCloseBtn setImage:[UIImage imageNamed:@"images.bundle/tabbar_compose_background_icon_close"] forState:UIControlStateNormal];

        // [secCloseBtn bhb_setBGImage:@"images.bundle/tabbar_compose_right_button"];
        [self addSubview:secCloseBtn];
        [secCloseBtn addTarget:self action:@selector(close) forControlEvents:UIControlEventTouchUpInside];
        secCloseBtn.alpha = 0;
        secCloseBtn.userInteractionEnabled = NO;
        self.secondCloseBtn = secCloseBtn;

    }
    return self;
}

- (void)close
{
    [self fadeOutWithTime:.25];
    [self btnResetPosition];
    if (self.closeClick) {
        self.closeClick();
    }
}

- (void)back:(UIButton *)btn{
    self.isMoreBar = NO;
    if (self.backClick) {
        self.backClick();
    }
}

- (void)setIsMoreBar:(BOOL)isMoreBar
{
    _isMoreBar = isMoreBar;
    if (isMoreBar) {
        [UIView animateWithDuration:.25 animations:^{
            self.closeBtn.alpha = 0;
            self.backBtn.alpha = 1;
            self.secondCloseBtn.alpha = 1;
            self.backBtn.userInteractionEnabled = YES;
            self.secondCloseBtn.userInteractionEnabled = YES;
        }];
    }else{
        [UIView animateWithDuration:.25 animations:^{
            self.closeBtn.alpha = 1;
            self.backBtn.alpha = 0;
            self.secondCloseBtn.alpha = 0;
            self.backBtn.userInteractionEnabled = NO;
            self.secondCloseBtn.userInteractionEnabled = NO;
        }];
    }
}

//恢复按钮位置
- (void)btnResetPosition{
    if (self.closeBtn) {
        [self.closeBtn RevolvingWithTime:.25 andDelta:0];
    }
}

@end
