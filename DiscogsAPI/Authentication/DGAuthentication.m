// DGAuthentication.m
//
// Copyright (c) 2015 Maxime Epain
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

#import "DGAuthentication.h"

#import "DGTokenStore.h"
#import "DGAuthView.h"

NSString* const kDGBaseURL         = @"https://api.discogs.com/";
NSString* const kDGRequestTokenURL = @"https://api.discogs.com/oauth/request_token";
NSString* const kDGAuthorizeURL    = @"http://www.discogs.com/oauth/authorize";
NSString* const kDGAccessTokenURL  = @"https://api.discogs.com/oauth/access_token";

NSString* const kDGCallback = @"discogsapi://success";

NSString * const kDGOAuth1CredentialDiscogsAccount = @"DGOAuthCredentialDiscogsAccount";

@implementation DGAuthentication

+ (DGAuthentication*) authenticationWithConsumerKey:(NSString*)consumerKey consumerSecret:(NSString*)consumerSecret
{
    return [[DGAuthentication alloc] initWithConsumerKey:consumerKey consumerSecret:consumerSecret];
}

- (id) initWithConsumerKey:(NSString*)consumerKey consumerSecret:(NSString*)consumerSecret
{
    self = [super init];
    if (self) {
        
        self.oAuth1Client = [[AFOAuth1Client alloc] initWithBaseURL:[NSURL URLWithString:kDGBaseURL] key:consumerKey secret:consumerSecret];
        
        [self.oAuth1Client setSignatureMethod:AFPlainTextSignatureMethod];
        self.oAuth1Client.accessToken = [DGTokenStore retrieveCredentialWithIdentifier:kDGOAuth1CredentialDiscogsAccount];
    }
    return self;
}

- (void) authenticateWithCallback:(NSURL*) callback success:(void (^)())success failure:(void (^)(NSError* error))failure
{
    if ([self.delegate isReachable]) {
        [self.delegate identifyUserWithSuccess:success failure:^(NSError *error) {
            
       //     if (error.code == 401) {
            if (error.code == -1011) {
                [self removeAccountCredential];
            }
            
            [self.oAuth1Client authorizeUsingOAuthWithRequestTokenPath:kDGRequestTokenURL
                                                 userAuthorizationPath:kDGAuthorizeURL
                                                           callbackURL:callback
                                                       accessTokenPath:kDGAccessTokenURL
                                                          accessMethod:@"POST"
                                                                 scope:nil
            success:^(AFOAuth1Token *accessToken, id responseObject) {
                [DGTokenStore storeCredential:accessToken withIdentifier:kDGOAuth1CredentialDiscogsAccount];
                success();
            }
            failure:^(NSError *error) {
                    
                failure(error);
            }];
        }];
    }
    else if (self.oAuth1Client.accessToken){
        success();
    }
    else {
        failure([self errorWithCode:NSURLErrorNotConnectedToInternet info:@"User not athenticated yet but no internet connection"]);
    }
}

- (void) authenticateWithPreparedAuthorizationViewHandler:(void (^)(UIView* authView))authView success:(void (^)())success failure:(void (^)(NSError* error))failure
{
    NSURL* callback = [NSURL URLWithString:kDGCallback];
    
    [self.oAuth1Client setServiceProviderRequestHandler:^(NSURLRequest *request) {
        DGAuthView* view = [DGAuthView viewWithRequest:request];
        authView(view);
    } completion:nil];
    
    [self authenticateWithCallback:callback success:success failure:failure];
}

- (BOOL) isAuthenticated {
    return (self.oAuth1Client.accessToken != nil)? YES : NO;
}

- (void) removeAccountCredential
{
    [DGTokenStore deleteCredentialWithIdentifier:kDGOAuth1CredentialDiscogsAccount];
    self.oAuth1Client.accessToken = nil;
}

@end
