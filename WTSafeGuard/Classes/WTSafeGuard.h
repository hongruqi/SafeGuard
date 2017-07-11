//
//  WTSafeGuard.h
//  Pods
//
//  Created by hongru qi on 2017/6/12.
//
//

#import <Foundation/Foundation.h>
@class WTKVOResource;

@interface WTSafeGuard : NSObject

+ (WTSafeGuard *)shareInstance;

+ (void)startSafeGuard;

+ (id)createFakeForwardTargetObject:(id)aTarget selector:(SEL)aSelector;

+ (BOOL)logSafeMethodErrorThenSetNil:(NSError **)error;

@end
