//
//  ViewController.m
//  CFButton
//
//  Created by YF on 2017/7/14.
//  Copyright © 2017年 CooFree. All rights reserved.
//


#import "ViewController.h"

#import "UIButton+Addition.h"

#import "JKCountDownButton.h"
#import "BAButton.h"

#import "DCPathButton.h"
#import "MCFireworksButton.h"
#import "CFMenuPopView.h"

#define SCREEN_WIDTH ([[UIScreen mainScreen] bounds].size.width)
#define SCREEN_HEIGHT ([[UIScreen mainScreen] bounds].size.height)

@interface ViewController ()<DCPathButtonDelegate>
{
    JKCountDownButton *_countDownCode;
}
@property (nonatomic , strong) DCPathButton *pathAnimationView;

@property (nonatomic , strong) MCFireworksButton *goodBtn;
@property (nonatomic , assign) BOOL selected;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    UIButton *btn = [UIButton buttonWithTitle:@"MenuPopView" normalColor:[UIColor blackColor] diableColor:[UIColor grayColor] fontSize:17 target:self action:@selector(btnClick)];
    btn.backgroundColor = [UIColor lightGrayColor];
    btn.frame = CGRectMake(self.view.frame.size.width/2-60, 100, 120, 32);
    [self.view addSubview:btn];

    [self buildCountDown];

    [self clickGoodAnimation];

    [self ConfigureDCPathButton];


}
- (void)btnClick {
    CFItem * item0 = [[CFItem alloc]initWithTitle:@"Text" Icon:@"images.bundle/tabbar_compose_idea"];
    CFItem * item1 = [[CFItem alloc]initWithTitle:@"Albums" Icon:@"images.bundle/tabbar_compose_photo"];
    CFItem * item2 = [[CFItem alloc]initWithTitle:@"Camera" Icon:@"images.bundle/tabbar_compose_camera"];
    //第4个按钮内部有一组
    CFItemGroup * item3 = [[CFItemGroup alloc]initWithTitle:@"Check in" Icon:@"images.bundle/tabbar_compose_lbs"];
    CFItem * item31 = [[CFItem alloc]initWithTitle:@"Friend Circle" Icon:@"images.bundle/tabbar_compose_friend"];
    CFItem * item32 = [[CFItem alloc]initWithTitle:@"Weibo Camera" Icon:@"images.bundle/tabbar_compose_wbcamera"];
    CFItem * item33 = [[CFItem alloc]initWithTitle:@"Music" Icon:@"images.bundle/tabbar_compose_music"];
    item3.items = @[item31,item32,item33];

    CFItem * item4 = [[CFItem alloc]initWithTitle:@"Review" Icon:@"images.bundle/tabbar_compose_review"];

    //第六个按钮内部有一组
    CFItemGroup * item5 = [[CFItemGroup alloc]initWithTitle:@"More" Icon:@"images.bundle/tabbar_compose_more"];
    CFItem * item51 = [[CFItem alloc]initWithTitle:@"Friend Circle" Icon:@"images.bundle/tabbar_compose_friend"];
    CFItem * item52 = [[CFItem alloc]initWithTitle:@"Weibo Camera" Icon:@"images.bundle/tabbar_compose_wbcamera"];
    CFItem * item53 = [[CFItem alloc]initWithTitle:@"Music" Icon:@"images.bundle/tabbar_compose_music"];
    CFItem * item54 = [[CFItem alloc]initWithTitle:@"Blog" Icon:@"images.bundle/tabbar_compose_weibo"];
    CFItem * item55 = [[CFItem alloc]initWithTitle:@"Collection" Icon:@"images.bundle/tabbar_compose_transfer"];
    CFItem * item56 = [[CFItem alloc]initWithTitle:@"Voice" Icon:@"images.bundle/tabbar_compose_voice"];
    item5.items = @[item51,item52,item53,item54,item55,item56];
    
    [CFMenuPopView showToView:self.view.window withItems:@[item0,item1,item2,item3,item4,item5] andSelectBlock:^(CFItem *item) {

    }];
}

- (void)buildCountDown{


    _countDownCode = [JKCountDownButton buttonWithType:UIButtonTypeCustom];
    _countDownCode.frame = CGRectMake(self.view.frame.size.width/2-60, 200, 120, 32);
    [_countDownCode setTitle:@"获取验证码" forState:UIControlStateNormal];
    _countDownCode.backgroundColor = [UIColor lightGrayColor];
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

/**
 *  仿Path 菜单动画
 */
- (void)ConfigureDCPathButton
{
    // Configure center button
    //
    DCPathButton *dcPathButton = [[DCPathButton alloc]initWithCenterImage:[UIImage imageNamed:@"chooser-button-tab"]
                                                           hilightedImage:[UIImage imageNamed:@"chooser-button-tab-highlighted"]];
    _pathAnimationView = dcPathButton;
    dcPathButton.pathDirection = PathDirectionUP;
    dcPathButton.patnBtnCenter = CGPointMake(self.view.frame.size.width/2, self.view.frame.size.height/2);
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


/**
 *  仿造facebook，点赞动画
 */
-(void)clickGoodAnimation{

    if (!_goodBtn) {
        _goodBtn = [[MCFireworksButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2-25, SCREEN_HEIGHT/2+50, 50, 50)];
        _goodBtn.particleImage = [UIImage imageNamed:@"Sparkle"];
        _goodBtn.particleScale = 0.05;
        _goodBtn.particleScaleRange = 0.02;
        [_goodBtn setImage:[UIImage imageNamed:@"Like"] forState:UIControlStateNormal];

        [_goodBtn addTarget:self action:@selector(handleButtonPress:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:_goodBtn];
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
