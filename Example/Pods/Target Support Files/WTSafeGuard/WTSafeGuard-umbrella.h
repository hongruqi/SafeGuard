#ifdef __OBJC__
#import <UIKit/UIKit.h>
#else
#ifndef FOUNDATION_EXPORT
#if defined(__cplusplus)
#define FOUNDATION_EXPORT extern "C"
#else
#define FOUNDATION_EXPORT extern
#endif
#endif
#endif

#import "NSAttributedString+WTSafe.h"
#import "NSDictionary+WTSafe.h"
#import "NSFileManager+WTSafe.h"
#import "NSIndexPath+WTSafe.h"
#import "NSJSONSerialization+WTSafe.h"
#import "NSMutableDictionary+WTSafe.h"
#import "NSMutableSet+WTSafe.h"
#import "NSMutableString+WTSafe.h"
#import "NSSet+WTSafe.h"
#import "NSString+WTSafe.h"
#import "NSURL+WTSafe.h"
#import "WTKVOMapManager.h"
#import "WTKVOResource.h"
#import "NSObject+WTSafe.h"
#import "WTFakeForwardTargetObject.h"
#import "NSTimer+WTSafe.h"
#import "WTWeakTimerTarget.h"
#import "UIPasteboard+WTSafe.h"
#import "UIView+WTSafe.h"
#import "WTSafeGuard.h"

FOUNDATION_EXPORT double WTSafeGuardVersionNumber;
FOUNDATION_EXPORT const unsigned char WTSafeGuardVersionString[];

