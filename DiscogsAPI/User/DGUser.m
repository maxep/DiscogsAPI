// DGUser.m
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
#import "DGIdentity+Mapping.h"
#import "DGProfile+Mapping.h"

#import "DGUser.h"

@interface DGUser ()
@property (nonatomic, strong) RKManagedObjectStore *store;
@end

@implementation DGUser

@synthesize wantlist     = _wantlist;
@synthesize collection  = _collection;

+ (DGUser*) user {
    return [[DGUser alloc] init];
}

#pragma mark Properties

- (DGWantlist *)wantlist {
    if (!_wantlist) {
        _wantlist = [DGWantlist wantlist];
        _wantlist.manager = self.manager;
    }
    return _wantlist;
}

- (DGCollection *)collection {
    if (!_collection) {
        _collection = [DGCollection collection];
        _collection.manager = self.manager;
    }
    return _collection;
}

#pragma mark Configuration

- (void) configureManager:(RKObjectManager*)objectManager {
    //User Identity
    [objectManager.router.routeSet addRoute:[RKRoute routeWithClass:[DGIdentity class] pathPattern:@"oauth/identity" method:RKRequestMethodGET]];
    
    //User Profile
    [objectManager.router.routeSet addRoute:[RKRoute routeWithClass:[DGProfile class] pathPattern:@"users/:userName" method:RKRequestMethodAny]];
}

#pragma mark Public Methods

- (void) identityWithSuccess:(void (^)(DGIdentity* identity))success failure:(void (^)(NSError* error))failure {
    DGIdentity* identity = [DGIdentity identity];
    
    NSURLRequest *requestURL = [self.manager requestWithObject:identity
                                                        method:RKRequestMethodGET
                                                          path:nil
                                                    parameters:nil];
    
     RKObjectRequestOperation *objectRequestOperation = [[RKObjectRequestOperation alloc] initWithRequest:requestURL
                                                                                      responseDescriptors:@[ [DGIdentity responseDescriptor] ]];
    
    [objectRequestOperation setCompletionBlockWithSuccess:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult)
     {
         NSArray* results = mappingResult.array;
         if ([[results firstObject] isKindOfClass:[DGIdentity class]]) {
             success([results firstObject]);
         }
         else
         {
             failure([self errorWithCode:NSURLErrorCannotParseResponse info:@"Bad response from Discogs server"]);
         }
     } failure:^(RKObjectRequestOperation *operation, NSError *error)
     {
         RKLogError(@"Operation failed with error: %@", error);
         failure(error);
     }];
    
    [self.manager enqueueObjectRequestOperation:objectRequestOperation];
}

- (void) getProfile:(NSString*)userName success:(void (^)(DGProfile* profile))success failure:(void (^)(NSError* error))failure {
    
    DGProfile* profile = [DGProfile profile];
    profile.userName = userName;
    
    NSURLRequest *requestURL = [self.manager requestWithObject:profile
                                                        method:RKRequestMethodGET
                                                          path:nil
                                                    parameters:nil];
    
    RKObjectRequestOperation *objectRequestOperation = [[RKObjectRequestOperation alloc] initWithRequest:requestURL
                                                                                     responseDescriptors:@[ [DGProfile responseDescriptor] ]];
    
    [objectRequestOperation setCompletionBlockWithSuccess:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult)
     {
         NSArray* results = mappingResult.array;
         if ([[results firstObject] isKindOfClass:[DGProfile class]]) {
             success([results firstObject]);
         }
         else
         {
             failure([self errorWithCode:NSURLErrorCannotParseResponse info:@"Bad response from Discogs server"]);
         }
     } failure:^(RKObjectRequestOperation *operation, NSError *error)
     {
         RKLogError(@"Operation failed with error: %@", error);
         failure(error);
     }];
    
    [self.manager enqueueObjectRequestOperation:objectRequestOperation];
}

- (void) editProfile:(DGProfile *)profile success:(void (^)(DGProfile* profile))success failure:(void (^)(NSError* error))failure {

    DGCheckReachability();
    
    NSURLRequest *requestURL = [self.manager requestWithObject:profile
                                                        method:RKRequestMethodPOST
                                                          path:nil
                                                    parameters:profile.parameters];
    
    RKObjectRequestOperation *objectRequestOperation = [[RKObjectRequestOperation alloc] initWithRequest:requestURL
                                                                                     responseDescriptors:@[ [DGProfile responseDescriptor] ]];
    
    [objectRequestOperation setCompletionBlockWithSuccess:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
        
         NSArray* results = mappingResult.array;
         if ([[results firstObject] isKindOfClass:[DGProfile class]]) {
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

@end
