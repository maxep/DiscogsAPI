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

#import "DGTokenStore.h"
#import "DGAuthView.h"

#import "DGIdentity+Mapping.h"

static NSString * const kDiscogsConsumerKey    = @"DiscogsConsumerKey";
static NSString * const kDiscogsConsumerSecret = @"DiscogsConsumerSecret";
static NSString * const kDiscogsAccessToken    = @"DiscogsAccessToken";

NSString * const DGApplicationLaunchedWithURLNotification = @"kAFApplicationLaunchedWithURLNotification";
NSString * const DGApplicationLaunchOptionsURLKey = @"UIApplicationLaunchOptionsURLKey";
NSString * const DGCallback = @"discogsapi://success";

static NSString * const kDGOAuth1CredentialDiscogsAccount = @"DGOAuthCredentialDiscogsAccount";

@interface DGAuthentication ()
@property (nonatomic,strong) NSString *consumerKey;
@property (nonatomic,strong) NSString *consumerSecret;
@property (nonatomic,strong) NSString *accessToken;
@end

@implementation DGAuthentication {
    DGHTTPClient *_HTTPClient;
}

- (void)configureManager:(RKObjectManager *)objectManager {
    
    self.consumerKey    = [[NSBundle mainBundle] objectForInfoDictionaryKey:kDiscogsConsumerKey];
    self.consumerSecret = [[NSBundle mainBundle] objectForInfoDictionaryKey:kDiscogsConsumerSecret];
    self.accessToken    = [[NSBundle mainBundle] objectForInfoDictionaryKey:kDiscogsAccessToken];
    
    objectManager.HTTPClient = self.HTTPClient;
    
    //User Identity
    [objectManager.router.routeSet addRoute:[RKRoute routeWithClass:[DGIdentity class] pathPattern:@"oauth/identity" method:RKRequestMethodGET]];
}

- (void)identityWithSuccess:(void (^)(DGIdentity *identity))success failure:(void (^)(NSError *error))failure {
    DGIdentity *identity = [DGIdentity new];
    
    DGOperation *operation = [self.manager operationWithRequest:identity method:RKRequestMethodGET responseClass:[DGIdentity class]];
    [operation setCompletionBlockWithSuccess:success failure:failure];
    
    [self.manager enqueueObjectRequestOperation:operation];
}

- (void)authenticateWithCallback:(NSURL *)callback success:(void (^)())success failure:(void (^)(NSError *error))failure {
    
    if (self.isReachable) {
        
        [self identityWithSuccess:^(DGIdentity * _Nonnull identity) {
            success();
        } failure:^(NSError *error) {
            
       //     if (error.code == 401) {
            if (error.code == -1011) {
                [self removeAccountCredential];
            }
            
            [self.HTTPClient authorizeUsingOAuthWithCallbackURL:callback success:^(AFOAuth1Token *accessToken, id responseObject) {
                [DGTokenStore storeCredential:accessToken withIdentifier:kDGOAuth1CredentialDiscogsAccount];
                success();
            } failure:^(NSError *error) {
                failure(error);
            }];
            
        }];
    } else if (self.HTTPClient.accessToken) {
        success();
    } else if (failure) {
        failure([self errorWithCode:NSURLErrorNotConnectedToInternet info:@"User not athenticated yet but no internet connection"]);
    }
}

- (void)authenticateWithPreparedAuthorizationViewHandler:(void (^)(UIWebView *authView))authView success:(void (^)())success failure:(void (^)(NSError *error))failure {
    
    NSURL *callback = [NSURL URLWithString:DGCallback];
    
    [self.HTTPClient setServiceProviderRequestHandler:^(NSURLRequest *request) {
        DGAuthView *view = [DGAuthView viewWithRequest:request];
        authView(view);
    } completion:nil];
    
    [self authenticateWithCallback:callback success:success failure:failure];
}

- (void)removeAccountCredential {
    [DGTokenStore deleteCredentialWithIdentifier:kDGOAuth1CredentialDiscogsAccount];
    self.HTTPClient.accessToken = nil;
}

#pragma mark Properties

- (DGHTTPClient *)HTTPClient {
    
    if (!_HTTPClient) {
        if (self.consumerKey && self.consumerSecret) {
            _HTTPClient = [DGHTTPClient clientWithConsumerKey:self.consumerKey
                                               consumerSecret:self.consumerSecret];
        } else if(self.accessToken) {
            _HTTPClient = [DGHTTPClient clientWithAccessToken:self.accessToken];
        } else {
            _HTTPClient = [DGHTTPClient client];
        }
        
        _HTTPClient.signatureMethod = AFPlainTextSignatureMethod;
        _HTTPClient.accessToken = [DGTokenStore retrieveCredentialWithIdentifier:kDGOAuth1CredentialDiscogsAccount];
    }
    return _HTTPClient;
}

@end
