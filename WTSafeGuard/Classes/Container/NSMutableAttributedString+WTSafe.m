//
//  NSMutableAttributedString+WTSafe.m
//  Pods
//
//  Created by hongru qi on 2017/6/23.
//
//

#import "NSMutableAttributedString+WTSafe.h"
#import "WTSafeGuard.h"
#import <objc/runtime.h>
#import "JRSwizzle.h"

@implementation NSMutableAttributedString (WTSafe)

#pragma mark - Class Public Function

+ (void)runSafeGuard
{
    NSError *error = nil;
    
    [NSMutableAttributedString jr_swizzleMethod:@selector(fixAttributesInRange:) withMethod:@selector(WT_safeFixAttributesInRange:) error:&error];
    [WTSafeGuard logSafeMethodErrorThenSetNil:&error];
}

#pragma mark - Object Private Function

- (void)WT_safeFixAttributesInRange:(NSRange)range
{
    if (range.location > self.length || range.location + range.length > self.length) {
        NSAssert(false , @"WT_safeFixAttributesInRange crash");
        return;
    }
    
    return [self WT_safeFixAttributesInRange:range];
}
@end
