//
//  NSArray+WTSafe.m
//  Pods
//
//  Created by hongru qi on 2017/6/20.
//
//

#import "NSArray+WTSafe.h"
#import "WTSafeGuard.h"
#import <objc/runtime.h>
#import "JRSwizzle.h"

@implementation NSArray (WTSafe)

+ (void)runSafeGuard
{
    NSError *error = nil;
    
    [objc_getClass("__NSPlaceholderArray") jr_swizzleMethod:@selector(initWithObjects:count:) withMethod:@selector(WT_safeInitWithObjects:count:) error:&error];
    [WTSafeGuard logSafeMethodErrorThenSetNil:&error];
    [NSArray runSafeGuard_objectAtIndex];
    [NSArray runSafeGuard_arrayByAddingObject];
}


+ (void)runSafeGuard_objectAtIndex
{
    NSError *error = nil;
    [objc_getClass("__NSArray0") jr_swizzleMethod:@selector(objectAtIndex:) withMethod:@selector(WT_safeObjectAtIndex:) error:&error];
    [WTSafeGuard logSafeMethodErrorThenSetNil:&error];
    
    [objc_getClass("__NSArrayI") jr_swizzleMethod:@selector(objectAtIndex:) withMethod:@selector(WT_safeObjectAtIndex:) error:&error];
    [WTSafeGuard logSafeMethodErrorThenSetNil:&error];
    
    [objc_getClass("__NSArrayM") jr_swizzleMethod:@selector(objectAtIndex:) withMethod:@selector(WT_safeObjectAtIndex:) error:&error];
    [WTSafeGuard logSafeMethodErrorThenSetNil:&error];
    
}

+ (void)runSafeGuard_arrayByAddingObject
{
    NSError *error = nil;
    [objc_getClass("NSArray") jr_swizzleMethod:@selector(arrayByAddingObject:) withMethod:@selector(WT_safeArrayByAddingObject:) error:&error];
    [WTSafeGuard logSafeMethodErrorThenSetNil:&error];
}
#pragma mark - Object Private Function

- (id)WT_safeObjectAtIndex:(int)index
{
    if(index >= 0 && index < self.count) {
        return [self WT_safeObjectAtIndex:index];
    }
    
    return nil;
}

- (instancetype)WT_safeInitWithObjects:(const id [])objects count:(NSUInteger)cnt
{
    for (int i = 0; i < cnt; ++i) {
        if(objects && objects[i] == nil) {
            NSAssert(!(objects && objects[i] == nil), @"WT_safeInitWithObjects failed");
            return nil;
        }
    }
    return [self WT_safeInitWithObjects:objects count:cnt];
}


- (NSArray *)WT_safeArrayByAddingObject:(id)anObject
{
    if(anObject) {
        return [self WT_safeArrayByAddingObject:anObject];
    }
    
    NSAssert(!anObject, @"WT_safeArrayByAddingObject failed");
    return self;
}

@end
