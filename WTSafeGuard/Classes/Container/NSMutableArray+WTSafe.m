//
//  NSMutableArray+WTSafe.m
//  WTSafetyGuard
//
//  Created by hongru qi on 2017/6/10.
//

#import "NSMutableArray+WTSafe.h"
#import "WTSafeGuard.h"
#import <objc/runtime.h>
#import "JRSwizzle.h"

@implementation NSMutableArray (WTSafe)

+ (void)runSafeGuard
{
    [NSMutableArray runSafeGuard_insertObject_atIndex];
    [NSMutableArray runSafeGuard_insertObjects_atIndexes];
    [NSMutableArray runSafeGuard_removeObjectAtIndex];
    [NSMutableArray runSafeGuard_removeObjectsAtIndexes];
    [NSMutableArray runSafeGuard_replaceObjectAtIndex_withObject];
    [NSMutableArray runSafeGuard_replaceObjectsAtIndexes_withObjects];
    [NSMutableArray runSafeGuard_exchangeObjectAtIndex_withObjectAtIndex];
    [NSMutableArray runSafeGuard_removeObject_inRange];
    [NSMutableArray runSafeGuard_removeObjectIdenticalTo_inRange];
    [NSMutableArray runSafeGuard_setObject_atIndexedSubscript];
}

+ (void)runSafeGuard_insertObject_atIndex{
    NSError *error = nil;
    [objc_getClass("__NSArrayM") jr_swizzleMethod:@selector(insertObject:atIndex:) withMethod:@selector(WT_safe_insertObject:atIndex:) error:&error];
    [WTSafeGuard logSafeMethodErrorThenSetNil:&error];
}

+ (void)runSafeGuard_insertObjects_atIndexes
{
    NSError *error = nil;
    [objc_getClass("__NSArrayM") jr_swizzleMethod:@selector(insertObjects:atIndexes:) withMethod:@selector(WT_safe_insertObjects:atIndexes:) error:&error];
    [WTSafeGuard logSafeMethodErrorThenSetNil:&error];
    
}

+ (void)runSafeGuard_removeObjectAtIndex
{
    NSError *error = nil;
    [objc_getClass("__NSArrayM") jr_swizzleMethod:@selector(removeObjectAtIndex:) withMethod:@selector(WT_safe_removeObjectAtIndex:) error:&error];
    [WTSafeGuard logSafeMethodErrorThenSetNil:&error];
}

+ (void)runSafeGuard_removeObjectsAtIndexes
{
    NSError *error = nil;
    [objc_getClass("__NSArrayM") jr_swizzleMethod:@selector(removeObjectsAtIndexes:) withMethod:@selector(WT_safe_removeObjectsAtIndexes:) error:&error];
    [WTSafeGuard logSafeMethodErrorThenSetNil:&error];
}

+ (void)runSafeGuard_replaceObjectAtIndex_withObject
{
    NSError *error = nil;
    [objc_getClass("__NSArrayM") jr_swizzleMethod:@selector(replaceObjectAtIndex:withObject:) withMethod:@selector(WT_safe_replaceObjectAtIndex:withObject:) error:&error];
    [WTSafeGuard logSafeMethodErrorThenSetNil:&error];
}

+ (void)runSafeGuard_replaceObjectsAtIndexes_withObjects
{
    NSError *error = nil;
    [objc_getClass("__NSArrayM") jr_swizzleMethod:@selector(replaceObjectsAtIndexes:withObjects:) withMethod:@selector(WT_safe_replaceObjectsAtIndexes:withObjects:) error:&error];
    [WTSafeGuard logSafeMethodErrorThenSetNil:&error];
}

+ (void)runSafeGuard_exchangeObjectAtIndex_withObjectAtIndex
{
    NSError *error = nil;
    [objc_getClass("__NSArrayM") jr_swizzleMethod:@selector(exchangeObjectAtIndex:withObjectAtIndex:) withMethod:@selector(WT_safe_exchangeObjectAtIndex:withObjectAtIndex:) error:&error];
    [WTSafeGuard logSafeMethodErrorThenSetNil:&error];
}

+ (void)runSafeGuard_removeObject_inRange{
    NSError *error = nil;
    [objc_getClass("__NSArrayM") jr_swizzleMethod:@selector(removeObject:inRange:) withMethod:@selector(WT_safe_removeObject:inRange:) error:&error];
    [WTSafeGuard logSafeMethodErrorThenSetNil:&error];
}

+ (void)runSafeGuard_removeObjectIdenticalTo_inRange
{
    NSError *error = nil;
    [objc_getClass("__NSArrayM") jr_swizzleMethod:@selector(removeObjectIdenticalTo:inRange:) withMethod:@selector(WT_safe_removeObjectIdenticalTo:inRange:) error:&error];
    [WTSafeGuard logSafeMethodErrorThenSetNil:&error];
}

+ (void)runSafeGuard_setObject_atIndexedSubscript
{
    NSError *error = nil;
    [objc_getClass("__NSArrayM") jr_swizzleMethod:@selector(setObject:atIndexedSubscript:) withMethod:@selector(WT_safe_setObject:atIndexedSubscript:) error:&error];
    [WTSafeGuard logSafeMethodErrorThenSetNil:&error];
}

- (void)WT_safe_insertObject:(id)anObject atIndex:(NSUInteger)index
{
    if(self && anObject && (index <= [self count])) {
        [self WT_safe_insertObject:anObject atIndex:index];
    }else{
        NSAssert(false , @"WT_safeEnumeratorAtURL crash");
    }
}

- (void)WT_safe_insertObjects:(NSArray *)objects atIndexes:(NSIndexSet *)indexes
{
    if (self && objects && indexes) {
        if (objects.count == indexes.count) {
            
            __block BOOL canInsert = YES;
            [indexes enumerateIndexesUsingBlock:^(NSUInteger idx, BOOL * _Nonnull stop) {
                if (idx >= (self.count+objects.count)) {
                    NSAssert(false , @"WT_safe_insertObjects crash");
                    canInsert = NO;
                    *stop = YES;
                }
            }];
            
            if (canInsert) {
                [self WT_safe_insertObjects:objects atIndexes:indexes];
            }
        }
    }
}

- (void)WT_safe_removeObjectAtIndex:(NSUInteger)index
{
    if (self && index < [self count]) {
        [self WT_safe_removeObjectAtIndex:index];
    }else{
        NSAssert(false, @"WT_safe_removeObjectAtIndex crash");
    }
}

- (void)WT_safe_removeObjectsAtIndexes:(NSIndexSet *)indexes
{
    if (self && indexes){
        __block BOOL canRemove = YES;
        [indexes enumerateIndexesUsingBlock:^(NSUInteger idx, BOOL * _Nonnull stop) {
            if (idx >= self.count) {
                NSAssert(false , @"WT_safe_removeObjectsAtIndexes crash");
                canRemove = NO;
                *stop = YES;
            }
        }];
        
        if (canRemove) {
            [self WT_safe_removeObjectsAtIndexes:indexes];
        }
    }
}

- (void)WT_safe_replaceObjectAtIndex:(NSUInteger)index withObject:(id)anObject
{
    if (self && index < [self count] && anObject) {
        [self WT_safe_replaceObjectAtIndex:index withObject:anObject];
    }else{
        NSAssert(false, @"WT_safe_replaceObjectAtIndex crash");
    }
}

- (void)WT_safe_replaceObjectsAtIndexes:(NSIndexSet *)indexes
                            withObjects:(NSArray *)objects{
    if (self && objects && indexes) {
        if (objects.count == indexes.count) {
            
            __block BOOL canReplace = YES;
            [indexes enumerateIndexesUsingBlock:^(NSUInteger idx, BOOL * _Nonnull stop) {
                if (idx >= (self.count + objects.count)) {
                    NSAssert(false , @"WT_safe_replaceObjectsAtIndexes crash");
                    canReplace = NO;
                    *stop = YES;
                }
            }];
            
            if (canReplace) {
                [self WT_safe_replaceObjectsAtIndexes:indexes withObjects:objects];
            }
        }
    }
}

- (void)WT_safe_exchangeObjectAtIndex:(NSUInteger)idx1 withObjectAtIndex:(NSUInteger)idx2
{
    if (self && idx1 < [self count] && idx2 < [self count]) {
        [self WT_safe_exchangeObjectAtIndex:idx1 withObjectAtIndex:idx2];
    }else{
        NSAssert(false , @"WT_safe_exchangeObjectAtIndex crash");
    }
}

- (void)WT_safe_removeObject:(NSObject *)anObject inRange:(NSRange)range
{
    if (self && range.location != NSNotFound && range.length != NSNotFound && (range.location + range.length) <= (int)self.count) {
        [self WT_safe_removeObject:anObject inRange:range];
    }else{
        NSAssert(false , @"WT_safe_removeObject crash");
    }
}

- (void)WT_safe_removeObjectIdenticalTo:(NSObject *)anObject inRange:(NSRange)aRange
{
    if (self && aRange.location != NSNotFound && aRange.length != NSNotFound && (aRange.length+aRange.location)<= self.count){
        [self WT_safe_removeObjectIdenticalTo:anObject inRange:aRange];
    }else{
        NSAssert(false , @"WT_safe_removeObjectIdenticalTo crash");
    }
}

- (void)WT_safe_setObject:(NSObject *)anObject atIndexedSubscript:(NSUInteger)index
{
    if (self && anObject && index <= self.count){
        [self WT_safe_setObject:anObject atIndexedSubscript:index];
    }else{
        NSAssert(false , @"WT_safe_setObject crash");
    }
}
@end
