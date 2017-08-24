//
//  NSObject+WTSafe.h
//  Pods
//
//  Created by hongru qi on 2017/6/12.
//
//

#import <Foundation/Foundation.h>

@interface NSObject (WTSafe)

+ (void)runSafeGuard;
+ (void)runSafeGuardKVO;
@end
