//
//  NSObject+WTSafe.m
//  Pods
//
//  Created by hongru qi on 2017/6/12.
//
//

#import "NSObject+WTSafe.h"
#import "WTSafeGuard.h"
#import "JRSwizzle.h"
#import "WTKVOResource.h"
#import "WTKVOMapManager.h"

@implementation NSObject (WTSafe)

+ (void)runSafeGuard
{
    NSError *error = nil;
    [NSObject jr_swizzleMethod:@selector(forwardingTargetForSelector:) withMethod:@selector(WT_safeForwardingTargetForSelector:) error:&error];
    [WTSafeGuard logSafeMethodErrorThenSetNil:&error];
}

+ (void)runSafeGuardKVO
{
    NSError *error = nil;
    //KVO
    [NSObject jr_swizzleMethod:@selector(addObserver:forKeyPath:options:context:) withMethod:@selector(WT_addObserver:forKeyPath:options:context:) error:&error];
    [WTSafeGuard logSafeMethodErrorThenSetNil:&error];
    [NSObject jr_swizzleMethod:@selector(removeObserver:forKeyPath:) withMethod:@selector(WT_removeObserver:forKeyPath:) error:&error];
    [WTSafeGuard logSafeMethodErrorThenSetNil:&error];
    [NSObject jr_swizzleMethod:@selector(observeValueForKeyPath:ofObject:change:context:) withMethod:@selector(WT_observeValueForKeyPath:ofObject:change:context:) error:&error];
    [WTSafeGuard logSafeMethodErrorThenSetNil:&error];
    [NSObject jr_swizzleMethod:@selector(removeObserver:forKeyPath:context:) withMethod:@selector(WT_removeObserver:forKeyPath:context:) error:&error];
}

#pragma mark - Object Private Function

- (id)WT_safeForwardingTargetForSelector:(SEL)aSelector
{
    NSMethodSignature *signature = [self methodSignatureForSelector:aSelector];
    if ([self respondsToSelector:aSelector] || signature) {
        return [self WT_safeForwardingTargetForSelector:aSelector];
    }
    
    return [WTSafeGuard createFakeForwardTargetObject:self selector:aSelector];
}

- (void)WT_addObserver:(NSObject *)observer forKeyPath:(NSString *)keyPath options:(NSKeyValueObservingOptions)options context:(void *)context
{
    if (![[WTKVOMapManager shareInstance] isMapObserver:observer inkeySource:self keyPath:keyPath]) {
        WTKVOResource *resource = [[WTKVOResource alloc] initWithResource:self observer:observer key:keyPath];
        [[WTKVOMapManager shareInstance] addObserver:observer source:resource];
        [self WT_addObserver:observer forKeyPath:keyPath options:options context:context];
    }
}

- (void)WT_kvoDealloc
{
    [[WTKVOMapManager shareInstance] removeAllObserver:self];
    [self WT_kvoDealloc];
}

- (void)WT_removeObserver:(NSObject *)observer forKeyPath:(NSString *)keyPath
{
    if ([[WTKVOMapManager shareInstance] observerRemove:observer inkeySource:self keyPath:keyPath]) {
        [self WT_removeObserver:observer forKeyPath:keyPath];
    }
}

- (void)WT_removeObserver:(NSObject *)observer forKeyPath:(NSString *)keyPath context:(void *)context
{
    if ([[WTKVOMapManager shareInstance] observerRemove:observer inkeySource:self keyPath:keyPath]) {
        [self WT_removeObserver:observer forKeyPath:keyPath context:context];
    }
}

- (void)WT_observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context
{
    if (![[WTKVOMapManager shareInstance] observeValueForKeyPath:object inkeySource:self keyPath:keyPath]) {
        [self WT_observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

@end
