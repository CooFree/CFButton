//
//  CFItemButton.h
//  CFButton
//
//  Created by YF on 2017/7/28.
//  Copyright © 2017年 CooFree. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CFItem : NSObject

@property (nonatomic,copy) NSString * title;
@property (nonatomic,copy) NSString * icon;

-(instancetype)initWithTitle:(NSString *)title Icon:(NSString *)icon;

@end
