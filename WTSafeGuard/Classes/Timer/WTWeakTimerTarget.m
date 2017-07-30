//
//  WTWeakTimerTarget.m
//  Pods
//
//  Created by walter on 30/07/2017.
//
//

#import "WTWeakTimerTarget.h"

@implementation WTWeakTimerTarget

- (void)timeSelector:(NSTimer *)timer
{
    if(self.target) {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
        [self.target performSelector:self.selector withObject:timer.userInfo afterDelay:0.0f];
#pragma clang diagnostic pop
    } else {
        [self.timer invalidate];
    }
}

@end
