//
//  NSIndexPath+WTSafe.m
//  Pods
//
//  Created by hongru qi on 2017/6/21.
//
//

#import "NSIndexPath+WTSafe.h"
#import "JRSwizzle.h"
#import <objc/runtime.h>
#import "WTSafeGuard.h"

@implementation NSIndexPath (WTSafe)

+ (void)runSafeGuard
{
    NSError *error = nil;
    
    [NSIndexPath jr_swizzleMethod:@selector(getIndexes:range:) withMethod:@selector(WT_safeGetIndexes:range:) error:&error];
    [WTSafeGuard logSafeMethodErrorThenSetNil:&error];
}

- (void)WT_safeGetIndexes:(NSUInteger *)indexes range:(NSRange)positionRange
{
    if (positionRange.location + positionRange.length > self.length) {
        [WTSafeGuard updateGuardCrashClassName:NSStringFromClass(self.class) selector:NSStringFromSelector(_cmd)];
        return;
    }
    
    return [self WT_safeGetIndexes:indexes range:positionRange];
}

@end
