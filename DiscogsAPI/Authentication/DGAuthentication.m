// DGAuthentication.m
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

#import "DGEndpoint+Configuration.h"
#import "DGAuthentication.h"
#import "DGHTTPClient.h"

#import "DGAuthView.h"

#import "DGTokenStore.h"
#import "DGIdentity+Keychain.h"
#import "DGIdentity+Mapping.h"

static NSString * const kDiscogsConsumerKey    = @"DiscogsConsumerKey";
static NSString * const kDiscogsConsumerSecret = @"DiscogsConsumerSecret";
static NSString * const kDiscogsAccessToken    = @"DiscogsAccessToken";

NSString * const DGCallback = @"discogsapi://success";

static NSString * const kDGOAuth1CredentialDiscogsAccount = @"DGOAuthCredentialDiscogsAccount";

@interface DGAuthentication ()
@property (nonatomic, strong) DGHTTPClient *HTTPClient;
@property (nonatomic, strong) NSString *consumerKey;
@property (nonatomic, strong) NSString *consumerSecret;
@property (nonatomic, strong) NSString *accessToken;
@end

@implementation DGAuthentication {
    NSString *_callback;
}

- (void)configureManager:(RKObjectManager *)manager {
    
    self.consumerKey    = [[NSBundle mainBundle] objectForInfoDictionaryKey:kDiscogsConsumerKey];
    self.consumerSecret = [[NSBundle mainBundle] objectForInfoDictionaryKey:kDiscogsConsumerSecret];
    self.accessToken    = [[NSBundle mainBundle] objectForInfoDictionaryKey:kDiscogsAccessToken];
    
    manager.HTTPClient = self.HTTPClient;
    
    //User Identity
    [manager.router.routeSet addRoute:[RKRoute routeWithClass:[DGIdentity class] pathPattern:@"oauth/identity" method:RKRequestMethodGET]];
}

- (void)identityWithSuccess:(void (^)(DGIdentity *identity))success failure:(void (^)(NSError *error))failure {
    DGIdentity *identity = [DGIdentity new];
    
    DGOperation<DGIdentity *> *operation = [self.manager operationWithRequest:identity method:RKRequestMethodGET responseClass:[DGIdentity class]];
    [operation setCompletionBlockWithSuccess:^(DGIdentity * _Nonnull response) {
        
        response.token = self.HTTPClient.accessToken.key;
        response.secret = self.HTTPClient.accessToken.secret;
        [DGIdentity storeIdentity:response withIdentifier:kDGIdentityCurrentIdentifier];
        success(response);
        
    } failure:failure];
    
    [self.queue addOperation:operation];
}

- (void)authenticateWithCallback:(NSURL *)callback success:(void (^)(DGIdentity *identity))success failure:(void (^)(NSError *error))failure {
    
    if (self.isReachable) {
        
        [self identityWithSuccess:success failure:^(NSError *error) {
            
            if (error.code == 401) {
                
                _callback = callback.absoluteString;
                
                [self.HTTPClient authorizeUsingOAuthWithCallbackURL:callback success:^(AFOAuth1Token *accessToken, id responseObject) {
                    [self identityWithSuccess:success failure:failure];
                } failure:failure];
                
            } else if (failure) {
                failure(error);
            }
            
        }];
        
    } else if ([DGIdentity current]) {
        success([DGIdentity current]);
    } else if (self.HTTPClient.accessToken) {
        success(nil);
    } else if (failure) {
        failure([NSError errorWithCode:NSURLErrorNotConnectedToInternet description:@"User not athenticated yet but no internet connection"]);
    }
}

- (BOOL)openURL:(NSURL *)url {

    if (_callback && [url.absoluteString hasPrefix:_callback]) {
        NSNotification *notification = [NSNotification notificationWithName:kAFApplicationLaunchedWithURLNotification object:nil userInfo:@{kAFApplicationLaunchOptionsURLKey: url}];
        [[NSNotificationCenter defaultCenter] postNotification:notification];
        
        _callback = nil;
        return YES;
    }
    return NO;
}

- (void)authenticateWithPreparedAuthorizationViewHandler:(void (^)(UIWebView *authView))authView success:(void (^)(DGIdentity *identity))success failure:(void (^)(NSError *error))failure {
    
    [self.HTTPClient setServiceProviderRequestHandler:^(NSURLRequest *request) {
        DGAuthView *view = [DGAuthView viewWithRequest:request];
        authView(view);
    } completion:nil];
    
    NSURL *callback = [NSURL URLWithString:DGCallback];
    [self authenticateWithCallback:callback success:success failure:failure];
}

#pragma mark Properties

- (DGHTTPClient *)HTTPClient {
    
    if (!_HTTPClient) {
        if (self.consumerKey && self.consumerSecret) {
            _HTTPClient = [DGHTTPClient clientWithConsumerKey:self.consumerKey consumerSecret:self.consumerSecret];
        } else if(self.accessToken) {
            _HTTPClient = [DGHTTPClient clientWithAccessToken:self.accessToken];
        } else {
            _HTTPClient = [DGHTTPClient new];
        }
        
        DGIdentity *identity = [DGIdentity current];
        if (identity) {
            _HTTPClient.accessToken = [[AFOAuth1Token alloc] initWithKey:identity.token secret:identity.secret session:nil expiration:nil renewable:NO];
        } else {
            _HTTPClient.accessToken = [DGTokenStore retrieveCredentialWithIdentifier:kDGOAuth1CredentialDiscogsAccount];
        }
        
        _HTTPClient.signatureMethod = AFPlainTextSignatureMethod;
    }
    return _HTTPClient;
}

@end
