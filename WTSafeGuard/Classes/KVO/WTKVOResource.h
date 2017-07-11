//
//  WTKVOResource.h
//  Pods
//
//  Created by hongru qi on 2017/6/23.
//
//

#import <Foundation/Foundation.h>

@interface WTKVOResource : NSObject

@property (nonatomic, strong)id resource;
@property (nonatomic, strong)NSString *key;
@property (nonatomic, weak) id observer;

- (id)initWithResource:(id)resource observer:(id)observer key:(NSString *)key;

@end
