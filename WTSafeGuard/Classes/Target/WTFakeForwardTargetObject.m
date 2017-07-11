//
//  WTFakeForwardTargetObject.m
//  Pods
//
//  Created by hongru qi on 2017/6/12.
//
//

#import "WTFakeForwardTargetObject.h"
#import <objc/runtime.h>

id fakeIMP(id sender,SEL sel,...){
    return nil;
}

@implementation WTFakeForwardTargetObject

- (instancetype)initWithSelector:(SEL)aSelector
{
    if (self = [super init]) {
        if(class_addMethod([self class], aSelector, (IMP)fakeIMP, NULL)) {
#ifdef DEBUG
            NSLog(@"add Fake Selector:[instance %@]", NSStringFromSelector(aSelector));
#endif
            NSAssert(false, @"initWithSelector failed");
        }
    }
    
    return self;
}

@end
