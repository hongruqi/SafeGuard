//
//  WKWebView+WTSafe.m
//  Pods
//
//  Created by walter on 25/07/2017.
//
//

#import "WKWebView+WTSafe.h"
#import "JRSwizzle.h"
#import "WTSafeGuard.h"

@implementation WKWebView (WTSafe)

+ (void)runSafeGuard
{
    NSError *error = nil;
    [WKWebView jr_swizzleMethod:@selector(loadRequest:) withMethod:@selector(wt_safeLoadRequest:) error:&error];
    [WTSafeGuard logSafeMethodErrorThenSetNil:&error];
    //KVO
    [WKWebView jr_swizzleMethod:@selector(loadFileURL:allowingReadAccessToURL:) withMethod:@selector(wt_safeLoadFileURL:allowingReadAccessToURL:) error:&error];
    [WTSafeGuard logSafeMethodErrorThenSetNil:&error];
    [WKWebView jr_swizzleMethod:@selector(loadHTMLString:baseURL:) withMethod:@selector(wt_safeLoadHTMLString:baseURL:) error:&error];
    [WTSafeGuard logSafeMethodErrorThenSetNil:&error];
    [WKWebView jr_swizzleMethod:@selector(loadData:MIMEType:characterEncodingName:baseURL:) withMethod:@selector(wt_safeLoadData:MIMEType:characterEncodingName:baseURL:) error:&error];
    [WTSafeGuard logSafeMethodErrorThenSetNil:&error];
    [WKWebView jr_swizzleMethod:@selector(goToBackForwardListItem:) withMethod:@selector(wt_safeGoToBackForwardListItem:) error:&error];
    [WTSafeGuard logSafeMethodErrorThenSetNil:&error];
    [WKWebView jr_swizzleMethod:@selector(navigationDelegate) withMethod:@selector(wt_safeGetNavigationDelegate) error:&error];
    [WTSafeGuard logSafeMethodErrorThenSetNil:&error];
    [WKWebView jr_swizzleMethod:@selector(UIDelegate) withMethod:@selector(wt_safeGetUIDelegate) error:&error];
    [WTSafeGuard logSafeMethodErrorThenSetNil:&error];
}

- (id<WKNavigationDelegate>)wt_safeGetNavigationDelegate
{
    if ([UIApplication sharedApplication].applicationState == UIApplicationStateActive){
        return [self wt_safeGetNavigationDelegate];
    }
    
    return nil;
}

- (id<WKUIDelegate>)wt_safeGetUIDelegate
{
    if ([UIApplication sharedApplication].applicationState == UIApplicationStateActive){
        return [self wt_safeGetUIDelegate];
    }
    
    return nil;
}

- (nullable WKNavigation *)wt_safeLoadRequest:(NSURLRequest *)request
{
    if ([UIApplication sharedApplication].applicationState == UIApplicationStateActive){
        return [self wt_safeLoadRequest:request];
    }
    
    return nil;
}

- (nullable WKNavigation *)wt_safeLoadFileURL:(NSURL *)URL allowingReadAccessToURL:(NSURL *)readAccessURL
{
    if ([UIApplication sharedApplication].applicationState == UIApplicationStateActive){
        return [self wt_safeLoadFileURL:URL allowingReadAccessToURL:readAccessURL];
    }
    
    return nil;
}

- (nullable WKNavigation *)wt_safeLoadHTMLString:(NSString *)string baseURL:(nullable NSURL *)baseURL
{
    if ([UIApplication sharedApplication].applicationState == UIApplicationStateActive){
        return [self wt_safeLoadHTMLString:string baseURL:baseURL];
    }
    
    return nil;
}

- (nullable WKNavigation *)wt_safeLoadData:(NSData *)data MIMEType:(NSString *)MIMEType characterEncodingName:(NSString *)characterEncodingName baseURL:(NSURL *)baseURL
{
    if ([UIApplication sharedApplication].applicationState == UIApplicationStateActive){
        return [self wt_safeLoadData:data MIMEType:MIMEType characterEncodingName:characterEncodingName baseURL:baseURL];
    }
    
    return nil;
}

- (nullable WKNavigation *)wt_safeGoToBackForwardListItem:(WKBackForwardListItem *)item
{
    if ([UIApplication sharedApplication].applicationState == UIApplicationStateActive){
        return [self wt_safeGoToBackForwardListItem:item];
    }
    
    return nil;
}

@end
