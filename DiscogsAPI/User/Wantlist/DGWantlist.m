// DGWantlist.m
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
#import "DGPagination+Mapping.h"
#import "DGWantlist+Mapping.h"

@implementation DGWantlistRequest

- (id)init {
    if (self = [super init]) {
        self.pagination = [DGPagination new];
        self.userName = @"";
    }
    return self;
}

@end

@implementation DGWantlistResponse

@synthesize pagination;

- (instancetype)init {
    self = [super init];
    if (self) {
        self.wants = @[];
    }
    return self;
}

- (void)loadNextPageWithSuccess:(void (^)())success failure:(nullable void (^)(NSError * _Nullable error))failure {
    
    [self.pagination loadNextPageWithResponseClass:[DGWantlistResponse class] success:^(DGWantlistResponse *response) {
        self.pagination = response.pagination;
        self.wants = [self.wants arrayByAddingObjectsFromArray:response.wants];
        success();
    } failure:^(NSError *error) {
        RKLogError(@"Operation failed with error: %@", error);
        if (failure) failure(error);
    }];
}

@end

@implementation DGWantRequest

- (id)init {
    if (self = [super init]) {
        self.userName = @"";
        self.releaseID = @0;
        self.rating = @0;
        self.notes  = @"";
    }
    return self;
}

@end

@implementation DGWant

@end

@implementation DGWantlist

- (void)configureManager:(RKObjectManager *)objectManager {
    
    //User wantlist
    [objectManager.router.routeSet addRoute:[RKRoute routeWithClass:[DGWantlistRequest class] pathPattern:@"users/:userName/wants" method:RKRequestMethodGET]];
    
    //Manage Wantlist
    [objectManager.router.routeSet addRoute:[RKRoute routeWithClass:[DGWantRequest class] pathPattern:@"/users/:userName/wants/:releaseID" method:RKRequestMethodAny]];
}

- (void)getWantlist:(DGWantlistRequest *)request success:(void (^)(DGWantlistResponse * response))success failure:(void (^)(NSError* error))failure {
    
    DGOperation *operation = [self.manager operationWithRequest:request method:RKRequestMethodGET responseClass:[DGWantlistResponse class]];
    [operation setCompletionBlockWithSuccess:success failure:failure];
    
    [self.manager enqueueObjectRequestOperation:operation];
}

- (void)addToWantlist:(DGWantRequest *)request success:(void (^)(DGWant *want))success failure:(void (^)(NSError *error))failure {
    
    DGOperation *operation = [self.manager operationWithRequest:request method:RKRequestMethodPUT responseClass:[DGWant class]];
    [operation setCompletionBlockWithSuccess:success failure:failure];
    
    [self.manager enqueueObjectRequestOperation:operation];
}

- (void)editReleaseInWantlist:(DGWantRequest *)request success:(void (^)(DGWant *want))success failure:(void (^)(NSError *error))failure {
    
    DGOperation *operation = [self.manager operationWithRequest:request method:RKRequestMethodPOST responseClass:[DGWant class]];
    [operation setCompletionBlockWithSuccess:success failure:failure];
    
    [self.manager enqueueObjectRequestOperation:operation];
}

- (void)deleteReleaseFromWantlist:(DGWantRequest *)request success:(void (^)())success failure:(void (^)(NSError *error))failure {
    
    
    DGOperation *operation = [self.manager operationWithRequest:request method:RKRequestMethodDELETE];
    [operation setCompletionBlockWithSuccess:success failure:failure];
    
    [self.manager enqueueObjectRequestOperation:operation];
}

@end
