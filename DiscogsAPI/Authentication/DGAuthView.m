// DGAuthView.m
//
// Copyright (c) 2016 Maxime Epain
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

#import "DGAuthView.h"
#import "AFOAuth1Client.h"

extern NSString * const DGCallback;
extern NSString * const DGApplicationLaunchedWithURLNotification;
extern NSString * const DGApplicationLaunchOptionsURLKey;

@implementation DGAuthView

+ (DGAuthView*) viewWithRequest:(NSURLRequest*) request {
    return [[DGAuthView alloc] initWithRequest:request];
}

- (id)initWithRequest:(NSURLRequest*) request {
    if (self = [super init]) {
        self.delegate = self;
        self.opaque = NO;
        [self loadRequest:request];
    }
    return self;
}

- (void)loadRequest:(NSURLRequest *)request {
    // Enable cookies
    [NSHTTPCookieStorage sharedHTTPCookieStorage].cookieAcceptPolicy = NSHTTPCookieAcceptPolicyAlways;
    NSMutableURLRequest * mutableRequest = [request mutableCopy];
    [mutableRequest setHTTPShouldHandleCookies:YES];
    
    [super loadRequest:mutableRequest];
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    
    if( [request.URL.absoluteString hasPrefix:DGCallback]) {
        NSNotification *notification = [NSNotification notificationWithName:DGApplicationLaunchedWithURLNotification object:nil userInfo:@{DGApplicationLaunchOptionsURLKey: [request URL]}];
        [[NSNotificationCenter defaultCenter] postNotification:notification];
        return NO;
    }
    return YES;
}

@end
