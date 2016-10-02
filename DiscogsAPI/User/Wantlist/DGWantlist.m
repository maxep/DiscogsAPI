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

+ (DGWantlistRequest *)request {
    return [[DGWantlistRequest alloc] init];
}

- (id)init {
    if (self = [super init]) {
        self.pagination = [DGPagination pagination];
    }
    return self;
}

@end

@implementation DGWantlistResponse

@synthesize pagination;

+ (DGWantlistResponse *)response {
    return [[DGWantlistResponse alloc] init];
}

- (void)loadNextPageWithSuccess:(void (^)())success failure:(void (^)(NSError* error))failure {
    
    [self.pagination loadNextPageWithResponseDesciptor:[DGWantlistResponse responseDescriptor] success:^(NSArray *objects) {
        if ([[objects firstObject] isKindOfClass:[DGWantlistResponse class]]) {
            DGWantlistResponse* response = [objects firstObject];
            
            self.pagination = response.pagination;
            NSMutableArray* wants = [self.wants mutableCopy];
            [wants addObjectsFromArray:response.wants];
            self.wants = wants;
            
            success();
        }
    } failure:^(NSError *error) {
        RKLogError(@"Operation failed with error: %@", error);
        if (failure) failure(error);
    }];
}

@end

@implementation DGWantRequest

+ (DGWantRequest *)request {
    return [[DGWantRequest alloc] init];
}

- (id)init {
    if (self = [super init]) {
        self.rating = @0;
        self.notes  = @"";
    }
    return self;
}

@end

@implementation DGWant

+ (DGWant *)want {
    return [[DGWant alloc] init];
}

@end

@implementation DGWantlist

- (void)configureManager:(RKObjectManager *)objectManager {
    
    //User wantlist
    [objectManager.router.routeSet addRoute:[RKRoute routeWithClass:[DGWantlistRequest class] pathPattern:@"users/:userName/wants" method:RKRequestMethodGET]];
    
    //Manage Wantlist
    [objectManager.router.routeSet addRoute:[RKRoute routeWithClass:[DGWantRequest class] pathPattern:@"/users/:userName/wants/:releaseID" method:RKRequestMethodAny]];
}

- (void)getWantlist:(DGWantlistRequest *)request success:(void (^)(DGWantlistResponse * response))success failure:(void (^)(NSError* error))failure {
    
    NSURLRequest *requestURL = [self.manager requestWithObject:request method:RKRequestMethodGET path:nil parameters:request.parameters];
    
    RKObjectRequestOperation *objectRequestOperation = [[RKObjectRequestOperation alloc] initWithRequest:requestURL responseDescriptors:@[ [DGWantlistResponse responseDescriptor] ]];
    
    [objectRequestOperation setCompletionBlockWithSuccess:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
         NSArray* results = mappingResult.array;
         if ([[results firstObject] isKindOfClass:[DGWantlistResponse class]]) {
             success([results firstObject]);
         }
         else {
             failure([self errorWithCode:NSURLErrorCannotParseResponse info:@"Bad response from Discogs server"]);
         }
     }
     failure:^(RKObjectRequestOperation *operation, NSError *error) {
         RKLogError(@"Operation failed with error: %@", error);
         failure(error);
     }];
    
    [self.manager enqueueObjectRequestOperation:objectRequestOperation];
}

- (void)addToWantlist:(DGWantRequest *)request success:(void (^)(DGWant *want))success failure:(void (^)(NSError *error))failure {
    
    NSURLRequest *requestURL = [self.manager requestWithObject:request method:RKRequestMethodPUT path:nil parameters:request.parameters];
    
    RKObjectRequestOperation *objectRequestOperation = [[RKObjectRequestOperation alloc] initWithRequest:requestURL responseDescriptors:@[ [DGWant responseDescriptor] ]];
    
    [objectRequestOperation setCompletionBlockWithSuccess:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
        
        NSArray* results = mappingResult.array;
        if ([[results firstObject] isKindOfClass:[DGWant class]]) {
            success([results firstObject]);
        }
        else {
            failure([self errorWithCode:NSURLErrorCannotParseResponse info:@"Bad response from Discogs server"]);
        }
    }
    failure:^(RKObjectRequestOperation *operation, NSError *error) {
        RKLogError(@"Operation failed with error: %@", error);
        failure(error);
    }];
    
    [self.manager enqueueObjectRequestOperation:objectRequestOperation];
}

- (void)editReleaseInWantlist:(DGWantRequest *)request success:(void (^)(DGWant *want))success failure:(void (^)(NSError *error))failure {
    
    NSURLRequest *requestURL = [self.manager requestWithObject:request method:RKRequestMethodPOST path:nil parameters:request.parameters];
    
    RKObjectRequestOperation *objectRequestOperation = [[RKObjectRequestOperation alloc] initWithRequest:requestURL responseDescriptors:@[ [DGWant responseDescriptor] ]];
    
    [objectRequestOperation setCompletionBlockWithSuccess:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
        
        NSArray* results = mappingResult.array;
        if ([[results firstObject] isKindOfClass:[DGWant class]]) {
            success([results firstObject]);
        }
        else {
            failure([self errorWithCode:NSURLErrorCannotParseResponse info:@"Bad response from Discogs server"]);
        }
    } failure:^(RKObjectRequestOperation *operation, NSError *error) {
        RKLogError(@"Operation failed with error: %@", error);
        failure(error);
    }];
    
    [self.manager enqueueObjectRequestOperation:objectRequestOperation];
}

- (void)deleteReleaseFromWantlist:(DGWantRequest *)request success:(void (^)())success failure:(void (^)(NSError *error))failure {
    
    NSURLRequest *requestURL = [self.manager requestWithObject:request
                                                        method:RKRequestMethodDELETE
                                                          path:nil
                                                    parameters:nil];
    
    RKObjectRequestOperation *objectRequestOperation = [[RKObjectRequestOperation alloc] initWithRequest:requestURL
                                                                                     responseDescriptors:self.manager.responseDescriptors];
    
    [objectRequestOperation setCompletionBlockWithSuccess:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
        success();
    } failure:^(RKObjectRequestOperation *operation, NSError *error) {
        RKLogError(@"Operation failed with error: %@", error);
        failure(error);
    }];
    
    [self.manager enqueueObjectRequestOperation:objectRequestOperation];
}

@end
