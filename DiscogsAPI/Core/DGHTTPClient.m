// DGHTTPClient.h
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

#import "DGHTTPClient.h"

NSString * const kDGBaseURL = @"https://api.discogs.com/";

static NSString * const kDGRequestTokenURL = @"oauth/request_token";
static NSString * const kDGAuthorizeURL    = @"https://discogs.com/oauth/authorize";
static NSString * const kDGAccessTokenURL  = @"oauth/access_token";

@interface DGHTTPClient ()
@property (nonatomic, strong) NSString   *authorizationHeader;
@property (nonatomic, readonly) NSString *acceptHeader;
@end

@implementation DGHTTPClient

+ (DGHTTPClient *)clientWithConsumerKey:(NSString *)key consumerSecret:(NSString *)secret {
    return [[DGHTTPClient alloc] initWithConsumerKey:key consumerSecret:secret];
}

+ (DGHTTPClient *)clientWithAccessToken:(NSString *)token {
    return [[DGHTTPClient alloc] initWithAccessToken:token];
}

- (instancetype)init {
    return [super initWithBaseURL:[NSURL URLWithString:kDGBaseURL]];
}

- (id)initWithConsumerKey:(NSString *)key consumerSecret:(NSString *)secret {
    NSURL *baseURL = [NSURL URLWithString:kDGBaseURL];
    if (self = [super initWithBaseURL:baseURL key:key secret:secret]) {
        self.authorizationHeader = [NSString stringWithFormat:@"Discogs key=%@, secret=%@", key, secret];
    }
    return self;
}

- (id)initWithAccessToken:(NSString *)token {
    NSURL *baseURL = [NSURL URLWithString:kDGBaseURL];
    if (self = [super initWithBaseURL:baseURL]) {
        self.authorizationHeader = [NSString stringWithFormat:@"Discogs token=%@", token];
    }
    return self;
}

- (void)authorizeUsingOAuthWithCallbackURL:(NSURL *)callbackURL success:(void (^)(AFOAuth1Token *, id))success failure:(void (^)(NSError *))failure {
    
    [super authorizeUsingOAuthWithRequestTokenPath:kDGRequestTokenURL
                             userAuthorizationPath:kDGAuthorizeURL
                                       callbackURL:callbackURL
                                   accessTokenPath:kDGAccessTokenURL
                                      accessMethod:@"POST"
                                             scope:nil
                                           success:success
                                           failure:^(NSError *error) {
                                               //nilify the token when failed
                                               self.accessToken = nil;
                                               if (failure) failure(error);
                                           }];
}

#pragma mark Properties

- (NSString *)acceptHeader {
    return [NSString stringWithFormat:@"application/vnd.discogs.v2.%@+json", self.mediaType];
}

- (NSString *)mediaType {
    if (!_mediaType) {
        _mediaType = @"plaintext";
    }
    return _mediaType;
}

#pragma mark - AFHTTPClient

- (NSMutableURLRequest *)requestWithMethod:(NSString *)method path:(NSString *)path parameters:(NSDictionary *)parameters {
    NSMutableURLRequest *request = [super requestWithMethod:method path:path parameters:parameters];
    
    [request setValue:self.acceptHeader forHTTPHeaderField:@"Accept"];
    if (self.accessToken) {
        return request;
    }
    
    if (![path isEqualToString:kDGRequestTokenURL]) {
        [request setValue:self.authorizationHeader forHTTPHeaderField:@"Authorization"];
    }
    return request;
}

- (NSMutableURLRequest *)multipartFormRequestWithMethod:(NSString *)method path:(NSString *)path parameters:(NSDictionary *)parameters constructingBodyWithBlock:(void (^)(id <AFRKMultipartFormData> formData))block {
    NSMutableURLRequest *request = [super multipartFormRequestWithMethod:method path:path parameters:parameters constructingBodyWithBlock:block];
    
    [request setValue:self.acceptHeader forHTTPHeaderField:@"Accept"];
    if (self.accessToken) {
        return request;
    }
    
    if (![path isEqualToString:kDGRequestTokenURL])  {
        [request setValue:self.authorizationHeader forHTTPHeaderField:@"Authorization"];
    }
    
    return request;
}

@end
