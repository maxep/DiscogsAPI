// DGAuthentication.h
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

#import <Foundation/Foundation.h>
#import "DGHTTPClient.h"
#import "DGEndpoint.h"

/**
 Authentification class to manage the Discogs authentification process.
 A successful authentication will store the oauth_token and oauth_token_secret credentials into Apple keychain.
 Next queries will contains these two tokens in their 'Authorization' header.
 */
@interface DGAuthentication : DGEndpoint

/**
 The HTTP client with authorized header.
 */
@property (nonatomic, readonly) DGHTTPClient *HTTPClient;

/**
 Creates and initializes a `DGAuthentication` object.
 
 @return The newly-initialized Authentication object.
 */
+ (DGAuthentication*) authentication;

/**
 Initiates an authenticate process.
 Register your application to launch from a custom URL scheme, and use that with the path /success as your callback URL. The callback for the custom URL scheme should send a notification, which will complete the OAuth transaction.
 
 Here's how to respond to the custom URL scheme on iOS:
 
 - (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
 NSNotification *notification = [NSNotification notificationWithName:kAFApplicationLaunchedWithURLNotification object:nil userInfo:@{kAFApplicationLaunchOptionsURLKey: url}];
 [[NSNotificationCenter defaultCenter] postNotification:notification];
 return YES;
 }
 
 @param callback The callback for the custom URL scheme.
 @param success  A block object to be executed when the authenticate operation finishes successfully. This block has no return value and no argument.
 @param failure A block object to be executed when the authenticate operation finishes unsuccessfully. This block has no return value and takes one argument: The `NSError` object describing the error that occurred.
 */
- (void) authenticateWithCallback:(NSURL*) callback success:(void (^)())success failure:(void (^)(NSError* error))failure;

/**
 Initiate an authenticate process.
 
 @param authView A block object to be executed when the authenticate operation ask for user authorization. This block has no return value and one argument: The prepared `UIWebView` object that can be shown to the user for authorization.
 @param success  A block object to be executed when the authenticate operation finishes successfully. This block has no return value and no argument.
 @param failure  A block object to be executed when the authenticate operation finishes unsuccessfully. This block has no return value and takes one argument: The `NSError` object describing the error that occurred.
 */
- (void) authenticateWithPreparedAuthorizationViewHandler:(void (^)(UIView* authView))authView success:(void (^)())success failure:(void (^)(NSError* error))failure;

/**
 Remove Discogs account credential from keychain.
 */
- (void) removeAccountCredential;

@end
