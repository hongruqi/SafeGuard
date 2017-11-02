//
//  NSMutableDictionary+WTSafe.m
//  WTSafetyGuard
//
//  Created by hongru qi on 2017/6/10.
//

#import "NSMutableDictionary+WTSafe.h"
#import <objc/runtime.h>
#import "WTSafeGuard.h"
#import "JRSwizzle.h"

@implementation NSMutableDictionary (WTSafe)

+ (void)runSafeGuard
{
    NSError *error = nil;
    
    [NSMutableDictionary jr_swizzleClassMethod:@selector(dictionaryWithSharedKeySet:) withClassMethod:@selector(WT_safeDictionaryWithSharedKeySet:) error:&error];
    [WTSafeGuard logSafeMethodErrorThenSetNil:&error];
    
    [objc_getClass("__NSDictionaryM") jr_swizzleMethod:@selector(setObject:forKey:) withMethod:@selector(WT_safeSetObject:forKey:) error:&error];
    [WTSafeGuard logSafeMethodErrorThenSetNil:&error];
    
    [objc_getClass("__NSCFDictionary") jr_swizzleMethod:@selector(setObject:forKey:) withMethod:@selector(WT_safeSetObject:forKey:) error:&error];
    [WTSafeGuard logSafeMethodErrorThenSetNil:&error];
    
    [objc_getClass("__NSDictionaryM") jr_swizzleMethod:@selector(removeObjectForKey:) withMethod:@selector(WT_safeRemoveObjectForKey:) error:&error];
    [WTSafeGuard logSafeMethodErrorThenSetNil:&error];
    [objc_getClass("__NSDictionaryM") jr_swizzleMethod:@selector(setValue:forKey:) withMethod:@selector(WT_safeSetValue:forKey:) error:&error];
    [WTSafeGuard logSafeMethodErrorThenSetNil:&error];
}

#pragma mark - Class Private Function

+ (NSMutableDictionary *)WT_safeDictionaryWithSharedKeySet:(id)keyset
{
    if (!keyset) {
        [WTSafeGuard updateGuardCrashClassName:NSStringFromClass(self.class) selector:NSStringFromSelector(_cmd)];
        return nil;
    }
    
    return [NSMutableDictionary WT_safeDictionaryWithSharedKeySet:keyset];
}

#pragma mark - Object Private Function

- (void)WT_safeSetObject:(id)anObject forKey:(id<NSCopying>)aKey
{
    if(!anObject || !aKey) {
        [WTSafeGuard updateGuardCrashClassName:NSStringFromClass(self.class) selector:NSStringFromSelector(_cmd)];
        return;
    }
    
    [self WT_safeSetObject:anObject forKey:aKey];
}

- (void)WT_safeRemoveObjectForKey:(id<NSCopying>)aKey
{
    if(!aKey) {
        [WTSafeGuard updateGuardCrashClassName:NSStringFromClass(self.class) selector:NSStringFromSelector(_cmd)];
        return;
    }
    
    [self WT_safeRemoveObjectForKey:aKey];
}

- (void)WT_safeSetValue:(id)anObject forKey:(id<NSCopying>)aKey
{
    if(!aKey) {
        [WTSafeGuard updateGuardCrashClassName:NSStringFromClass(self.class) selector:NSStringFromSelector(_cmd)];
        return;
    }
    
    [self WT_safeSetValue:anObject forKey:aKey];
}

@end
