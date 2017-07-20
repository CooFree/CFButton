//
//  ViewController.m
//  CFButton
//
//  Created by YF on 2017/7/14.
//  Copyright © 2017年 CooFree. All rights reserved.
//

#import "ViewController.h"
#import "JKCountDownButton.h"

@interface ViewController ()
{
    JKCountDownButton *_countDownCode;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self buildCountDown];

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
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
