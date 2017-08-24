//
//  NSString+WTSafe.m
//  Pods
//
//  Created by hongru qi on 2017/6/23.
//
//

#import "NSString+WTSafe.h"
#import "JRSwizzle.h"
#import <objc/runtime.h>
#import "WTSafeGuard.h"

@implementation NSString (WTSafe)

+ (void)runSafeGuard
{
    NSError *error = nil;
    
    [NSString jr_swizzleClassMethod:@selector(stringWithUTF8String:) withClassMethod:@selector(WT_safeStringWithUTF8String:) error:&error];
    [WTSafeGuard logSafeMethodErrorThenSetNil:&error];
    
    [NSString jr_swizzleMethod:@selector(stringByAppendingString:) withMethod:@selector(WT_safeStringByAppendingString:) error:&error];
    [WTSafeGuard logSafeMethodErrorThenSetNil:&error];
    
    [objc_getClass("NSPlaceholderString") jr_swizzleMethod:@selector(initWithString:) withMethod:@selector(WT_safeInitWithString:) error:&error];
    [WTSafeGuard logSafeMethodErrorThenSetNil:&error];
    
    [objc_getClass("NSPlaceholderMutableString") jr_swizzleMethod:@selector(initWithString:) withMethod:@selector(WT_safeInitWithString:) error:&error];
    [WTSafeGuard logSafeMethodErrorThenSetNil:&error];
    
    [objc_getClass("NSPlaceholderString") jr_swizzleMethod:@selector(initWithUTF8String:) withMethod:@selector(WT_safeInitWithUTF8String:) error:&error];
    [WTSafeGuard logSafeMethodErrorThenSetNil:&error];
    
    [objc_getClass("NSPlaceholderMutableString") jr_swizzleMethod:@selector(initWithUTF8String:) withMethod:@selector(WT_safeInitWithUTF8String:) error:&error];
    [WTSafeGuard logSafeMethodErrorThenSetNil:&error];
    
    [objc_getClass("NSPlaceholderString") jr_swizzleMethod:@selector(initWithFormat:locale:arguments:) withMethod:@selector(WT_safeInitWithFormat:locale:arguments:) error:&error];
    [WTSafeGuard logSafeMethodErrorThenSetNil:&error];
    
    [objc_getClass("NSPlaceholderMutableString") jr_swizzleMethod:@selector(initWithFormat:locale:arguments:) withMethod:@selector(WT_safeInitWithFormat:locale:arguments:) error:&error];
    [WTSafeGuard logSafeMethodErrorThenSetNil:&error];
    
    [objc_getClass("__NSCFConstantString") jr_swizzleMethod:@selector(characterAtIndex:) withMethod:@selector(WT_safeCharacterAtIndex:) error:&error];
    [WTSafeGuard logSafeMethodErrorThenSetNil:&error];
    
    [objc_getClass("__NSCFString") jr_swizzleMethod:@selector(characterAtIndex:) withMethod:@selector(WT_safeCharacterAtIndex:) error:&error];
    [WTSafeGuard logSafeMethodErrorThenSetNil:&error];
    
    [objc_getClass("__NSCFConstantString") jr_swizzleMethod:@selector(getCharacters:range:) withMethod:@selector(WT_safeGetCharacters:range:) error:&error];
    [WTSafeGuard logSafeMethodErrorThenSetNil:&error];
    
    [objc_getClass("__NSCFString") jr_swizzleMethod:@selector(getCharacters:range:) withMethod:@selector(WT_safeGetCharacters:range:) error:&error];
    [WTSafeGuard logSafeMethodErrorThenSetNil:&error];
    
    [objc_getClass("__NSCFConstantString") jr_swizzleMethod:@selector(rangeOfCharacterFromSet:options:range:) withMethod:@selector(WT_safeRangeOfCharacterFromSet:options:range:) error:&error];
    [WTSafeGuard logSafeMethodErrorThenSetNil:&error];
    
    [objc_getClass("__NSCFString") jr_swizzleMethod:@selector(rangeOfCharacterFromSet:options:range:) withMethod:@selector(WT_safeRangeOfCharacterFromSet:options:range:) error:&error];
    [WTSafeGuard logSafeMethodErrorThenSetNil:&error];
    
    [objc_getClass("__NSCFConstantString") jr_swizzleMethod:@selector(rangeOfString:options:range:locale:) withMethod:@selector(WT_safeRangeOfString:options:range:locale:) error:&error];
    [WTSafeGuard logSafeMethodErrorThenSetNil:&error];
    
    [objc_getClass("__NSCFString") jr_swizzleMethod:@selector(rangeOfString:options:range:locale:) withMethod:@selector(WT_safeRangeOfString:options:range:locale:) error:&error];
    [WTSafeGuard logSafeMethodErrorThenSetNil:&error];
    
    [objc_getClass("__NSCFConstantString") jr_swizzleMethod:@selector(substringFromIndex:) withMethod:@selector(WT_safeSubstringFromIndex:) error:&error];
    [WTSafeGuard logSafeMethodErrorThenSetNil:&error];
    
    [objc_getClass("__NSCFString") jr_swizzleMethod:@selector(substringFromIndex:) withMethod:@selector(WT_safeSubstringFromIndex:) error:&error];
    [WTSafeGuard logSafeMethodErrorThenSetNil:&error];
    
    [objc_getClass("__NSCFConstantString") jr_swizzleMethod:@selector(substringWithRange:) withMethod:@selector(WT_safeSubstringWithRange:) error:&error];
    [WTSafeGuard logSafeMethodErrorThenSetNil:&error];
    
    [objc_getClass("__NSCFString") jr_swizzleMethod:@selector(substringWithRange:) withMethod:@selector(WT_safeSubstringWithRange:) error:&error];
    [WTSafeGuard logSafeMethodErrorThenSetNil:&error];
    
    [objc_getClass("__NSCFConstantString") jr_swizzleMethod:@selector(substringToIndex:) withMethod:@selector(WT_safeSubstringToIndex:) error:&error];
    [WTSafeGuard logSafeMethodErrorThenSetNil:&error];
    
    [objc_getClass("__NSCFString") jr_swizzleMethod:@selector(substringToIndex:) withMethod:@selector(WT_safeSubstringToIndex:) error:&error];
    [WTSafeGuard logSafeMethodErrorThenSetNil:&error];
    
    [objc_getClass("__NSCFConstantString") jr_swizzleMethod:@selector(getLineStart:end:contentsEnd:forRange:) withMethod:@selector(WT_safeGetLineStart:end:contentsEnd:forRange:) error:&error];
    [WTSafeGuard logSafeMethodErrorThenSetNil:&error];
    
    [objc_getClass("__NSCFString") jr_swizzleMethod:@selector(getLineStart:end:contentsEnd:forRange:) withMethod:@selector(WT_safeGetLineStart:end:contentsEnd:forRange:) error:&error];
    [WTSafeGuard logSafeMethodErrorThenSetNil:&error];
}

#pragma mark - Class Private Function

+ (instancetype)WT_safeStringWithUTF8String:(const char *)bytes
{
    if (!bytes) {
        [WTSafeGuard updateGuardCrashClassName:NSStringFromClass(self.class) selector:NSStringFromSelector(_cmd)];
        return nil;
    }
    
    return [self WT_safeStringWithUTF8String:bytes];
}

#pragma mark - Object Private Function

- (instancetype)WT_safeInitWithString:(NSString *)aString
{
    if (!aString || ![aString isKindOfClass:[NSString class]]) {
        [WTSafeGuard updateGuardCrashClassName:NSStringFromClass(self.class) selector:NSStringFromSelector(_cmd)];
        return nil;
    }
    
    return [self WT_safeInitWithString:aString];
}

- (instancetype)WT_safeInitWithUTF8String:(const char *)nullTerminatedCString
{
    if (!nullTerminatedCString) {
        [WTSafeGuard updateGuardCrashClassName:NSStringFromClass(self.class) selector:NSStringFromSelector(_cmd)];
        return nil;
    }
    
    return [self WT_safeInitWithUTF8String:nullTerminatedCString];
}

- (instancetype)WT_safeInitWithFormat:(NSString *)format locale:(id)locale arguments:(va_list)argList
{
    if (!format || ![format isKindOfClass:[NSString class]]) {
        [WTSafeGuard updateGuardCrashClassName:NSStringFromClass(self.class) selector:NSStringFromSelector(_cmd)];
        return nil;
    }
    
    return [self WT_safeInitWithFormat:format locale:locale arguments:argList];
}

- (NSString *)WT_safeStringByAppendingString:(NSString *)aString
{
    if (!aString || ![aString isKindOfClass:[NSString class]]) {
        [WTSafeGuard updateGuardCrashClassName:NSStringFromClass(self.class) selector:NSStringFromSelector(_cmd)];
        return nil;
    }
    
    return [self WT_safeStringByAppendingString:aString];
}

- (unichar)WT_safeCharacterAtIndex:(NSUInteger)index
{
    if (index > self.length) {
        [WTSafeGuard updateGuardCrashClassName:NSStringFromClass(self.class) selector:NSStringFromSelector(_cmd)];
        return USHRT_MAX;
    }
    
    return [self WT_safeCharacterAtIndex:index];
}

- (void)WT_safeGetCharacters:(unichar *)buffer range:(NSRange)range
{
    if (!buffer) {
        [WTSafeGuard updateGuardCrashClassName:NSStringFromClass(self.class) selector:NSStringFromSelector(_cmd)];
        return;
    }
    
    if (range.location > self.length || range.location + range.length > self.length) {
        [WTSafeGuard updateGuardCrashClassName:NSStringFromClass(self.class) selector:NSStringFromSelector(_cmd)];
        return;
    }
    
    return [self WT_safeGetCharacters:buffer range:range];
}

- (NSRange)WT_safeRangeOfCharacterFromSet:(NSCharacterSet *)searchSet
                                  options:(NSStringCompareOptions)mask
                                    range:(NSRange)searchRange
{
    if (!searchSet || ![searchSet isKindOfClass:[NSCharacterSet class]]) {
        [WTSafeGuard updateGuardCrashClassName:NSStringFromClass(self.class) selector:NSStringFromSelector(_cmd)];
        return NSMakeRange(NSNotFound, 0);
    }
    
    if (searchRange.location > self.length || searchRange.location + searchRange.length > self.length) {
        [WTSafeGuard updateGuardCrashClassName:NSStringFromClass(self.class) selector:NSStringFromSelector(_cmd)];
        return NSMakeRange(NSNotFound, 0);
    }
    
    return [self WT_safeRangeOfCharacterFromSet:searchSet options:mask range:searchRange];
}

- (NSRange)WT_safeRangeOfString:(NSString *)searchString
                        options:(NSStringCompareOptions)mask
                          range:(NSRange)searchRange
                         locale:(NSLocale *)locale
{
    if (!searchString || ![searchString isKindOfClass:[NSString class]]) {
        [WTSafeGuard updateGuardCrashClassName:NSStringFromClass(self.class) selector:NSStringFromSelector(_cmd)];
        return NSMakeRange(NSNotFound, 0);
    }
    
    if (searchRange.location > self.length || searchRange.location + searchRange.length > self.length) {
        [WTSafeGuard updateGuardCrashClassName:NSStringFromClass(self.class) selector:NSStringFromSelector(_cmd)];
        return NSMakeRange(NSNotFound, 0);
    }
    
    return [self WT_safeRangeOfString:searchString options:mask range:searchRange locale:locale];
}

- (NSString *)WT_safeSubstringFromIndex:(NSUInteger)from
{
    if (from > self.length) {
        [WTSafeGuard updateGuardCrashClassName:NSStringFromClass(self.class) selector:NSStringFromSelector(_cmd)];
        return nil;
    }
    
    return [self WT_safeSubstringFromIndex:from];
}

- (NSString *)WT_safeSubstringWithRange:(NSRange)range
{
    if (range.location > self.length || range.location + range.length > self.length) {
        [WTSafeGuard updateGuardCrashClassName:NSStringFromClass(self.class) selector:NSStringFromSelector(_cmd)];
        return nil;
    }
    
    return [self WT_safeSubstringWithRange:range];
}

- (NSString *)WT_safeSubstringToIndex:(NSUInteger)to
{
    if (to > self.length) {
        [WTSafeGuard updateGuardCrashClassName:NSStringFromClass(self.class) selector:NSStringFromSelector(_cmd)];
        return nil;
    }
    
    return [self WT_safeSubstringToIndex:to];
}

- (void)WT_safeGetLineStart:(NSUInteger *)startPtr
                        end:(NSUInteger *)lineEndPtr
                contentsEnd:(NSUInteger *)contentsEndPtr
                   forRange:(NSRange)range
{
    if (range.location > self.length || range.location + range.length > self.length) {
        [WTSafeGuard updateGuardCrashClassName:NSStringFromClass(self.class) selector:NSStringFromSelector(_cmd)];
        return;
    }
    
    return [self WT_safeGetLineStart:startPtr
                                 end:lineEndPtr
                         contentsEnd:contentsEndPtr
                            forRange:range];
}
@end
