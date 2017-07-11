//
//  WTKVOMapManager.h
//  Pods
//
//  Created by hongru qi on 2017/6/26.
//
//

#import <Foundation/Foundation.h>
#import "WTKVOResource.h"

@interface WTKVOMapManager : NSObject

+ (WTKVOMapManager *)shareInstance;

- (BOOL)isMapObserver:(id)observer inkeySource:(id)keySource keyPath:(NSString*)path;

- (BOOL)observerRemove:(id)observer inkeySource:(id)keySource keyPath:(NSString*)path;

- (void)addObserver:(id)observer source:(WTKVOResource *)source;

- (BOOL)observeValueForKeyPath:(id)observer inkeySource:(id)keySource keyPath:(NSString*)path;

- (void)removeAllObserver:(id)source;

@end
