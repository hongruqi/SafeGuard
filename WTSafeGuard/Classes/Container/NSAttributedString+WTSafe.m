//
//  NSAttributedString+WTSafe.m
//  Pods
//
//  Created by hongru qi on 2017/6/21.
//
//

#import "NSAttributedString+WTSafe.h"
#import <objc/runtime.h>
#import "JRSwizzle.h"
#import "WTSafeGuard.h"

@implementation NSAttributedString (WTSafe)

#pragma mark - Class Public Function

+ (void)runSafeGuard
{
    NSError *error = nil;
    
    [objc_getClass("NSConcreteAttributedString") jr_swizzleMethod:@selector(attributedSubstringFromRange:) withMethod:@selector(WT_safeAttributedSubstringFromRange:) error:&error];
    [WTSafeGuard logSafeMethodErrorThenSetNil:&error];
    
    [objc_getClass("NSConcreteMutableAttributedString") jr_swizzleMethod:@selector(attributedSubstringFromRange:) withMethod:@selector(WT_safeAttributedSubstringFromRange:) error:&error];
    [WTSafeGuard logSafeMethodErrorThenSetNil:&error];
}

#pragma mark - Object Private Function

- (NSAttributedString *)WT_safeAttributedSubstringFromRange:(NSRange)range
{
    if (range.location > self.length || range.location + range.length > self.length) {
        NSAssert(nil, @"WT_safeAttributedSubstringFromRange crash");
        return nil;
    }
    
    return [self WT_safeAttributedSubstringFromRange:range];
}

@end
