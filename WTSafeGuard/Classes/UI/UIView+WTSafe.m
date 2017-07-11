//
//  UIView+WTSafe.m
//  Pods
//
//  Created by hongru qi on 2017/6/26.
//
//

#import "UIView+WTSafe.h"
#import "JRSwizzle.h"
#import <objc/runtime.h>
#import "WTSafeGuard.h"

@implementation UIView (WTSafe)

+ (void)runSafeGuard
{
    NSError *error = nil;
    
    [UIView jr_swizzleClassMethod:@selector(setNeedsLayout) withClassMethod:@selector(WT_safe_setNeedsLayout) error:&error];
    [WTSafeGuard logSafeMethodErrorThenSetNil:&error];
    [UIView jr_swizzleClassMethod:@selector(layoutIfNeeded) withClassMethod:@selector(WT_safe_layoutIfNeeded) error:&error];
    [WTSafeGuard logSafeMethodErrorThenSetNil:&error];
    [UIView jr_swizzleClassMethod:@selector(layoutSubviews) withClassMethod:@selector(WT_safe_layoutSubviews) error:&error];
    [WTSafeGuard logSafeMethodErrorThenSetNil:&error];
    [UIView jr_swizzleClassMethod:@selector(setNeedsUpdateConstraints) withClassMethod:@selector(WT_safe_setNeedsUpdateConstraints) error:&error];
    [WTSafeGuard logSafeMethodErrorThenSetNil:&error];
    
}

- (void)WT_safe_setNeedsLayout
{
    if(![NSThread isMainThread]){
        dispatch_async(dispatch_get_main_queue(), ^{
            NSAssert(false, @"WT_safe_setNeedsLayout failed");
            [self WT_safe_setNeedsLayout];
        });
    }else{
        [self WT_safe_setNeedsLayout];
    }
}

- (void)WT_safe_layoutIfNeeded
{
    if(![NSThread isMainThread]){
        dispatch_async(dispatch_get_main_queue(), ^{
            NSAssert(false, @"WT_safe_layoutIfNeeded failed");
            [self WT_safe_layoutIfNeeded];
        });
    }else{
        [self WT_safe_layoutIfNeeded];
    }
}

- (void)WT_safe_layoutSubviews
{
    if(![NSThread isMainThread]){
        dispatch_async(dispatch_get_main_queue(), ^{
            NSAssert(false, @"WT_safe_layoutSubviews failed");
            [self WT_safe_layoutSubviews];
        });
    }else{
        [self WT_safe_layoutSubviews];
    }
}

- (void)WT_safe_setNeedsUpdateConstraints
{
    if(![NSThread isMainThread]){
        dispatch_async(dispatch_get_main_queue(), ^{
            NSAssert(false, @"WT_safe_setNeedsUpdateConstraints failed");
            [self WT_safe_setNeedsUpdateConstraints];
        });
    }else{
        [self WT_safe_setNeedsUpdateConstraints];
    }
}
@end
