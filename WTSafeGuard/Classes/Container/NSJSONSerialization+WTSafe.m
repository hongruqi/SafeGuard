//
//  NSJSONSerialization+WTSafe.m
//  Pods
//
//  Created by hongru qi on 2017/6/23.
//
//

#import "NSJSONSerialization+WTSafe.h"
#import <objc/runtime.h>
#import "WTSafeGuard.h"
#import "JRSwizzle.h"

@implementation NSJSONSerialization (WTSafe)
#pragma mark - Class Public Function

+ (void)runSafeGuard
{
    NSError *error = nil;
    [NSJSONSerialization jr_swizzleClassMethod:@selector(dataWithJSONObject:options:error:) withClassMethod:@selector(WT_safeDataWithJSONObject:options:error:) error:&error];
    [WTSafeGuard logSafeMethodErrorThenSetNil:&error];
}

#pragma mark - Class Private Function

+ (NSData *)WT_safeDataWithJSONObject:(id)obj options:(NSJSONWritingOptions)opt error:(NSError **)error
{
    if (!obj) {
        [WTSafeGuard updateGuardCrashClassName:NSStringFromClass(self.class) selector:NSStringFromSelector(_cmd)];
        return nil;
    }
    
    return [self WT_safeDataWithJSONObject:obj options:opt error:error];
}
@end
