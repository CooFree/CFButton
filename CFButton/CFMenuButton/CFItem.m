//
//  CFItemButton.m
//  CFButton
//
//  Created by YF on 2017/7/28.
//  Copyright © 2017年 CooFree. All rights reserved.
//

#import "CFItem.h"

@implementation CFItem

-(instancetype)initWithTitle:(NSString *)title Icon:(NSString *)icon{
    self = [super init];
    if (self) {
        self.title = title;
        self.icon = icon;
    }
    return self;
}

@end
