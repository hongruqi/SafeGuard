//
//  NSMutableString+WTSafe.m
//  Pods
//
//  Created by hongru qi on 2017/6/23.
//
//

#import "NSMutableString+WTSafe.h"
#import "WTSafeGuard.h"
#import <objc/runtime.h>
#import "JRSwizzle.h"

@implementation NSMutableString (WTSafe)
#pragma mark - Class Public Function

+ (void)runSafeGuard
{
    NSError *error = nil;
    
    [objc_getClass("__NSCFString") jr_swizzleMethod:@selector(setString:) withMethod:@selector(WT_safeSetString:) error:&error];
    [WTSafeGuard logSafeMethodErrorThenSetNil:&error];
    
    [objc_getClass("__NSCFString") jr_swizzleMethod:@selector(appendString:) withMethod:@selector(WT_safeAppendString:) error:&error];
    [WTSafeGuard logSafeMethodErrorThenSetNil:&error];
    
    [objc_getClass("__NSCFString") jr_swizzleMethod:@selector(deleteCharactersInRange:) withMethod:@selector(WT_safeDeleteCharactersInRange:) error:&error];
    [WTSafeGuard logSafeMethodErrorThenSetNil:&error];
    
    [objc_getClass("__NSCFString") jr_swizzleMethod:@selector(insertString:atIndex:) withMethod:@selector(WT_safeInsertString:atIndex:) error:&error];
    [WTSafeGuard logSafeMethodErrorThenSetNil:&error];
    
    [objc_getClass("__NSCFString") jr_swizzleMethod:@selector(replaceCharactersInRange:withString:) withMethod:@selector(WT_safeReplaceCharactersInRange:withString:) error:&error];
    [WTSafeGuard logSafeMethodErrorThenSetNil:&error];
    
    [objc_getClass("__NSCFString") jr_swizzleMethod:@selector(replaceOccurrencesOfString:withString:options:range:) withMethod:@selector(WT_safeReplaceOccurrencesOfString:withString:options:range:) error:&error];
    [WTSafeGuard logSafeMethodErrorThenSetNil:&error];
}

#pragma mark - Object Private Function

- (void)WT_safeSetString:(NSString *)aString
{
    if (!aString || ![aString isKindOfClass:[NSString class]]) {
        NSAssert(false , @"WT_safeSetString crash");
        return;
    }
    
    return [self WT_safeSetString:aString];
}

- (void)WT_safeAppendString:(NSString *)aString
{
    if (!aString || ![aString isKindOfClass:[NSString class]]) {
        NSAssert(false , @"WT_safeAppendString crash");
        return;
    }
    
    return [self WT_safeAppendString:aString];
}

- (void)WT_safeDeleteCharactersInRange:(NSRange)range
{
    if (range.location > self.length || range.location + range.length > self.length) {
        NSAssert(false , @"WT_safeDeleteCharactersInRange crash");
        return;
    }
    
    [self WT_safeDeleteCharactersInRange:range];
}

- (void)WT_safeInsertString:(NSString *)aString atIndex:(NSUInteger)loc
{
    if (!aString || ![aString isKindOfClass:[NSString class]]) {
        NSAssert(false , @"WT_safeInsertString crash");
        return;
    }
    
    if (loc > self.length) {
        NSAssert(false , @"WT_safeDeleteCharactersInRange crash");
        return;
    }
    
    [self WT_safeInsertString:aString atIndex:loc];
}

- (void)WT_safeReplaceCharactersInRange:(NSRange)range withString:(NSString *)aString
{
    if (range.location > self.length || range.location + range.length > self.length) {
        NSAssert(false , @"WT_safeReplaceCharactersInRange crash");
        return;
    }
    
    if (!aString || ![aString isKindOfClass:[NSString class]]) {
        NSAssert(false , @"WT_safeReplaceCharactersInRange crash");
        return;
    }
    
    [self WT_safeReplaceCharactersInRange:range withString:aString];
}

- (NSUInteger)WT_safeReplaceOccurrencesOfString:(NSString *)target
                                     withString:(NSString *)replacement
                                        options:(NSStringCompareOptions)options
                                          range:(NSRange)searchRange
{
    if (!target || ![target isKindOfClass:[NSString class]]) {
        NSAssert(false , @"WT_safeReplaceOccurrencesOfString crash");
        return 0;
    }
    
    if (!replacement || ![replacement isKindOfClass:[NSString class]]) {
        NSAssert(false , @"WT_safeReplaceOccurrencesOfString crash");
        return 0;
    }
    
    if (searchRange.location > self.length || searchRange.location + searchRange.length > self.length) {
        NSAssert(false , @"WT_safeReplaceOccurrencesOfString crash");
        return 0;
    }
    
    return [self WT_safeReplaceOccurrencesOfString:target
                                        withString:replacement
                                           options:options
                                             range:searchRange];
}

@end
