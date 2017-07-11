//
//  WTKVOResource.m
//  Pods
//
//  Created by hongru qi on 2017/6/23.
//
//

#import "WTKVOResource.h"

@implementation WTKVOResource

- (id)initWithResource:(id)resource observer:(id)observer key:(NSString *)key
{
    self = [super init];
    if (self) {
        self.resource = resource;
        self.key = key;
        self.observer = observer;
    }
    return self;
}

@end
