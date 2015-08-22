// DGHTTPClient.h
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

#import "DGHTTPClient.h"

@interface DGHTTPClient ()
@property (nonatomic,strong) NSString *authorizationHeader;
@end

@implementation DGHTTPClient

- (id)initWithBaseURL:(NSURL *)url key:(NSString *)key secret:(NSString *)secret {
    if (self = [super initWithBaseURL:url]) {
        self.authorizationHeader = [NSString stringWithFormat:@"Discogs key=%@, secret=%@", key, secret];
    }
    return self;
}

- (id)initWithBaseURL:(NSURL *)url accessToken:(NSString *)token; {
    if (self = [super initWithBaseURL:url]) {
        self.authorizationHeader = [NSString stringWithFormat:@"Discogs token=%@", token];
    }
    return self;
}

#pragma mark - AFHTTPClient

- (NSMutableURLRequest *)requestWithMethod:(NSString *)method
                                      path:(NSString *)path
                                parameters:(NSDictionary *)parameters
{
    
    NSMutableURLRequest *request = [super requestWithMethod:method path:path parameters:parameters];

    [request setValue:self.authorizationHeader forHTTPHeaderField:@"Authorization"];
    [request setHTTPShouldHandleCookies:NO];
    
    return request;
}

- (NSMutableURLRequest *)multipartFormRequestWithMethod:(NSString *)method
                                                   path:(NSString *)path
                                             parameters:(NSDictionary *)parameters
                              constructingBodyWithBlock:(void (^)(id <AFMultipartFormData> formData))block
{
    NSMutableURLRequest *request = [super multipartFormRequestWithMethod:method path:path parameters:parameters constructingBodyWithBlock:block];
    
    [request setValue:self.authorizationHeader forHTTPHeaderField:@"Authorization"];
    [request setHTTPShouldHandleCookies:NO];
    
    return request;
}

@end
