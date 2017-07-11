//
//  WTKVOMapManager.m
//  Pods
//
//  Created by hongru qi on 2017/6/26.
//
//

#import "WTKVOMapManager.h"

@interface WTKVOMapManager ()

@property (nonatomic, strong) NSMutableDictionary *kvoMap;
@property (nonatomic, strong) NSLock *kvoMapLock;

@end

@implementation WTKVOMapManager

+ (WTKVOMapManager *)shareInstance
{
    static dispatch_once_t onceToken;
    static WTKVOMapManager *shareInstance;
    
    dispatch_once(&onceToken, ^{
        shareInstance = [[WTKVOMapManager alloc] init];
    });
    
    return shareInstance;
}

- (instancetype)init
{
    if (self = [super init]) {
        _kvoMap = [NSMutableDictionary dictionary];
        _kvoMapLock = [[NSLock alloc] init];
    }
    
    return self;
}

- (BOOL)isMapObserver:(id)observer inkeySource:(id)keySource keyPath:(NSString*)path
{
    NSString *key = [NSString stringWithFormat:@"%@_%p",NSStringFromClass([observer class]),observer];
    [self.kvoMapLock lock];
    id obj = [self.kvoMap objectForKey:key];
    if ([obj isKindOfClass:[NSMutableArray class]]) {
        for (id source in obj) {
            if ([source isKindOfClass:[WTKVOResource class]]) {
                if ([(WTKVOResource*)source resource] == keySource && [(WTKVOResource*)source key] == path) {
                    [self.kvoMapLock unlock];
                    return YES;
                }
            }
        }
    }
    [self.kvoMapLock unlock];
    return NO;
}

- (BOOL)observerRemove:(id)observer inkeySource:(id)keySource keyPath:(NSString*)path
{
    NSString *key = [NSString stringWithFormat:@"%@_%p",NSStringFromClass([observer class]),observer];
    [self.kvoMapLock lock];
    id obj = [self.kvoMap objectForKey:key];
    if ([obj isKindOfClass:[NSMutableArray class]]) {
        for (id source in obj) {
            if ([source isKindOfClass:[WTKVOResource class]]) {
                if ([(WTKVOResource*)source resource] == keySource && [(WTKVOResource*)source key] == path) {
                    [obj removeObject:source];
                    [self.kvoMapLock unlock];
                    return YES;
                }
            }
        }
    }
    [self.kvoMapLock unlock];
    return NO;
}

- (void)removeAllObserver:(id)source
{
    [self.kvoMapLock lock];
    [self.kvoMap enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, NSMutableArray *obj, BOOL * _Nonnull stop) {
        for (id resource in obj) {
            if ([resource isKindOfClass:[WTKVOResource class]]) {
                NSLog(@"%@", [(WTKVOResource*)resource observer]);
                NSLog(@"%@", source);
                if ([(WTKVOResource*)resource observer] == source || [(WTKVOResource*)resource observer] == NULL) {
                    [[(WTKVOResource*)resource resource] removeObserver:source forKeyPath:[(WTKVOResource*)resource key]];
                    *stop = YES;
                }
            }
        }
    }];
    [self.kvoMapLock unlock];
}

- (BOOL)observeValueForKeyPath:(id)observer inkeySource:(id)keySource keyPath:(NSString*)path
{
    NSString *key = [NSString stringWithFormat:@"%@_%p",NSStringFromClass([observer class]),observer];
    [self.kvoMapLock lock];
    id obj = [self.kvoMap objectForKey:key];
    if ([obj isKindOfClass:[NSMutableArray class]]) {
        for (id source in obj) {
            if ([source isKindOfClass:[WTKVOResource class]]) {
                if ([(WTKVOResource*)source resource] == nil && [(WTKVOResource*)source key] == path) {
                    [obj removeObject:source];
                    [self.kvoMapLock unlock];
                    return YES;
                }
            }
        }
    }
    [self.kvoMapLock unlock];
    return NO;
}

- (void)addObserver:(id)observer source:(WTKVOResource *)source
{
    if (nil == observer || nil == source) {
        return;
    }
    
    NSString *key = [NSString stringWithFormat:@"%@_%p",NSStringFromClass([observer class]),observer];
    [self.kvoMapLock lock];
    if ([self.kvoMap objectForKey:key]) {
        id obj = [self.kvoMap objectForKey:key];
        if ([obj isKindOfClass:[NSArray class]]) {
            NSMutableArray *array = [NSMutableArray arrayWithArray:obj];
            if (![array containsObject:source]) {
                [array addObject:source];
                [self.kvoMap setObject:array forKey:key];
            }
        }
    }else{
        NSMutableArray *array = [NSMutableArray array];
        [array addObject:source];
        [self.kvoMap setObject:array forKey:key];
    }
    [self.kvoMapLock unlock];
}

@end
