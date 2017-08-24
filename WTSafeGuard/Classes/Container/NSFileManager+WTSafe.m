//
//  NSFileManager+WTSafe.m
//  Pods
//
//  Created by hongru qi on 2017/6/23.
//
//

#import "NSFileManager+WTSafe.h"
#import "WTSafeGuard.h"
#import <objc/runtime.h>
#import "JRSwizzle.h"

@implementation NSFileManager (WTSafe)
#pragma mark - Class Public Function

+ (void)runSafeGuard
{
    NSError *error = nil;
    [NSFileManager jr_swizzleMethod:@selector(enumeratorAtURL:includingPropertiesForKeys:options:errorHandler:) withMethod:@selector(WT_safeEnumeratorAtURL:includingPropertiesForKeys:options:errorHandler:) error:&error];
    [WTSafeGuard logSafeMethodErrorThenSetNil:&error];
    
}

#pragma mark - Object Private Function

- (NSDirectoryEnumerator *)WT_safeEnumeratorAtURL:(NSURL *)url includingPropertiesForKeys:(NSArray *)keys options:(NSDirectoryEnumerationOptions)mask errorHandler:(BOOL (^)(NSURL *, NSError *))handler
{
    if(!url) {
        [WTSafeGuard updateGuardCrashClassName:NSStringFromClass(self.class) selector:NSStringFromSelector(_cmd)];
        return nil;
    }
    
    return [self WT_safeEnumeratorAtURL:url includingPropertiesForKeys:keys options:mask errorHandler:handler];
}

@end
