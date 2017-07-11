//
//  NSDictionary+WTSafe.m
//  Pods
//
//  Created by hongru qi on 2017/6/21.
//
//

#import "NSDictionary+WTSafe.h"
#import "JRSwizzle.h"
#import <objc/runtime.h>
#import "WTSafeGuard.h"

@implementation NSDictionary (WTSafe)

+ (void)runSafeGuard
{
    NSError *error = nil;
    
    [NSDictionary jr_swizzleClassMethod:@selector(sharedKeySetForKeys:) withClassMethod:@selector(WT_safeSharedKeySetForKeys:) error:&error];
    [WTSafeGuard logSafeMethodErrorThenSetNil:&error];
    
    [NSDictionary jr_swizzleMethod:@selector(initWithObjects:forKeys:) withMethod:@selector(WT_safeInitWithObjects:forKeys:) error:&error];
    [WTSafeGuard logSafeMethodErrorThenSetNil:&error];
    
    [objc_getClass("__NSPlaceholderDictionary") jr_swizzleMethod:@selector(initWithObjects:forKeys:count:) withMethod:@selector(WT_safeInitWithObjects:forKeys:count:) error:&error];
    [WTSafeGuard logSafeMethodErrorThenSetNil:&error];
}

#pragma mark - Class Private Function

+ (id)WT_safeSharedKeySetForKeys:(NSArray *)keys
{
    if (!keys || ![keys isKindOfClass:[NSArray class]]) {
        NSAssert(false , @"WT_safeSharedKeySetForKeys crash");
        return nil;
    }
    
    return [NSDictionary WT_safeSharedKeySetForKeys:keys];
}

- (instancetype)WT_safeInitWithObjects:(NSArray *)objects forKeys:(NSArray *)keys
{
    if(![objects isKindOfClass:[NSArray class]] ||
       ![keys isKindOfClass:[NSArray class]] ||
       objects.count != keys.count) {
        NSAssert(false , @"WT_safeInitWithObjects crash");
        return nil;
    }
    
    return [self WT_safeInitWithObjects:objects forKeys:keys];
}

- (instancetype)WT_safeInitWithObjects:(const id [])objects
                               forKeys:(const id <NSCopying> [])keys
                                 count:(NSUInteger)cnt
{
    for (int i = 0; i < cnt; ++i) {
        if(!keys[i] || !objects[i]) {
            NSAssert(false , @"WT_safeInitWithObjects crash");
            return nil;
        }
    }
    
    return [self WT_safeInitWithObjects:objects forKeys:keys count:cnt];
}

@end
