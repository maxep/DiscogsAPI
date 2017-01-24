// DGAuthentication.m
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

#import "DGEndpoint+Private.h"
#import "DGAuthentication.h"
#import "DGHTTPClient.h"

#import "DGAuthView.h"

#import "DGTokenStore.h"
#import "DGIdentity+Keychain.h"
#import "DGIdentity+Mapping.h"

NSString * const DGCallback = @"discogsapi://success";

static NSString * const kDGOAuth1CredentialDiscogsAccount = @"DGOAuthCredentialDiscogsAccount";

@implementation DGAuthentication {
    NSString *_callback;
}

#pragma GCC diagnostic push
#pragma GCC diagnostic ignored "-Wdeprecated-declarations"

- (void)configureManager:(DGObjectManager *)manager {
    
    if (DGIdentity.current) {
        manager.HTTPClient.accessToken = DGIdentity.current.accessToken;
    } else {
        //Backward compatibility
        manager.HTTPClient.accessToken = [DGTokenStore retrieveCredentialWithIdentifier:kDGOAuth1CredentialDiscogsAccount];
    }

    //User Identity
    [manager.router.routeSet addRoute:[RKRoute routeWithClass:[DGIdentity class] pathPattern:@"oauth/identity" method:RKRequestMethodGET]];
}

#pragma GCC diagnostic pop

- (void)identityWithSuccess:(void (^)(DGIdentity *identity))success failure:(void (^)(NSError *error))failure {
    DGIdentity *identity = [DGIdentity new];
    
    DGOperation<DGIdentity *> *operation = [self.manager operationWithRequest:identity method:RKRequestMethodGET responseClass:[DGIdentity class]];
    [operation setCompletionBlockWithSuccess:^(DGIdentity * _Nonnull response) {
        
        response.accessToken = self.manager.HTTPClient.accessToken;
        [DGIdentity storeIdentity:response withIdentifier:kDGIdentityCurrentIdentifier];
        success(response);
        
    } failure:^(NSError * _Nullable error) {
        
        if (error.code == 401) {
            DGIdentity.current = nil;
        }
        
        if (DGIdentity.current) {
            success(DGIdentity.current);
        } else if (failure) {
            failure(error);
        }
    }];
    
    [self.queue addOperation:operation];
}

- (void)authenticateWithCallback:(NSURL *)callback success:(void (^)(DGIdentity *identity))success failure:(void (^)(NSError *error))failure {
    
    [self identityWithSuccess:success failure:^(NSError *error) {
        
        if (error.code == 401) {
            _callback = callback.absoluteString;
            
            [self.manager.HTTPClient authorizeUsingOAuthWithCallbackURL:callback success:^(AFOAuth1Token *accessToken, id responseObject) {
                [self identityWithSuccess:success failure:failure];
            } failure:failure];
            
        } else if (failure) {
            failure(error);
        }
    }];
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
    
    [self.manager.HTTPClient setServiceProviderRequestHandler:^(NSURLRequest *request) {
        DGAuthView *view = [DGAuthView viewWithRequest:request];
        authView(view);
    } completion:nil];
    
    NSURL *callback = [NSURL URLWithString:DGCallback];
    [self authenticateWithCallback:callback success:success failure:failure];
}

@end
