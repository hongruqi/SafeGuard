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
    
    [UIView jr_swizzleMethod:@selector(setNeedsLayout) withMethod:@selector(WT_safe_setNeedsLayout) error:&error];
    [WTSafeGuard logSafeMethodErrorThenSetNil:&error];
    [UIView jr_swizzleMethod:@selector(layoutIfNeeded) withMethod:@selector(WT_safe_layoutIfNeeded) error:&error];
    [WTSafeGuard logSafeMethodErrorThenSetNil:&error];
    [UIView jr_swizzleMethod:@selector(layoutSubviews) withMethod:@selector(WT_safe_layoutSubviews) error:&error];
    [WTSafeGuard logSafeMethodErrorThenSetNil:&error];
    [UIView jr_swizzleMethod:@selector(setNeedsUpdateConstraints) withMethod:@selector(WT_safe_setNeedsUpdateConstraints) error:&error];
    [WTSafeGuard logSafeMethodErrorThenSetNil:&error];
    
}

- (void)WT_safe_setNeedsLayout
{
    if (strcmp(dispatch_queue_get_label(DISPATCH_CURRENT_QUEUE_LABEL), dispatch_queue_get_label(dispatch_get_main_queue())) == 0) {
        [self WT_safe_setNeedsLayout];
    } else {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self WT_safe_setNeedsLayout];
        });
    }
}

- (void)WT_safe_layoutIfNeeded
{
    if (strcmp(dispatch_queue_get_label(DISPATCH_CURRENT_QUEUE_LABEL), dispatch_queue_get_label(dispatch_get_main_queue())) == 0) {
        [self WT_safe_layoutIfNeeded];
    } else {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self WT_safe_layoutIfNeeded];
        });
    }
}

- (void)WT_safe_layoutSubviews
{
    if (strcmp(dispatch_queue_get_label(DISPATCH_CURRENT_QUEUE_LABEL), dispatch_queue_get_label(dispatch_get_main_queue())) == 0) {
        [self WT_safe_layoutSubviews];
    } else {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self WT_safe_layoutSubviews];
        });
    }
}

- (void)WT_safe_setNeedsUpdateConstraints
{
    if (strcmp(dispatch_queue_get_label(DISPATCH_CURRENT_QUEUE_LABEL), dispatch_queue_get_label(dispatch_get_main_queue())) == 0) {
        [self WT_safe_setNeedsUpdateConstraints];
    } else {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self WT_safe_setNeedsUpdateConstraints];
        });
    }
}
@end
