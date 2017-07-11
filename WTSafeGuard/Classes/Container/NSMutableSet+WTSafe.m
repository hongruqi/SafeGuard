//
//  NSMutableSet+WTSafe.m
//  Pods
//
//  Created by hongru qi on 2017/6/23.
//
//

#import "NSMutableSet+WTSafe.h"
#import "WTSafeGuard.h"
#import <objc/runtime.h>
#import "JRSwizzle.h"

@implementation NSMutableSet (WTSafe)

#pragma mark - Class Public Function

+ (void)runSafeGuard
{
    NSError *error = nil;
    [objc_getClass("__NSSetM") jr_swizzleMethod:@selector(addObject:) withMethod:@selector(WT_safeAddObject:) error:&error];
    [WTSafeGuard logSafeMethodErrorThenSetNil:&error];
}

#pragma mark - Object Private Function

- (void)WT_safeAddObject:(id)anObject
{
    if(!anObject) {
        NSAssert(false , @"WT_safeAddObject crash");
        return;
    }
    
    [self WT_safeAddObject:anObject];
}
@end
