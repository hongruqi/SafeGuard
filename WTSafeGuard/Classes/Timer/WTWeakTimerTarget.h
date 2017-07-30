//
//  WTWeakTimerTarget.h
//  Pods
//
//  Created by walter on 30/07/2017.
//
//

#import <Foundation/Foundation.h>

@interface WTWeakTimerTarget : NSObject

@property (nonatomic, weak) id target;
@property (nonatomic, assign) SEL selector;
@property (nonatomic, weak) NSTimer* timer;

- (void)timeSelector:(NSTimer *)timer;

@end
