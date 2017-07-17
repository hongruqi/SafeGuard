//
//  NSURL+WTSafe.m
//  Pods
//
//  Created by hongru qi on 2017/6/23.
//
//

#import <objc/runtime.h>
#import "JRSwizzle.h"
#import "NSURL+WTSafe.h"
#import "WTSafeGuard.h"

@interface NSURL (WTSafeMethodPrivate)

+ (NSURL *)WT_safeFileURLWithPath:(NSString *)path isDirectory:(BOOL)isDir;

+ (NSURL *)WT_safeFileURLWithPathComponents:(NSArray<NSString *> *)components;

+ (NSURL *)WT_safeFileURLWithPath:(NSString *)path isDirectory:(BOOL) isDir relativeToURL:(NSURL *)baseURL;

- (instancetype)WT_safeInitWithString:(NSString *)URLString relativeToURL:(NSURL *)baseURL;

- (instancetype)WT_safeInitFileURLWithPath:(NSString *)path;

- (instancetype)WT_safeInitFileURLWithPath:(NSString *)path
                             relativeToURL:(NSURL *)baseURL;

- (instancetype)WT_safeInitFileURLWithPath:(NSString *)path
                               isDirectory:(BOOL)isDir
                             relativeToURL:(NSURL *)baseURL;

@end

@implementation NSURL (WTSafe)

#pragma mark - Class Public Function

+ (void)runSafeGuard
{
    CGFloat fVersion = [UIDevice currentDevice].systemVersion.floatValue;
    NSError *error = nil;
    
    [NSURL jr_swizzleClassMethod:@selector(fileURLWithPath:isDirectory:) withClassMethod:@selector(WT_safeFileURLWithPath:isDirectory:) error:&error];
    [WTSafeGuard logSafeMethodErrorThenSetNil:&error];
    
    [NSURL jr_swizzleClassMethod:@selector(fileURLWithPathComponents:) withClassMethod:@selector(WT_safeFileURLWithPathComponents:) error:&error];
    [WTSafeGuard logSafeMethodErrorThenSetNil:&error];
    
    [NSURL jr_swizzleMethod:@selector(initWithString:relativeToURL:) withMethod:@selector(WT_safeInitWithString:relativeToURL:) error:&error];
    [WTSafeGuard logSafeMethodErrorThenSetNil:&error];

    [NSURL jr_swizzleClassMethod:@selector(fileURLWithPath:) withClassMethod:@selector(WT_safeFileURLWithPath:) error:&error];
    [WTSafeGuard logSafeMethodErrorThenSetNil:&error];

    [NSURL jr_swizzleMethod:@selector(initFileURLWithPath:) withMethod:@selector(WT_safeInitFileURLWithPath:) error:&error];
    [WTSafeGuard logSafeMethodErrorThenSetNil:&error];
    
    if (fVersion >= 9.0f) {
        [NSURL jr_swizzleClassMethod:@selector(fileURLWithPath:isDirectory:relativeToURL:) withClassMethod:@selector(WT_safeFileURLWithPath:isDirectory:relativeToURL:) error:&error];
        [WTSafeGuard logSafeMethodErrorThenSetNil:&error];
        
        [NSURL jr_swizzleMethod:@selector(initFileURLWithPath:isDirectory:relativeToURL:) withMethod:@selector(WT_safeInitFileURLWithPath:isDirectory:relativeToURL:) error:&error];
        [WTSafeGuard logSafeMethodErrorThenSetNil:&error];
        
        [NSURL jr_swizzleMethod:@selector(initFileURLWithPath:relativeToURL:) withMethod:@selector(WT_safeInitFileURLWithPath:relativeToURL:) error:&error];
        [WTSafeGuard logSafeMethodErrorThenSetNil:&error];
    }
}

#pragma mark - Class Private Function

+ (NSURL *)WT_safeFileURLWithPath:(NSString *)path
{
    if(!path) {
        NSAssert(false , @"WT_safeFileURLWithPath crash");
        return nil;
    }
    
    return [self WT_safeFileURLWithPath:path];
}

+ (NSURL *)WT_safeFileURLWithPath:(NSString *)path isDirectory:(BOOL)isDir
{
    if(!path) {
        NSAssert(false , @"WT_safeFileURLWithPath crash");
        return nil;
    }
    
    return [self WT_safeFileURLWithPath:path isDirectory:isDir];
}

+ (NSURL *)WT_safeFileURLWithPathComponents:(NSArray<NSString *> *)components
{
    if(!components) {
        NSAssert(false , @"WT_safeFileURLWithPathComponents crash");
        return nil;
    }
    
    return [self WT_safeFileURLWithPathComponents:components];
}

+ (NSURL *)WT_safeFileURLWithPath:(NSString *)path
                      isDirectory:(BOOL)isDir
                    relativeToURL:(NSURL *)baseURL
{
    if (!path || ![path isKindOfClass:[NSString class]]) {
        NSAssert(false , @"WT_safeFileURLWithPath crash");
        return nil;
    }
    
    return [self WT_safeFileURLWithPath:path isDirectory:isDir relativeToURL:baseURL];
}

#pragma mark - Object Private Function

- (instancetype)WT_safeInitWithString:(NSString *)URLString relativeToURL:(NSURL *)baseURL
{
    if (!URLString || ![URLString isKindOfClass:[NSString class]]) {
        NSAssert(false , @"WT_safeInitWithString crash");
        return nil;
    }
    
    return [self WT_safeInitWithString:URLString relativeToURL:baseURL];
}

- (instancetype)WT_safeInitFileURLWithPath:(NSString *)path
{
    if (!path || ![path isKindOfClass:[NSString class]]) {
        NSAssert(false , @"WT_safeInitFileURLWithPath crash");
        return nil;
    }
    
    return [self WT_safeInitFileURLWithPath:path];
}

- (instancetype)WT_safeInitFileURLWithPath:(NSString *)path
                             relativeToURL:(NSURL *)baseURL
{
    if (!path || ![path isKindOfClass:[NSString class]]) {
        NSAssert(false , @"WT_safeInitFileURLWithPath crash");
        return nil;
    }
    
    return [self WT_safeInitFileURLWithPath:path relativeToURL:baseURL];
}

- (instancetype)WT_safeInitFileURLWithPath:(NSString *)path
                               isDirectory:(BOOL)isDir
                             relativeToURL:(NSURL *)baseURL
{
    if (!path || ![path isKindOfClass:[NSString class]]) {
        NSAssert(false , @"WT_safeInitFileURLWithPath crash");
        return nil;
    }
    
    return [self WT_safeInitFileURLWithPath:path isDirectory:isDir relativeToURL:baseURL];
}

@end
