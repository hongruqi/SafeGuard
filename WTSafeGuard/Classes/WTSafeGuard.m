//
//  WTSafeGuard.m
//  Pods
//
//  Created by hongru qi on 2017/6/12.
//
//

#import "WTSafeGuard.h"
#import "WTFakeForwardTargetObject.h"
#import "NSObject+WTSafe.h"
#import "NSDictionary+WTSafe.h"
#import "NSMutableDictionary+WTSafe.h"
#import "NSSet+WTSafe.h"
#import "NSMutableSet+WTSafe.h"
#import "NSString+WTSafe.h"
#import "NSMutableString+WTSafe.h"
#import "NSURL+WTSafe.h"
#import "NSFileManager+WTSafe.h"
#import "NSIndexPath+WTSafe.h"
#import "NSJSONSerialization+WTSafe.h"
#import "NSAttributedString+WTSafe.h"
#import "WTKVOResource.h"
#import "NSTimer+WTSafe.h"

@interface WTSafeGuard ()

@end

@implementation WTSafeGuard

+ (WTSafeGuard *)shareInstance
{
    static dispatch_once_t onceToken;
    static WTSafeGuard *shareInstance;
    
    dispatch_once(&onceToken, ^{
        shareInstance = [[WTSafeGuard alloc] init];
    });
    
    return shareInstance;
}

- (instancetype)init
{
    if (self = [super init]) {
    }
    
    return self;
}

+ (void)startSafeGuardWithType:(WTSafeGuardType)type
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        if (type & WTSafeGuardType_MainThreadUI) {
            [self startGuardMainThread];
        }
        
        if (type & WTSafeGuardType_Foundation){
            [self startGuardFoundation];
        }
        
        if (type & WTSafeGuardType_NilTarget){
            [self startGuardNilTarget];
        }
        
        if (type & WTSafeGuardType_KVO){
            [self startGuardKVO];
        }
        
        if (type & WTSafeGuardType_Timer) {
            [self startGuardTimer];
        }
    });
}

+ (id)createFakeForwardTargetObject:(id)aTarget selector:(SEL)aSelector
{
    if ([[NSString string] respondsToSelector:aSelector]) {
        NSString *szTarget = nil;
        if ([aTarget isKindOfClass:[NSNumber class]]) {
            szTarget = [NSString stringWithFormat:@"%@", aTarget];
        }
        
        if (szTarget) {
            return szTarget;
        }
    }
    
    WTFakeForwardTargetObject *fakeTaget = [[WTFakeForwardTargetObject alloc] initWithSelector:aSelector];
    return fakeTaget;
}

+ (void)startGuardFoundation
{
    [NSDictionary runSafeGuard];
    [NSMutableDictionary runSafeGuard];
    [NSSet runSafeGuard];
    [NSMutableSet runSafeGuard];
    [NSString runSafeGuard];
    [NSMutableString runSafeGuard];
    [NSURL runSafeGuard];
    [NSFileManager runSafeGuard];
    [NSIndexPath runSafeGuard];
    [NSJSONSerialization runSafeGuard];
    [NSAttributedString runSafeGuard];
    [NSMutableAttributedString runSafeGuard];
}

+ (void)startGuardMainThread
{
    [UIView runSafeGuard];
}

+ (void)startGuardNilTarget
{
    [NSObject runSafeGuard];
}

+ (void)startGuardKVO
{
    [NSObject runSafeGuardKVO];
}

+ (void)startGuardTimer
{
    [NSTimer runSafeGuard];
}

+ (BOOL)logSafeMethodErrorThenSetNil:(NSError **)error
{
    if (!error) {
        return YES;
    }
    
    if (*error) {
#ifdef DEBUG
        NSLog(@"%@",(*error).debugDescription);
#endif
        *error = nil;
        return NO;
    }
    
    return YES;
}

+ (void)updateGuardCrashClassName:(NSString *)className selector:(NSString *)selector
{
    NSArray *stack = [NSThread callStackSymbols];
    
    if ([[WTSafeGuard shareInstance].delegate respondsToSelector:@selector(safeGuardCrashMessage:selector:stack:)]) {
        [[WTSafeGuard shareInstance].delegate safeGuardCrashMessage:className selector:selector stack:stack];
    }
    
    NSLog(@"guard crash [%@ : %@], stack %@",className, selector, stack);
}

@end
