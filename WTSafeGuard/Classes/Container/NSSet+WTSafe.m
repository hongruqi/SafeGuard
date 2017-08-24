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
    [objc_getClass("__NSPlaceholderSet") jr_swizzleMethod:@selector(initWithObjects:count:) withMethod:@selector(WT_initWithObjects: count:) error:&error];
    
    [objc_getClass("__NSSetI") jr_swizzleMethod:@selector(makeObjectsPerformSelector:) withMethod:@selector(WT_safeMakeObjectsPerformSelector:) error:&error];
    [WTSafeGuard logSafeMethodErrorThenSetNil:&error];
    
    [objc_getClass("__NSSetI") jr_swizzleMethod:@selector(makeObjectsPerformSelector:withObject:) withMethod:@selector(WT_safeMakeObjectsPerformSelector:withObject:) error:&error];
    [WTSafeGuard logSafeMethodErrorThenSetNil:&error];
    
    [objc_getClass("__NSSetM") jr_swizzleMethod:@selector(makeObjectsPerformSelector:) withMethod:@selector(WT_safeMakeObjectsPerformSelector:) error:&error];
    [WTSafeGuard logSafeMethodErrorThenSetNil:&error];

    [objc_getClass("__NSSetM") jr_swizzleMethod:@selector(addObject:) withMethod:@selector(WT_addObject:) error:&error];
    [WTSafeGuard logSafeMethodErrorThenSetNil:&error];

    [objc_getClass("__NSSetM") jr_swizzleMethod:@selector(makeObjectsPerformSelector:withObject:) withMethod:@selector(WT_safeMakeObjectsPerformSelector:withObject:) error:&error];
    [WTSafeGuard logSafeMethodErrorThenSetNil:&error];
}

#pragma mark - Class Private Function
- (instancetype)WT_initWithObjects:(const id [])objects count:(NSUInteger)cnt
{
    for (int i = 0; i < cnt; ++i) {
        if(objects && objects[i] == nil) {
            [WTSafeGuard updateGuardCrashClassName:NSStringFromClass(self.class) selector:NSStringFromSelector(_cmd)];
            return nil;
        }
    }
    return [self WT_initWithObjects:objects count:cnt];
}

- (void)WT_addObject:(id)object;
{
    if (!object) {
        [WTSafeGuard updateGuardCrashClassName:NSStringFromClass(self.class) selector:NSStringFromSelector(_cmd)];
        return;
    }
    
    return [self WT_addObject:object];
}



- (void)WT_safeMakeObjectsPerformSelector:(SEL)aSelector
{
    if (!aSelector) {
        [WTSafeGuard updateGuardCrashClassName:NSStringFromClass(self.class) selector:NSStringFromSelector(_cmd)];
        return;
    }
    
    return [self WT_safeMakeObjectsPerformSelector:aSelector];
}

- (void)WT_safeMakeObjectsPerformSelector:(SEL)aSelector
                               withObject:(id)argument
{
    if (!aSelector) {
        [WTSafeGuard updateGuardCrashClassName:NSStringFromClass(self.class) selector:NSStringFromSelector(_cmd)];
        return;
    }
    
    return [self WT_safeMakeObjectsPerformSelector:aSelector withObject:argument];
}

@end

