// DGAuthentication.h
//
// Copyright (c) 2017 Maxime Epain
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

#import "DGEndpoint.h"
#import "DGIdentity.h"

NS_ASSUME_NONNULL_BEGIN

/**
 The OAuth callback used in the prepared authorization view of [DGAuthentication authenticateWithPreparedAuthorizationViewHandler:success:failure:].
 */
extern NSString * const DGCallback /* discogsapi://success */;

@class UIWebView;

/**
 Authentification class to manage the Discogs authentification process.
 A successful authentication will store the oauth_token and oauth_token_secret credentials into Apple keychain.
 Next queries will contains these two tokens in their 'Authorization' header.
 */
@interface DGAuthentication : DGEndpoint

/**
 Gets authentified user identity.
 
 @param success A block object to be executed when the get operation finishes successfully. This block has no return value and one argument: the user identity.
 @param failure A block object to be executed when the synchronization operation finishes unsuccessfully. This block has no return value and takes one argument: The `NSError` object describing the error that occurred.
 */
- (void)identityWithSuccess:(void (^)(DGIdentity *identity))success failure:(nullable DGFailureBlock)failure;

/**
 Initiates an authenticate process.
 Register your application to launch from a custom URL scheme, and use that with the path /success as your callback URL. The callback for the custom URL scheme should call the `openURL:` method, which will complete the OAuth transaction.
 
 Here's how to respond to the custom URL scheme on iOS:
 
 ```
    - (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options {
        return [Discogs.api.authentication openURL:url])
    }
 ```
 
 @param callback The callback for the custom URL scheme.
 @param success  A block object to be executed when the authenticate operation finishes successfully. This block has no return value and no argument.
 @param failure A block object to be executed when the authenticate operation finishes unsuccessfully. This block has no return value and takes one argument: The `NSError` object describing the error that occurred.
 */
- (void)authenticateWithCallback:(NSURL *)callback success:(void (^)(DGIdentity *identity))success failure:(nullable DGFailureBlock)failure;

/**
 Call this method from the [UIApplicationDelegate application:openURL:options:] method of the AppDelegate for your app. It should be invoked for the proper processing of responses during interaction with Safari as part of the authentication flow.

 @param url The URL as passed to [UIApplicationDelegate application:openURL:options:] .
 @return Returns: YES if the url was intended for the Discogs authentication, NO if not.
 */
- (BOOL)openURL:(NSURL *)url;

/**
 Initiate an authenticate process.
 
 @param authView A block object to be executed when the authenticate operation ask for user authorization. This block has no return value and one argument: The prepared `UIWebView` object that can be shown to the user for authorization.
 @param success  A block object to be executed when the authenticate operation finishes successfully. This block has no return value and no argument.
 @param failure  A block object to be executed when the authenticate operation finishes unsuccessfully. This block has no return value and takes one argument: The `NSError` object describing the error that occurred.
 */
- (void)authenticateWithPreparedAuthorizationViewHandler:(void (^)(UIWebView *authView))authView success:(void (^)(DGIdentity *identity))success failure:(nullable DGFailureBlock)failure;

/**
 Logs out the current identity and nilify access token.
 */
- (void)logout;

@end

NS_ASSUME_NONNULL_END
