// DGHTTPClient.h
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

#import "DGHTTPClient.h"

NSString * const kDGBaseURL = @"https://api.discogs.com/";

static NSString * const kDGRequestTokenURL = @"oauth/request_token";
static NSString * const kDGAuthorizeURL    = @"https://discogs.com/oauth/authorize";
static NSString * const kDGAccessTokenURL  = @"oauth/access_token";

@interface DGHTTPClient ()
@property (readwrite, nonatomic, copy) NSString *key;
@property (readwrite, nonatomic, copy) NSString *secret;

@property (readwrite, nonatomic, copy) NSString *personalAccessToken;
@end

@implementation DGHTTPClient

@dynamic key;
@dynamic secret;

+ (instancetype)clientWithConsumerKey:(NSString *)key consumerSecret:(NSString *)secret {
    return [[self alloc] initWithConsumerKey:key consumerSecret:secret];
}

+ (instancetype)clientWithPersonalAccessToken:(NSString *)token {
    return [[self alloc] initWithPersonalAccessToken:token];
}

- (instancetype)init {
    return [self initWithBaseURL:[NSURL URLWithString:kDGBaseURL]];
}

- (instancetype)initWithBaseURL:(NSURL *)url {
    self = [super initWithBaseURL:url];
    if (self) {
        self.signatureMethod = AFPlainTextSignatureMethod;
        self.mediaType = @"plaintext";
    }
    return self;
}

- (instancetype)initWithConsumerKey:(NSString *)key consumerSecret:(NSString *)secret {
    self = [self init];
    if (self) {
        self.key = key;
        self.secret = secret;
    }
    return self;
}

- (instancetype)initWithPersonalAccessToken:(NSString *)token {
    self = [self init];
    if (self) {
        self.personalAccessToken = token;
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

- (void)setMediaType:(NSString *)mediaType {
    _mediaType = mediaType;
    NSString *accept = [NSString stringWithFormat:@"application/vnd.discogs.v2.%@+json", mediaType];
    [self setDefaultHeader:@"Accept" value:accept];
}

#pragma mark - AFHTTPClient

- (NSMutableURLRequest *)requestWithMethod:(NSString *)method path:(NSString *)path parameters:(NSDictionary *)parameters {
    NSMutableURLRequest *request = [super requestWithMethod:method path:path parameters:parameters];
    
    if (self.accessToken || [path isEqualToString:kDGRequestTokenURL]) {
        return request;
    }
    
    if (self.personalAccessToken) {
        NSString *authorization = [NSString stringWithFormat:@"Discogs token=%@", self.personalAccessToken];
        [request setValue:authorization forHTTPHeaderField:@"Authorization"];
        
    } else if (self.key && self.secret) {
        NSString *authorization = [NSString stringWithFormat:@"Discogs key=%@, secret=%@", self.key, self.secret];
        [request setValue:authorization forHTTPHeaderField:@"Authorization"];
    }
    
    return request;
}

@end
