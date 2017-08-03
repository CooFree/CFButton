//
//  CFMenuPopView.m
//  CFButton
//
//  Created by YF on 2017/7/28.
//  Copyright © 2017年 CooFree. All rights reserved.
//

#import "CFMenuPopView.h"

#import "UIImage+CFImage.h"
#import "UIView+CFAnimation.h"

#import "CFCenterView.h"
#import "CFBottomBar.h"
#import "CFTopButtonView.h"

@interface CFMenuPopView()<CFTopButtonViewDelegate,CFCenterViewDelegate,CFCenterViewDataSource>

@property (nonatomic,weak) UIImageView * background;
@property (nonatomic, strong) CFCenterView *centerView;
@property (nonatomic, strong) CFBottomBar *bottomBar;
@property (nonatomic, strong) CFTopButtonView *topButtonView;

@property (nonatomic,strong) NSArray * items;
@property (nonatomic,copy) DidSelectItemBlock selectBlock;

@end

@implementation CFMenuPopView

- (instancetype)initWithType:(MenuPopType)popType frame:(CGRect)frame mainButtonFrame:(CGRect)mainBtnFrame {
    if (self = [super initWithFrame:frame]) {
        self.popType = popType;

        UIImageView * iv = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        [self addSubview:iv];
        self.background = iv;

        switch (self.popType) {
            case MenuPopTypeButton:
                [self creatButtonTypeView:mainBtnFrame];
                break;
            case MenuPopTypeScreen:
                [self creatScreenTypeView];
                break;
            default:
                [self creatScreenTypeView];
                break;
        }
    }
    return self;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {

        UIImageView * iv = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        [self addSubview:iv];
        self.background = iv;

        [self creatScreenTypeView];

//        UIBlurEffect* effectBlur=  [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
//        UIView*effectView = [[UIVisualEffectView alloc] initWithEffect:effectBlur];
//        effectView.frame = self.bounds;
//        effectView.backgroundColor = [[UIColor lightGrayColor]colorWithAlphaComponent:0.7];
        //        [self addSubview:effectView];


    }
    return self;
}
- (void)creatButtonTypeView:(CGRect)mainBtnFrame {
    CFTopButtonView *topButtonView = [[CFTopButtonView alloc]initWithFrame:CGRectMake(mainBtnFrame.origin.x, mainBtnFrame.origin.y-mainBtnFrame.size.height*2, mainBtnFrame.size.width, mainBtnFrame.size.height*3)];
    topButtonView.delegate = self;
    [self addSubview:topButtonView];
    self.topButtonView = topButtonView;
}
- (void)creatScreenTypeView {
    /*
     UIImageView * logo = [[UIImageView alloc]init];
     [logo bhb_setImageWithResourcePath:@"images.bundle/compose_slogan" AutoSize:YES];
     logo.center = CGPointMake(frame.size.width / 2, frame.size.height * 0.2);
     [self addSubview:logo];
     self.logo = logo;
     */
    CFBottomBar * bar = [[CFBottomBar alloc]initWithFrame:CGRectMake(0, self.frame.size.height - BHBBOTTOMHEIGHT, self.frame.size.width, BHBBOTTOMHEIGHT)];
    __weak typeof(self) weakSelf = self;
    bar.backClick = ^{
        [weakSelf.centerView scrollBack];
    };
    bar.closeClick = ^{
        //            [[BHBPlaySoundTool sharedPlaySoundTool] playWithSoundName:@"close"];
        [weakSelf hideItems];
        [weakSelf hide];
    };
    [self addSubview:bar];
    self.bottomBar = bar;


    CFCenterView * centerView = [[CFCenterView alloc]initWithFrame:CGRectMake(0, self.frame.size.height * 0.37, self.frame.size.width, self.frame.size.height * 0.4)];
    [self addSubview:centerView];
    centerView.delegate = self;
    centerView.dataSource = self;
    centerView.clipsToBounds = NO;
    self.centerView = centerView;


}
- (void)showItems {
    if (self.popType == MenuPopTypeButton) {
        [self.topButtonView reloadData];
    }else
        [self.centerView reloadData];
}
- (void)hideItems {
    [self.topButtonView dismis];
    [self.centerView dismis];
}


+ (instancetype)showToView:(UIView *)view mainButtonFrame:(CGRect)mainBtnFrame withType:(MenuPopType)type andSelectBlock:(DidSelectItemBlock)block {
    CFMenuPopView * popView = [[CFMenuPopView alloc]initWithType:type frame:view.bounds mainButtonFrame:(CGRect)mainBtnFrame];
    popView.background.image = [self imageWithView:view];
    [view addSubview:popView];
    popView.selectBlock = block;
    [popView fadeInWithTime:0.25];
    [popView showItems];
    return popView;
}
+ (instancetype)showToView:(UIView *)view withItems:(NSArray *)array andSelectBlock:(DidSelectItemBlock)block {
    CFMenuPopView * popView = [[CFMenuPopView alloc]initWithFrame:view.bounds];
    popView.background.image = [self imageWithView:view];
    [view addSubview:popView];
    popView.selectBlock = block;
    [popView fadeInWithTime:0.25];
    popView.items = array;
    [popView showItems];
    return popView;
}


- (void)hide{
    [CFMenuPopView hideWithView:self];
}

+ (void)hideWithView:(UIView *)view{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.35 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [view fadeOutWithTime:0.35];
    });
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.bottomBar btnResetPosition];
    [self.bottomBar fadeOutWithTime:.25];
    [self hideItems];
    [self hide];
}

#pragma mark centerview delegate and datasource
- (NSInteger)numberOfItemsWithCenterView:(CFCenterView *)centerView
{
    return self.items.count;
}

-(CFItem *)itemWithCenterView:(CFCenterView *)centerView item:(NSInteger)item
{
    return self.items[item];
}

-(void)didSelectItemWithCenterView:(CFCenterView *)centerView andItem:(CFItem *)item
{
    if (self.selectBlock) {
        self.selectBlock(item);
    }
//    [[BHBPlaySoundTool sharedPlaySoundTool] playWithSoundName:@"open"];
    [self hide];
}

- (void)didSelectMoreWithCenterView:(CFCenterView *)centerView andItem:(CFItemGroup *)group
{
    if (self.selectBlock) {
        self.selectBlock(group);
    }
//    [[BHBPlaySoundTool sharedPlaySoundTool] playWithSoundName:@"open"];
    self.bottomBar.isMoreBar = YES;
}

#pragma mark topButtonView delegate
- (void)didSelectTopButtonViewMainButton {
    [self hide];
}
- (void)didSelectTopButtonViewItemButton {
    [self hide];
}
+ (UIImage *)imageWithView:(UIView *)view{
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(view.frame.size.width, view.frame.size.height), NO, [[UIScreen mainScreen] scale]);
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage * image = UIGraphicsGetImageFromCurrentImageContext();
    UIColor *tintColor = [UIColor colorWithWhite:0.95 alpha:0.78];
    image = [image applyBlurWithRadius:15 tintColor:tintColor saturationDeltaFactor:1 maskImage:nil];
    UIGraphicsEndImageContext();

    return image;
}

@end
