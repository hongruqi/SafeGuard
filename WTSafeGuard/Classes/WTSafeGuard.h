//
//  WTSafeGuard.h
//  Pods
//
//  Created by hongru qi on 2017/6/12.
//
//

#import <Foundation/Foundation.h>
@class WTKVOResource;

@protocol WTSafeGuardDelegate<NSObject>

- (void)safeGuardCrashMessage:(NSString *)className selector:(NSString *)selector stack:(NSArray *)stack;

@end

typedef NS_OPTIONS(NSUInteger, WTSafeGuardType) {
    WTSafeGuardTypeNone                 = 0,
    WTSafeGuardType_MainThreadUI        = 1 << 0,
    WTSafeGuardType_Foundation          = 1 << 1,
    WTSafeGuardType_NilTarget           = 1 << 2,
    WTSafeGuardType_KVO                 = 1 << 3,
    WTSafeGuardType_Timer               = 1 << 4
};

@interface WTSafeGuard : NSObject

@property (nonatomic, weak) id<WTSafeGuardDelegate> delegate;

+ (WTSafeGuard *)shareInstance;

+ (void)startSafeGuardWithType:(WTSafeGuardType)type;

+ (id)createFakeForwardTargetObject:(id)aTarget selector:(SEL)aSelector;

+ (BOOL)logSafeMethodErrorThenSetNil:(NSError **)error;

+ (void)updateGuardCrashClassName:(NSString *)className selector:(NSString *)selector;

@end
