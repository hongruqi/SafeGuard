//
//  UIPasteboard+WTSafe.m
//  WTSafeGuard
//
//  Created by hongru qi on 26/09/2017.
//

#import "UIPasteboard+WTSafe.h"
#import "JRSwizzle.h"
#import <objc/runtime.h>
#import "WTSafeGuard.h"

@implementation UIPasteboard (WTSafe)

+ (void)runSafeGuard
{
    NSError *error = nil;
    [UIPasteboard jr_swizzleMethod:@selector(pasteboardWithName: create:) withMethod:@selector(wt_pasteboardWithName: create:) error:&error];
}

+ (nullable UIPasteboard *)wt_pasteboardWithName:(UIPasteboardName)pasteboardName create:(BOOL)create
{
    if (strcmp(dispatch_queue_get_label(DISPATCH_CURRENT_QUEUE_LABEL), dispatch_queue_get_label(dispatch_get_main_queue())) == 0) {
        return [self wt_pasteboardWithName:pasteboardName create:create];
    } else {
        __block UIPasteboard *board;
        dispatch_sync(dispatch_get_main_queue(), ^{
            board = [self wt_pasteboardWithName:pasteboardName create:create];
        });
        
        return board;
    }
}

@end
