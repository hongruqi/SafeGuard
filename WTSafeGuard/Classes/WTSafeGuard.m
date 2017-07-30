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
#import "NSArray+WTSafe.h"
#import "NSMutableArray+WTSafe.h"
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
#import "NSMutableAttributedString+WTSafe.h"
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

+ (void)startSafeGuard
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        // 对象
        [NSObject runSafeGuard];
        
        // 不变数组
        [NSArray runSafeGuard];
        
        // 可变数组
        [NSMutableArray runSafeGuard];
        
        // 不变字典
        [NSDictionary runSafeGuard];
        
        // 可变字典
        [NSMutableDictionary runSafeGuard];
        
        // 不变集合
        [NSSet runSafeGuard];
        
        // 可变集合
        [NSMutableSet runSafeGuard];
        
        // 不变字符串
        [NSString runSafeGuard];
        
        // 可变字符串
        [NSMutableString runSafeGuard];
        
        // URL
        [NSURL runSafeGuard];
        
        // NSFileManager
        [NSFileManager runSafeGuard];
        
        // NSIndexPath
        [NSIndexPath runSafeGuard];
        
        // NSJSONSerialization
        [NSJSONSerialization runSafeGuard];
        
        // NSAttributedString
        [NSAttributedString runSafeGuard];
        
        // NSMutableAttributedString
        [NSMutableAttributedString runSafeGuard];
        
        // NSTimer
        [NSTimer runSafeGuard];
        
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



@end
