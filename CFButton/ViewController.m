//
//  ViewController.m
//  CFButton
//
//  Created by YF on 2017/7/14.
//  Copyright © 2017年 CooFree. All rights reserved.
//

#import "ViewController.h"
#import "JKCountDownButton.h"
#import "BAButton.h"

#import "DCPathButton.h"
#import "DWBubbleMenuButton.h"
#import "MCFireworksButton.h"

#define SCREEN_WIDTH ([[UIScreen mainScreen] bounds].size.width)
#define SCREEN_HEIGHT ([[UIScreen mainScreen] bounds].size.height)

@interface ViewController ()
{
    JKCountDownButton *_countDownCode;
}
@property (nonatomic , strong) DCPathButton *pathAnimationView;

@property (nonatomic , strong) DWBubbleMenuButton *dingdingAnimationMenu;

@property (nonatomic , strong) MCFireworksButton *goodBtn;
@property (nonatomic , assign) BOOL selected;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self buildCountDown];
//    [self buttonTest];

}

- (void)buildCountDown{
    UILabel *lable = [[UILabel alloc]initWithFrame:CGRectMake(10, 200, 70, 32)];
    lable.text = @"代码添加";
    lable.textColor = [UIColor whiteColor];
    [self.view addSubview:lable];


    _countDownCode = [JKCountDownButton buttonWithType:UIButtonTypeCustom];
    _countDownCode.frame = CGRectMake(81, 200, 108, 32);
    [_countDownCode setTitle:@"开始" forState:UIControlStateNormal];
    _countDownCode.backgroundColor = [UIColor blueColor];
    [self.view addSubview:_countDownCode];


    [_countDownCode countDownButtonHandler:^(JKCountDownButton*sender, NSInteger tag) {
        sender.enabled = NO;

        [sender startCountDownWithSecond:10];

        [sender countDownChanging:^NSString *(JKCountDownButton *countDownButton,NSUInteger second) {
            NSString *title = [NSString stringWithFormat:@"剩余%zd秒",second];
            return title;
        }];
        [sender countDownFinished:^NSString *(JKCountDownButton *countDownButton, NSUInteger second) {
            countDownButton.enabled = YES;
            return @"点击重新获取";

        }];

    }];
}
- (void)buttonTest
{
    BACustomButton *btn = [BACustomButton BA_ShareButton];
    btn.backgroundColor = [UIColor greenColor];;
    [btn setImage:[UIImage imageNamed:@"1"] forState:UIControlStateNormal];
    btn.imageView.contentMode = UIViewContentModeScaleAspectFit;
    [btn setTitle:@"系统默认样式" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    btn.buttonStatus = BAAligenmentStatusNormal;
    btn.buttonCornerRadius = 5.0;
    btn.frame = CGRectMake(50, 50, 200, 50);
    [self.view addSubview:btn];

    //    BAButton *btn = [[BAButton alloc] initWithFrame:CGRectMake(100, 100, 200, 30) image:[UIImage imageNamed:@"btn_share"] highlightedImage:[UIImage imageNamed:@"btn_share"] fadeDuration:3];
    //    btn.backgroundColor = [UIColor greenColor];
    //    //    [btn setImage:[UIImage imageNamed:@"tabbar_discover"] forState:UIControlStateNormal];
    //    [btn setTitle:@"默认" forState:UIControlStateNormal];
    //    //    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    //    //    btn.buttonStatus = BAAligenmentStatusNormal;
    //    //    btn.buttonCornerRadius = 5.0;
    //    //    btn.frame = CGRectMake(100, 100, 200, 30);
    //    [self.view addSubview:btn];

    BACustomButton *btn1 = [BACustomButton BA_ShareButton];
    [btn1 setBackgroundColor:[UIColor greenColor]];
    [btn1 setImage:[UIImage imageNamed:@"1"] forState:UIControlStateNormal];
    [btn1 setTitle:@"左对齐[文字左图片右]" forState:UIControlStateNormal];
    [btn1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    btn1.imageView.contentMode = UIViewContentModeScaleAspectFit;
    btn1.buttonStatus = BAAligenmentStatusLeft;
    btn1.buttonCornerRadius = 5.0;
    btn1.titleLabel.font = [UIFont systemFontOfSize:15];
    btn1.frame = CGRectMake(CGRectGetMinX(btn.frame), CGRectGetMaxY(btn.frame) + 10, 200, 50);
    [self.view addSubview:btn1];

    BACustomButton *btn2 = [BACustomButton BA_ShareButton];
    [btn2 setBackgroundColor:[UIColor greenColor]];
    [btn2 setImage:[UIImage imageNamed:@"1"] forState:UIControlStateNormal];
    [btn2 setTitle:@"中心对齐[文字左图片右]" forState:UIControlStateNormal];
    btn2.imageView.contentMode = UIViewContentModeScaleAspectFit;
    [btn2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    btn2.buttonStatus = BAAligenmentStatusCenter;
    btn2.buttonCornerRadius = 5.0;
    btn2.titleLabel.font = [UIFont systemFontOfSize:14];
    btn2.frame = CGRectMake(CGRectGetMinX(btn.frame), CGRectGetMaxY(btn1.frame) + 10, 300, 50);
    [self.view addSubview:btn2];

    BACustomButton *btn3 = [BACustomButton BA_ShareButton];
    [btn3 setBackgroundColor:[UIColor greenColor]];
    [btn3 setImage:[UIImage imageNamed:@"1"] forState:UIControlStateNormal];
    [btn3 setTitle:@"右对齐[文字左图片右]" forState:UIControlStateNormal];
    btn3.titleLabel.font = [UIFont systemFontOfSize:10];
    [btn3 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    btn3.buttonStatus = BAAligenmentStatusRight;
    btn3.buttonCornerRadius = 5.0;
    btn3.frame = CGRectMake(CGRectGetMinX(btn.frame), CGRectGetMaxY(btn2.frame) + 10, 200, 50);
    [self.view addSubview:btn3];

    BACustomButton *btn4 = [[BACustomButton alloc] initWitAligenmentStatus:BAAligenmentStatusLeft];
    [btn4 setBackgroundColor:[UIColor greenColor]];
    [btn4 setImage:[UIImage imageNamed:@"1"] forState:UIControlStateNormal];
    [btn4 setTitle:@"左对齐[文字左图片右]" forState:UIControlStateNormal];
    btn4.titleLabel.font = [UIFont systemFontOfSize:10];
    btn4.buttonCornerRadius = 5.0;
    [btn4 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    btn4.frame = CGRectMake(CGRectGetMinX(btn.frame), CGRectGetMaxY(btn3.frame) + 10, 200, 50);
    [self.view addSubview:btn4];

    BACustomButton *btn5 = [[BACustomButton alloc] initWitAligenmentStatus:BAAligenmentStatusTop];
    [btn5 setBackgroundColor:[UIColor greenColor]];
    [btn5 setImage:[UIImage imageNamed:@"1"] forState:UIControlStateNormal];
    [btn5 setTitle:@"图片在上，文字在下" forState:UIControlStateNormal];
    btn5.titleLabel.font = [UIFont systemFontOfSize:10];
    btn5.buttonCornerRadius = 5.0;
    [btn5 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    btn5.frame = CGRectMake(CGRectGetMinX(btn.frame), CGRectGetMaxY(btn4.frame) + 10, 200, 80);
    [self.view addSubview:btn5];

    BACustomButton *btn6 = [[BACustomButton alloc] initWitAligenmentStatus:BAAligenmentStatusBottom];
    [btn6 setBackgroundColor:[UIColor greenColor]];
    [btn6 setImage:[UIImage imageNamed:@"1"] forState:UIControlStateNormal];
    [btn6 setTitle:@"图片在下，文字在上" forState:UIControlStateNormal];
    btn6.titleLabel.font = [UIFont systemFontOfSize:10];
    btn6.buttonCornerRadius = 5.0;
    [btn6 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    btn6.frame = CGRectMake(CGRectGetMinX(btn.frame), CGRectGetMaxY(btn5.frame) + 10, 150, 80);
    [self.view addSubview:btn6];

    BACustomButton *btn7 = [[BACustomButton alloc] init];
    btn7.buttonStatus = BAAligenmentStatusBottom;
    [btn7 setBackgroundColor:[UIColor greenColor]];
    [btn7 setImage:[UIImage imageNamed:@"1"] forState:UIControlStateNormal];
    [btn7 setTitle:@"图片在下，文字在上" forState:UIControlStateNormal];
    btn7.titleLabel.font = [UIFont systemFontOfSize:13];
    btn7.buttonCornerRadius = 5.0;
    [btn7 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    btn7.frame = CGRectMake(CGRectGetMinX(btn.frame), CGRectGetMaxY(btn6.frame) + 10, 150, 80);
    [self.view addSubview:btn7];
}


- (void)ConfigureDCPathButton
{
    // Configure center button
    //
    DCPathButton *dcPathButton = [[DCPathButton alloc]initWithCenterImage:[UIImage imageNamed:@"chooser-button-tab"]
                                                           hilightedImage:[UIImage imageNamed:@"chooser-button-tab-highlighted"]];
    _pathAnimationView = dcPathButton;

    dcPathButton.delegate = self;

    // Configure item buttons
    //
    DCPathItemButton *itemButton_1 = [[DCPathItemButton alloc]initWithImage:[UIImage imageNamed:@"chooser-moment-icon-music"]
                                                           highlightedImage:[UIImage imageNamed:@"chooser-moment-icon-music-highlighted"]
                                                            backgroundImage:[UIImage imageNamed:@"chooser-moment-button"]
                                                 backgroundHighlightedImage:[UIImage imageNamed:@"chooser-moment-button-highlighted"]];

    DCPathItemButton *itemButton_2 = [[DCPathItemButton alloc]initWithImage:[UIImage imageNamed:@"chooser-moment-icon-place"]
                                                           highlightedImage:[UIImage imageNamed:@"chooser-moment-icon-place-highlighted"]
                                                            backgroundImage:[UIImage imageNamed:@"chooser-moment-button"]
                                                 backgroundHighlightedImage:[UIImage imageNamed:@"chooser-moment-button-highlighted"]];

    DCPathItemButton *itemButton_3 = [[DCPathItemButton alloc]initWithImage:[UIImage imageNamed:@"chooser-moment-icon-camera"]
                                                           highlightedImage:[UIImage imageNamed:@"chooser-moment-icon-camera-highlighted"]
                                                            backgroundImage:[UIImage imageNamed:@"chooser-moment-button"]
                                                 backgroundHighlightedImage:[UIImage imageNamed:@"chooser-moment-button-highlighted"]];

    DCPathItemButton *itemButton_4 = [[DCPathItemButton alloc]initWithImage:[UIImage imageNamed:@"chooser-moment-icon-thought"]
                                                           highlightedImage:[UIImage imageNamed:@"chooser-moment-icon-thought-highlighted"]
                                                            backgroundImage:[UIImage imageNamed:@"chooser-moment-button"]
                                                 backgroundHighlightedImage:[UIImage imageNamed:@"chooser-moment-button-highlighted"]];

    DCPathItemButton *itemButton_5 = [[DCPathItemButton alloc]initWithImage:[UIImage imageNamed:@"chooser-moment-icon-sleep"]
                                                           highlightedImage:[UIImage imageNamed:@"chooser-moment-icon-sleep-highlighted"]
                                                            backgroundImage:[UIImage imageNamed:@"chooser-moment-button"]
                                                 backgroundHighlightedImage:[UIImage imageNamed:@"chooser-moment-button-highlighted"]];

    // Add the item button into the center button
    //
    [dcPathButton addPathItems:@[itemButton_1, itemButton_2, itemButton_3, itemButton_4, itemButton_5]];

    [self.view addSubview:dcPathButton];

}

#pragma mark - DCPathButton Delegate

- (void)itemButtonTappedAtIndex:(NSUInteger)index
{
    NSLog(@"You tap at index : %ld", index);
}

//--------------------------------------------萌萌的分割线---------------------------------------------------
/**
 *  仿造钉钉菜单动画
 */
-(void)dingdingAnimation{
    if (_pathAnimationView) {
        _pathAnimationView.hidden = YES;
    }
    if (_goodBtn) {
        _goodBtn.hidden = YES;
    }
    if (!_dingdingAnimationMenu) {
        UILabel *homeLabel = [self createHomeButtonView];

        DWBubbleMenuButton *upMenuView = [[DWBubbleMenuButton alloc] initWithFrame:CGRectMake(self.view.frame.size.width - homeLabel.frame.size.width - 20.f,
                                                                                              self.view.frame.size.height - homeLabel.frame.size.height - 20.f,
                                                                                              homeLabel.frame.size.width,
                                                                                              homeLabel.frame.size.height)
                                                                expansionDirection:DirectionUp];
        upMenuView.homeButtonView = homeLabel;
        [upMenuView addButtons:[self createDemoButtonArray]];

        _dingdingAnimationMenu = upMenuView;

        [self.view addSubview:upMenuView];
    }else{
        _dingdingAnimationMenu.hidden = NO;
    }
}

- (UILabel *)createHomeButtonView {
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0.f, 0.f, 40.f, 40.f)];

    label.text = @"Tap";
    label.textColor = [UIColor whiteColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.layer.cornerRadius = label.frame.size.height / 2.f;
    label.backgroundColor =[UIColor colorWithRed:0.f green:0.f blue:0.f alpha:0.5f];
    label.clipsToBounds = YES;

    return label;
}

- (NSArray *)createDemoButtonArray {
    NSMutableArray *buttonsMutable = [[NSMutableArray alloc] init];

    int i = 0;
    for (NSString *title in @[@"A", @"B", @"C", @"D", @"E", @"F"]) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];

        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [button setTitle:title forState:UIControlStateNormal];

        button.frame = CGRectMake(0.f, 0.f, 30.f, 30.f);
        button.layer.cornerRadius = button.frame.size.height / 2.f;
        button.backgroundColor = [UIColor colorWithRed:0.f green:0.f blue:0.f alpha:0.5f];
        button.clipsToBounds = YES;
        button.tag = i++;

        [button addTarget:self action:@selector(dwBtnClick:) forControlEvents:UIControlEventTouchUpInside];

        [buttonsMutable addObject:button];
    }

    return [buttonsMutable copy];
}

- (void)dwBtnClick:(UIButton *)sender {
    NSLog(@"DWButton tapped, tag: %ld", (long)sender.tag);
}


//--------------------------------------------萌萌的分割线---------------------------------------------------

/**
 *  仿造facebook，点赞动画
 */
-(void)clickGoodAnimation{
    if (_pathAnimationView) {
        _pathAnimationView.hidden = YES;
    }
    if (_dingdingAnimationMenu) {
        _dingdingAnimationMenu.hidden = YES;
    }
    if (!_goodBtn) {
        _goodBtn = [[MCFireworksButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2-25, SCREEN_HEIGHT/2-25, 50, 50)];
        _goodBtn.particleImage = [UIImage imageNamed:@"Sparkle"];
        _goodBtn.particleScale = 0.05;
        _goodBtn.particleScaleRange = 0.02;
        [_goodBtn setImage:[UIImage imageNamed:@"Like"] forState:UIControlStateNormal];

        [_goodBtn addTarget:self action:@selector(handleButtonPress:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:_goodBtn];
    }else{
        _goodBtn.hidden = NO;
    }
}

- (void)handleButtonPress:(id)sender {
    _selected = !_selected;
    if(_selected) {
        [_goodBtn popOutsideWithDuration:0.5];
        [_goodBtn setImage:[UIImage imageNamed:@"Like-Blue"] forState:UIControlStateNormal];
        [_goodBtn animate];
    }else {
        [_goodBtn popInsideWithDuration:0.4];
        [_goodBtn setImage:[UIImage imageNamed:@"Like"] forState:UIControlStateNormal];
    }
}

@end
