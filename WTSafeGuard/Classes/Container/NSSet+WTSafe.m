//
//  NSSet+WTSafe.m
//  Pods
//
//  Created by hongru qi on 2017/6/23.
//
//

#import "NSSet+WTSafe.h"
#import <objc/runtime.h>
#import "JRSwizzle.h"
#import "WTSafeGuard.h"

@implementation NSSet (WTSafe)

#pragma mark - Class Public Function

+ (void)runSafeGuard
{
    NSError *error = nil;
    
    [objc_getClass("__NSSetI") jr_swizzleMethod:@selector(makeObjectsPerformSelector:) withMethod:@selector(WT_safeMakeObjectsPerformSelector:) error:&error];
    [WTSafeGuard logSafeMethodErrorThenSetNil:&error];
    
    [objc_getClass("__NSSetI") jr_swizzleMethod:@selector(makeObjectsPerformSelector:withObject:) withMethod:@selector(WT_safeMakeObjectsPerformSelector:withObject:) error:&error];
    [WTSafeGuard logSafeMethodErrorThenSetNil:&error];
    
    [objc_getClass("__NSSetM") jr_swizzleMethod:@selector(makeObjectsPerformSelector:) withMethod:@selector(WT_safeMakeObjectsPerformSelector:) error:&error];
    [WTSafeGuard logSafeMethodErrorThenSetNil:&error];
    
    [objc_getClass("__NSSetM") jr_swizzleMethod:@selector(makeObjectsPerformSelector:withObject:) withMethod:@selector(WT_safeMakeObjectsPerformSelector:withObject:) error:&error];
    [WTSafeGuard logSafeMethodErrorThenSetNil:&error];
}

#pragma mark - Class Private Function

- (void)WT_safeMakeObjectsPerformSelector:(SEL)aSelector
{
    if (!aSelector) {
        NSAssert(false , @"WT_safeMakeObjectsPerformSelector crash");
        return;
    }
    
    return [self WT_safeMakeObjectsPerformSelector:aSelector];
}

- (void)WT_safeMakeObjectsPerformSelector:(SEL)aSelector
                               withObject:(id)argument
{
    if (!aSelector) {
        NSAssert(false , @"WT_safeMakeObjectsPerformSelector crash");
        return;
    }
    
    return [self WT_safeMakeObjectsPerformSelector:aSelector withObject:argument];
}

@end

