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
#import "YouKuPlayButton.h"
#import "iQiYiPlayButton.h"
#import "MMPulseView.h"

#define SCREEN_WIDTH ([[UIScreen mainScreen] bounds].size.width)
#define SCREEN_HEIGHT ([[UIScreen mainScreen] bounds].size.height)

@interface ViewController ()<DCPathButtonDelegate>
{
    JKCountDownButton *_countDownCode;
    iQiYiPlayButton *_iQiYiPlayButton;
    YouKuPlayButton *_youKuPlayButton;
}
@property (nonatomic , strong) DCPathButton *pathAnimationView;

@property (nonatomic, strong) NSMutableArray *pulseArray;

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

    UIButton *btn2 = [UIButton buttonWithImagename:@"miyou_icon_+_fabu" hightImagename:nil bgImagename:nil target:self action:@selector(btn2Click:)];
    btn2.frame = CGRectMake(self.view.frame.size.width/2-60, SCREEN_HEIGHT/2+150, 120, 120);
    [self.view addSubview:btn2];

    [self buildCountDown];

    [self clickGoodAnimation];

    [self ConfigureDCPathButton];


}
- (void)btn2Click:(UIButton *)sender {

    [CFMenuPopView showToView:self.view.window mainButtonFrame:sender.frame withType:MenuPopTypeButton andSelectBlock:^(CFItem *item) {

    }];

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

- (void)addIQiYiPlayButton {
    //创建播放按钮，需要初始化一个状态，即显示暂停还是播放状态
    _iQiYiPlayButton = [[iQiYiPlayButton alloc] initWithFrame:CGRectMake(0, 0, 60, 60) state:iQiYiPlayButtonStatePlay];
    _iQiYiPlayButton.center = CGPointMake(self.view.center.x, self.view.bounds.size.height/3);
    [_iQiYiPlayButton addTarget:self action:@selector(iQiYiPlayMethod) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_iQiYiPlayButton];

    //创建播放按钮，需要初始化一个状态，即显示暂停还是播放状态
    _youKuPlayButton = [[YouKuPlayButton alloc] initWithFrame:CGRectMake(0, 0, 60, 60) state:YouKuPlayButtonStatePlay];
    _youKuPlayButton.center = CGPointMake(self.view.center.x, self.view.bounds.size.height*2/3);
    [_youKuPlayButton addTarget:self action:@selector(youKuPlayMethod) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_youKuPlayButton];
}
- (void)iQiYiPlayMethod {
    //通过判断当前状态 切换显示状态
    if (_iQiYiPlayButton.buttonState == iQiYiPlayButtonStatePause) {
        _iQiYiPlayButton.buttonState = iQiYiPlayButtonStatePlay;
    }else {
        _iQiYiPlayButton.buttonState = iQiYiPlayButtonStatePause;
    }
}

- (void)youKuPlayMethod {
    //通过判断当前状态 切换显示状态
    if (_youKuPlayButton.buttonState == YouKuPlayButtonStatePause) {
        _youKuPlayButton.buttonState = YouKuPlayButtonStatePlay;
    }else {
        _youKuPlayButton.buttonState = YouKuPlayButtonStatePause;
    }
}



- (void)addPlusView {
    NSInteger maxI = 2;
    NSInteger maxJ = 2;

    NSMutableArray *pulseArray = @[].mutableCopy;

    for ( int i = 0 ; i < maxI*maxJ ; ++i )
    {
        [pulseArray addObject:[MMPulseView new]];
    }
    self.pulseArray = pulseArray;

    CGRect screenRect = [UIScreen mainScreen].bounds;

    for ( int i = 0 ; i < maxI ; ++i )
    {
        for ( int j = 0 ; j < maxJ ; ++j )
        {
            NSInteger index = i*maxJ+j;
            MMPulseView *pulseView = pulseArray[index];

            pulseView.frame = CGRectMake(CGRectGetWidth(screenRect)/maxJ*j,
                                         CGRectGetHeight(screenRect)/maxI*i,
                                         CGRectGetWidth(screenRect)/maxJ,
                                         CGRectGetHeight(screenRect)/maxI);

            [self.view addSubview:pulseView];


            switch (index) {
                case 0:
                {
                    pulseView.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
                    pulseView.colors = @[(__bridge id)[UIColor blueColor].CGColor,(__bridge id)[UIColor blueColor].CGColor];

                    pulseView.minRadius = 0;
                    pulseView.maxRadius = 80;

                    pulseView.duration = 5;
                    pulseView.count = 20;
                    pulseView.lineWidth = 1.0f;

                    break;
                }
                case 1:
                {
                    pulseView.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
                    pulseView.colors = @[(__bridge id)[UIColor colorWithRed:0.996 green:0.647 blue:0.008 alpha:1].CGColor,(__bridge id)[UIColor colorWithRed:1 green:0.31 blue:0.349 alpha:1].CGColor];

                    CGFloat posY = (CGRectGetHeight(screenRect)-320)/2/CGRectGetHeight(screenRect);
                    pulseView.startPoint = CGPointMake(0.5, posY);
                    pulseView.endPoint = CGPointMake(0.5, 1.0f - posY);

                    pulseView.minRadius = 40;
                    pulseView.maxRadius = 100;

                    pulseView.duration = 2;
                    pulseView.count = 4;
                    pulseView.lineWidth = 2.0f;

                    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
                    [self.view addSubview:btn];
                    [btn setBackgroundImage:[UIImage imageNamed:@"button"] forState:UIControlStateNormal];
                    [btn setTitle:@"Tap" forState:UIControlStateNormal];
                    btn.frame = CGRectMake(0, 0, 100, 100);
                    btn.center = pulseView.center;
                    [btn addTarget:self action:@selector(actionPulse) forControlEvents:UIControlEventTouchUpInside];

                    break;
                }
                case 2:
                {
                    pulseView.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
                    pulseView.colors = @[(__bridge id)[UIColor redColor].CGColor, (__bridge id)[UIColor blueColor].CGColor];
                    pulseView.startPoint = CGPointMake(0, 0.5);
                    pulseView.endPoint = CGPointMake(1, 0.5);

                    pulseView.minRadius = 0;
                    pulseView.maxRadius = 60;

                    pulseView.duration = 5;
                    pulseView.count = 1;
                    pulseView.lineWidth = 5.0f;

                    break;
                }
                case 3:
                {
                    pulseView.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
                    pulseView.colors = @[(__bridge id)[UIColor whiteColor].CGColor,
                                         (__bridge id)[UIColor blackColor].CGColor,
                                         (__bridge id)[UIColor whiteColor].CGColor];
                    pulseView.locations = @[@(0.3),@(0.5),@(0.7)];
                    pulseView.startPoint = CGPointMake(0, 0.5);
                    pulseView.endPoint = CGPointMake(1, 0.5);

                    pulseView.minRadius = 0;
                    pulseView.maxRadius = 100;

                    pulseView.duration = 3;
                    pulseView.count = 6;
                    pulseView.lineWidth = 3.0f;

                    break;
                }

                default:
                    break;
            }

            if ( index != 1 )
            {
                [pulseView startAnimation];
            }
        }
    }
}
- (void)actionPulse
{
    MMPulseView *pulseView = self.pulseArray[1];

    pulseView.tag = 1 - pulseView.tag;

    (pulseView.tag>0)?[pulseView startAnimation]:[pulseView stopAnimation];
}

@end
