//
//  NSTimer+WTSafe.m
//  Pods
//
//  Created by walter on 30/07/2017.
//
//

#import "NSTimer+WTSafe.h"
#import "WTSafeGuard.h"
#import "JRSwizzle.h"
#import "WTWeakTimerTarget.h"

@implementation NSTimer (WTSafe)

+ (void)runSafeGuard
{
    NSError *error = nil;
    [NSTimer jr_swizzleMethod:@selector(scheduledTimerWithTimeInterval:target:selector:userInfo:repeats:) withMethod:@selector(WT_safeScheduledTimerWithTimeInterval:target:selector:userInfo:repeats:) error:&error];
    [WTSafeGuard logSafeMethodErrorThenSetNil:&error];

}

+ (NSTimer *)WT_safeScheduledTimerWithTimeInterval:(NSTimeInterval)ti
                                            target:(id)aTarget
                                          selector:(SEL)aSelector
                                          userInfo:(nullable id)userInfo
                                           repeats:(BOOL)yesOrNo
{
    WTWeakTimerTarget *weakTarget = [[WTWeakTimerTarget alloc] init];
    weakTarget.target = aTarget;
    weakTarget.selector = aSelector;
    weakTarget.timer = [self WT_safeScheduledTimerWithTimeInterval:ti target:weakTarget selector:@selector(timeSelector:) userInfo:userInfo repeats:yesOrNo];
    return weakTarget.timer;
}

@end
