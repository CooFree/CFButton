//
//  CFCenterView.m
//  CFButton
//
//  Created by YF on 2017/7/28.
//  Copyright © 2017年 CooFree. All rights reserved.
//

#import "CFCenterView.h"

#import "UIView+CFAnimation.h"
#import "UIButton+ImageTitleSpacing.h"

#import "CFItemGroup.h"




@interface CFCenterView ()

@property (nonatomic,strong) NSMutableArray * visableBtnArray;
@property (nonatomic,strong) NSMutableArray * homeBtns;
@property (nonatomic,strong) NSMutableArray * moreBtns;
@property (nonatomic,strong) CFItemGroup * currentGroup;
@property (nonatomic,assign) BOOL btnCanceled;

@end

@implementation CFCenterView
@dynamic delegate;


- (void)dismis {
    [self btnPositonAnimation:YES];
}
- (void)scrollBack {
    [self.visableBtnArray removeAllObjects];
    [self.homeBtns enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        [self.visableBtnArray addObject:obj];
    }];
    [self setContentOffset:CGPointMake(0, 0) animated:YES];
}
- (void)didTouchBtn:(UIButton *)btn{
    [btn scalingWithTime:.15 andscal:1.2];
}

- (void)didCancelBtn:(UIButton *)btn{
    self.btnCanceled = YES;
    [btn scalingWithTime:.15 andscal:1];
}
- (void)didClickBtn:(UIButton *)btn{
    if (self.btnCanceled) {
        self.btnCanceled = NO;
        return;
    }

    CFItem * item;
    NSInteger index;
    if([self.homeBtns containsObject:btn]){
        index = [self.homeBtns indexOfObject:btn];
        item = [self.dataSource itemWithCenterView:self item:index];
    }
    if ([self.moreBtns containsObject:btn]) {
        index = [self.moreBtns indexOfObject:btn];
        item = [self.currentGroup.items objectAtIndex:index];
    }
    [btn scalingWithTime:.25 andscal:1];
    if([item isKindOfClass:[CFItemGroup class]]){
        CFItemGroup * group = (CFItemGroup *)item;
        self.currentGroup = group;
        if (!self.delegate || ![self.delegate respondsToSelector:@selector(didSelectMoreWithCenterView:andItem:)]) {
            return;
        }
        [self layoutBtnsWith:group.items isMore:YES];
        [self.visableBtnArray removeAllObjects];
        [self.moreBtns enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            [self.visableBtnArray addObject:obj];
        }];
        [self setContentOffset:CGPointMake(self.frame.size.width, 0) animated:YES];
        [self.delegate didSelectMoreWithCenterView:self andItem:group];
        return;
    }
    else{
        [btn scalingWithTime:.25 andscal:1.7];
        [btn fadeOutWithTime:.25];
        [self.visableBtnArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            UIButton * b = obj;
            if (b != btn) {
                [b scalingWithTime:.25 andscal:0.3];
                [b fadeOutWithTime:.25];
            }
        }];
        if (!self.delegate || ![self.delegate respondsToSelector:@selector(didSelectItemWithCenterView:andItem:)]) {
            return;
        }
        [self.delegate didSelectItemWithCenterView:self andItem:item];
    }
}
- (void)reloadData {
    //    NSAssert(self.delegate, @"CFCenterView`s delegate was nil.");
    NSAssert(self.dataSource, @"CFCenterView`s dataSource was nil.");
    NSAssert([self.dataSource respondsToSelector:@selector(numberOfItemsWithCenterView:)], @"CFCenterView`s was unimplementation numberOfItemsWithCenterView:.");
    NSAssert([self.dataSource respondsToSelector:@selector(itemWithCenterView:item:)], @"CFCenterView`s was unimplementation itemWithCenterView:item:.");
    [self.homeBtns makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [self.moreBtns makeObjectsPerformSelector:@selector(removeFromSuperlayer)];
    [self.homeBtns removeAllObjects];
    [self.moreBtns removeAllObjects];
    NSUInteger count = [self.dataSource numberOfItemsWithCenterView:self];
    NSMutableArray * items = [NSMutableArray array];
    for (int i = 0; i < count; i ++) {
        [items addObject:[self.dataSource itemWithCenterView:self item:i]];
    }
    [self layoutBtnsWith:items isMore:NO];
    [self btnPositonAnimation:NO];
}

- (void)layoutBtnsWith:(NSArray *)items isMore:(BOOL)isMore{
    if(isMore){
        [self.moreBtns makeObjectsPerformSelector:@selector(removeFromSuperview)];
        [self.moreBtns removeAllObjects];
    }
    CFItem * item;
    for (int i = 0; i < items.count; i ++) {
        item = items[i];
        UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
//        [btn bhb_setImage:[NSString stringWithFormat:@"%@",item.icon]];
        UIImage * image = [UIImage imageNamed:[NSString stringWithFormat:@"%@",item.icon]];
        [btn setImage:image forState:UIControlStateNormal];
        [btn.imageView setContentMode:UIViewContentModeCenter];
        [btn setTitle:item.title forState:UIControlStateNormal];
        btn.titleLabel.textAlignment = NSTextAlignmentCenter;
        [btn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:14];

        CGFloat x = (i % 3) * self.frame.size.width / 3.0;
        CGFloat y = (i / 3) * self.frame.size.height / 2.0;
        if (isMore) {
            x += [UIScreen mainScreen].bounds.size.width;
            [self.moreBtns addObject:btn];
        }
        else {
            [self.homeBtns addObject:btn];
        }
        CGFloat width = self.frame.size.width / 3.0;
        CGFloat height = self.frame.size.height / 2;
        [btn addTarget:self action:@selector(didClickBtn:) forControlEvents:UIControlEventTouchUpInside];
        [btn addTarget:self action:@selector(didTouchBtn:) forControlEvents:UIControlEventTouchDown];
        [btn addTarget:self action:@selector(didCancelBtn:) forControlEvents:UIControlEventTouchDragInside];
        [self addSubview:btn];
        btn.frame = CGRectMake(x, y, width, height);
        [btn layoutButtonWithEdgeInsetsStyle:CFButtonEdgeInsetsStyleTop imageTitleSpace:5];

    }
}

- (void)removeAnimation{
    [self.visableBtnArray enumerateObjectsWithOptions:NSEnumerationReverse usingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        UIButton * btn = obj;
        CGFloat x = btn.frame.origin.x;
        CGFloat y = btn.frame.origin.y;
        CGFloat width = btn.frame.size.width;
        CGFloat height = btn.frame.size.height;
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)((self.visableBtnArray.count - idx) * 0.03 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [UIView animateWithDuration:.5 delay:0 usingSpringWithDamping:0.9 initialSpringVelocity:5 options:0 animations:^{
                btn.alpha = 0;
                btn.frame = CGRectMake(x, [UIScreen mainScreen].bounds.size.height - self.frame.origin.y + y, width, height);
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
        btn.frame = CGRectMake(x, [UIScreen mainScreen].bounds.size.height + y - self.frame.origin.y, width, height);
        btn.alpha = 0.0;
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(idx * 0.03 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            //            [UIView animateWithDuration:0.25 delay:0 usingSpringWithDamping:0.75 initialSpringVelocity:0.05 options:UIViewAnimationOptionAllowUserInteraction animations:^{
            [UIView animateWithDuration:0.5 delay:0.03 usingSpringWithDamping:0.7 initialSpringVelocity:0.05 options:UIViewAnimationOptionAllowUserInteraction animations:^{
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

- (void)btnPositonAnimation:(BOOL)isDismis{
    if (self.visableBtnArray.count <= 0) {
        [self.homeBtns enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            [self.visableBtnArray addObject:obj];
        }];
    }
    //    self.superview.superview.userInteractionEnabled = NO;
    self.superview.superview.userInteractionEnabled = YES;

    if (isDismis) {
        [self removeAnimation];
    }else{
        [self moveInAnimation];
    }

}




#pragma mark - 1️⃣➢➢➢ 懒加载

-(NSMutableArray *)homeBtns
{
    if (!_homeBtns) {
        _homeBtns = [NSMutableArray array];
    }
    return _homeBtns;
}

-(NSMutableArray *)visableBtnArray
{
    if (!_visableBtnArray) {
        _visableBtnArray = [NSMutableArray array];
    }
    return _visableBtnArray;
}

- (NSMutableArray *)moreBtns{
    if (!_moreBtns) {
        _moreBtns = [[NSMutableArray alloc] init];
    }
    return _moreBtns;
}


@end
