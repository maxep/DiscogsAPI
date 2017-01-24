// DGObjectManager.m
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

#import "DGObjectManager.h"

@implementation DGObjectManager

@dynamic HTTPClient;

+ (instancetype)manager {
    DGHTTPClient *client = [[DGHTTPClient alloc] init];
    return [[self alloc] initWithHTTPClient:client];
}

+ (instancetype)managerWithConsumerKey:(NSString *)key consumerSecret:(NSString *)secret {
    DGHTTPClient *client = [DGHTTPClient clientWithConsumerKey:key consumerSecret:secret];
    return [[self alloc] initWithHTTPClient:client];
}

+ (instancetype)managerWithPersonalAccessToken:(NSString *)token {
    DGHTTPClient *client = [DGHTTPClient clientWithPersonalAccessToken:token];
    return [[self alloc] initWithHTTPClient:client];
}

+ (instancetype)managerWithBaseURL:(NSURL *)baseURL; {
    DGObjectManager *manager = [[self alloc] initWithHTTPClient:[DGHTTPClient clientWithBaseURL:baseURL]];
    [manager.HTTPClient registerHTTPOperationClass:[AFRKJSONRequestOperation class]];
    [manager setAcceptHeaderWithMIMEType:RKMIMETypeJSON];
    return manager;
}

- (instancetype)initWithHTTPClient:(DGHTTPClient *)client {
    self = [super initWithHTTPClient:client];
    if (self) {
        self.requestSerializationMIMEType = RKMIMETypeJSON;
    }
    return self;
}

- (DGOperation *)operationWithRequest:(id<DGRequestObject>)request method:(RKRequestMethod)method {
    return [self operationWithRequest:request method:method responseClass:nil];
}

- (DGOperation *)operationWithRequest:(id<DGRequestObject>)request method:(RKRequestMethod)method responseClass:(Class<DGResponseObject>)responseClass {
    NSDictionary *parameters = nil;
    if ([request respondsToSelector:@selector(parameters)]) {
        parameters = request.parameters;
    }
    
    NSURLRequest *requestURL = [self requestWithObject:request method:method path:nil parameters:parameters];
    return [DGOperation operationWithRequest:requestURL responseClass:responseClass];
}

@end
