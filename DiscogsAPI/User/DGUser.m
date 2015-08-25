// DGUser.m
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

#import "DGEndpoint+Configuration.h"
#import "DGIdentity+Mapping.h"
#import "DGProfile+Mapping.h"
#import "DGCollection+Mapping.h"
#import "DGCollectionRelease+Mapping.h"
#import "DGReleaseInstance+Mapping.h"
#import "DGWantlist+Mapping.h"

#import "DGUser.h"

@interface DGUser ()
@property (nonatomic, strong) RKManagedObjectStore *store;
@end

@implementation DGUser

+ (DGUser*) user
{
    return [[DGUser alloc] init];
}

- (void) configureManager:(RKObjectManager*)objectManager
{
    //User Identity
    [objectManager.router.routeSet addRoute:[RKRoute routeWithClass:[DGIdentity class] pathPattern:@"oauth/identity" method:RKRequestMethodGET]];
    
    //User Profile
    [objectManager.router.routeSet addRoute:[RKRoute routeWithClass:[DGProfile class] pathPattern:@"users/:userName" method:RKRequestMethodAny]];
    
    //User collection folders
    [objectManager.router.routeSet addRoute:[RKRoute routeWithClass:[DGCollectionFolders class] pathPattern:@"users/:userName/collection/folders" method:RKRequestMethodAny]];
    
    //User collection folder request
    [objectManager.router.routeSet addRoute:[RKRoute routeWithClass:[DGCollectionFolderRequest class] pathPattern:@"users/:userName/collection/folders/:folderID" method:RKRequestMethodGET]];
    
    //User collection releases request
    [objectManager.router.routeSet addRoute:[RKRoute routeWithClass:[DGCollectionReleasesRequest class] pathPattern:@"users/:userName/collection/folders/:folderID/releases" method:RKRequestMethodGET]];
    
    //User wantlist
    [objectManager.router.routeSet addRoute:[RKRoute routeWithClass:[DGWantlistRequest class] pathPattern:@"users/:userName/wants" method:RKRequestMethodGET]];
    
    //Manage Wantlist
    [objectManager.router.routeSet addRoute:[RKRoute routeWithClass:[DGWantRequest class] pathPattern:@"/users/:userName/wants/:releaseID" method:RKRequestMethodAny]];
    
    //Post release in Collection folder
    [objectManager.router.routeSet addRoute:[RKRoute routeWithClass:[DGPutReleaseInFolderRequest class] pathPattern:@"/users/:userName/collection/folders/:folderID/releases/:releaseID" method:RKRequestMethodPOST]];

    //Collection's release instance request
    [objectManager.router.routeSet addRoute:[RKRoute routeWithClass:[DGReleaseInstanceRequest class] pathPattern:@"/users/:userName/collection/folders/:folderID/releases/:releaseID/instances/:instanceID" method:RKRequestMethodAny]];
    
    //Edit instance field request
    [objectManager.router.routeSet addRoute:[RKRoute routeWithClass:[DGEditInstanceRequest class] pathPattern:@"/users/:userName/collection/folders/:folderID/releases/:releaseID/instances/:instanceID/fields/:fieldID" method:RKRequestMethodPOST]];
    [objectManager addRequestDescriptor:[DGEditInstanceRequest requestDescriptor]];
}

- (void) identityWithSuccess:(void (^)(DGIdentity* identity))success failure:(void (^)(NSError* error))failure
{
    DGIdentity* identity = [DGIdentity identity];
    
    NSURLRequest *requestURL = [RKObjectManager.sharedManager requestWithObject:identity method:RKRequestMethodGET path:nil parameters:nil];
    
     RKObjectRequestOperation *objectRequestOperation = [[RKObjectRequestOperation alloc] initWithRequest:requestURL responseDescriptors:@[ [DGIdentity responseDescriptor] ]];
    
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
     }
     failure:^(RKObjectRequestOperation *operation, NSError *error)
     {
         RKLogError(@"Operation failed with error: %@", error);
         failure(error);
     }];
    
    [RKObjectManager.sharedManager enqueueObjectRequestOperation:objectRequestOperation];
}

- (void) getProfile:(NSString*)userName success:(void (^)(DGProfile* profile))success failure:(void (^)(NSError* error))failure
{
    DGProfile* profile = [DGProfile profile];
    profile.userName = userName;
    
    NSURLRequest *requestURL = [RKObjectManager.sharedManager requestWithObject:profile method:RKRequestMethodGET path:nil parameters:nil];
    
    RKObjectRequestOperation *objectRequestOperation = [[RKObjectRequestOperation alloc] initWithRequest:requestURL responseDescriptors:@[ [DGProfile responseDescriptor] ]];
    
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
     }
     failure:^(RKObjectRequestOperation *operation, NSError *error)
     {
         RKLogError(@"Operation failed with error: %@", error);
         failure(error);
     }];
    
    [RKObjectManager.sharedManager enqueueObjectRequestOperation:objectRequestOperation];
}

- (void) editProfile:(DGProfile *)profile success:(void (^)(DGProfile* profile))success failure:(void (^)(NSError* error))failure {

    DGCheckReachability();
    
    NSURLRequest *requestURL = [RKObjectManager.sharedManager requestWithObject:profile method:RKRequestMethodPOST path:nil parameters:profile.parameters];
    
    RKObjectRequestOperation *objectRequestOperation = [[RKObjectRequestOperation alloc] initWithRequest:requestURL responseDescriptors:@[ [DGProfile responseDescriptor] ]];
    
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
    
    [RKObjectManager.sharedManager enqueueObjectRequestOperation:objectRequestOperation];
}


- (void) getCollectionFolders:(NSString*)userName success:(void (^)(DGCollectionFolders* collection))success failure:(void (^)(NSError* error))failure {
    
    DGCollectionFolders* collection = [DGCollectionFolders collection];
    collection.userName = userName;
    
    NSURLRequest *requestURL = [RKObjectManager.sharedManager requestWithObject:collection method:RKRequestMethodGET path:nil parameters:nil];
    
    RKObjectRequestOperation *objectRequestOperation = [[RKObjectRequestOperation alloc] initWithRequest:requestURL responseDescriptors:@[ [DGCollectionFolders responseDescriptor] ]];
    
    [objectRequestOperation setCompletionBlockWithSuccess:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
        
         NSArray* results = mappingResult.array;
         if ([[results firstObject] isKindOfClass:[DGCollectionFolders class]]) {
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
    
    [RKObjectManager.sharedManager enqueueObjectRequestOperation:objectRequestOperation];
}

- (void) getCollectionFolder:(DGCollectionFolderRequest*)request success:(void (^)(DGCollectionFolder* folder))success failure:(void (^)(NSError* error))failure
{
    NSURLRequest *requestURL = [RKObjectManager.sharedManager requestWithObject:request method:RKRequestMethodGET path:nil parameters:nil];
    
    RKObjectRequestOperation *objectRequestOperation = [[RKObjectRequestOperation alloc] initWithRequest:requestURL responseDescriptors:@[ [DGCollectionFolder responseDescriptor] ]];
    
    [objectRequestOperation setCompletionBlockWithSuccess:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult)
     {
         NSArray* results = mappingResult.array;
         if ([[results firstObject] isKindOfClass:[DGCollectionFolder class]]) {
             success([results firstObject]);
         }
         else
         {
             failure([self errorWithCode:NSURLErrorCannotParseResponse info:@"Bad response from Discogs server"]);
         }
     }
     failure:^(RKObjectRequestOperation *operation, NSError *error)
     {
         RKLogError(@"Operation failed with error: %@", error);
         failure(error);
     }];
    
    [RKObjectManager.sharedManager enqueueObjectRequestOperation:objectRequestOperation];
}

- (void) getCollectionReleases:(DGCollectionReleasesRequest*)request success:(void (^)(DGCollectionReleasesResponse* folder))success failure:(void (^)(NSError* error))failure
{
    NSURLRequest *requestURL = [RKObjectManager.sharedManager requestWithObject:request method:RKRequestMethodGET path:nil parameters:request.parameters];
    
    RKObjectRequestOperation *objectRequestOperation = [[RKObjectRequestOperation alloc] initWithRequest:requestURL responseDescriptors:@[ [DGCollectionReleasesResponse responseDescriptor] ]];
    
    [objectRequestOperation setCompletionBlockWithSuccess:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult)
     {
         NSArray* results = mappingResult.array;
         if ([[results firstObject] isKindOfClass:[DGCollectionReleasesResponse class]]) {
             success([results firstObject]);
         }
         else
         {
             failure([self errorWithCode:NSURLErrorCannotParseResponse info:@"Bad response from Discogs server"]);
         }
     }
     failure:^(RKObjectRequestOperation *operation, NSError *error)
     {
         RKLogError(@"Operation failed with error: %@", error);
         failure(error);
     }];
    
    [RKObjectManager.sharedManager enqueueObjectRequestOperation:objectRequestOperation];
}

- (void) getWantlist:(DGWantlistRequest*)request success:(void (^)(DGWantlistResponse* response))success failure:(void (^)(NSError* error))failure
{
    NSURLRequest *requestURL = [RKObjectManager.sharedManager requestWithObject:request method:RKRequestMethodGET path:nil parameters:request.parameters];
    
    RKObjectRequestOperation *objectRequestOperation = [[RKObjectRequestOperation alloc] initWithRequest:requestURL responseDescriptors:@[ [DGWantlistResponse responseDescriptor] ]];
    
    [objectRequestOperation setCompletionBlockWithSuccess:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult)
     {
         NSArray* results = mappingResult.array;
         if ([[results firstObject] isKindOfClass:[DGWantlistResponse class]]) {
             success([results firstObject]);
         }
         else
         {
             failure([self errorWithCode:NSURLErrorCannotParseResponse info:@"Bad response from Discogs server"]);
         }
     }
     failure:^(RKObjectRequestOperation *operation, NSError *error)
     {
         RKLogError(@"Operation failed with error: %@", error);
         failure(error);
     }];
    
    [RKObjectManager.sharedManager enqueueObjectRequestOperation:objectRequestOperation];
}

- (void) addToWantlist:(DGWantRequest*)request success:(void (^)(DGWant* want))success failure:(void (^)(NSError* error))failure {
    
    NSURLRequest *requestURL = [RKObjectManager.sharedManager requestWithObject:request method:RKRequestMethodPUT path:nil parameters:request.parameters];
    
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
    
    [RKObjectManager.sharedManager enqueueObjectRequestOperation:objectRequestOperation];
}

- (void) editReleaseInWantlist:(DGWantRequest*)request success:(void (^)(DGWant* want))success failure:(void (^)(NSError* error))failure {
    
    NSURLRequest *requestURL = [RKObjectManager.sharedManager requestWithObject:request method:RKRequestMethodPOST path:nil parameters:request.parameters];
    
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
    
    [RKObjectManager.sharedManager enqueueObjectRequestOperation:objectRequestOperation];
}

- (void) deleteReleaseFromWantlist:(DGWantRequest*)request success:(void (^)())success failure:(void (^)(NSError* error))failure {
    
    NSURLRequest *requestURL = [RKObjectManager.sharedManager requestWithObject:request method:RKRequestMethodDELETE path:nil parameters:request.parameters];
    
    RKObjectRequestOperation *objectRequestOperation = [[RKObjectRequestOperation alloc] initWithRequest:requestURL responseDescriptors:@[ [DGWant responseDescriptor] ]];
    
    [objectRequestOperation setCompletionBlockWithSuccess:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
         success();
     }
     failure:^(RKObjectRequestOperation *operation, NSError *error) {
         RKLogError(@"Operation failed with error: %@", error);
         failure(error);
     }];
    
    [RKObjectManager.sharedManager enqueueObjectRequestOperation:objectRequestOperation];
}

- (void) editInstanceField:(DGEditInstanceRequest*)request success:(void (^)())success failure:(void (^)(NSError* error))failure {

    [RKObjectManager.sharedManager postObject:request path:nil parameters:nil success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
        success();
    } failure:^(RKObjectRequestOperation *operation, NSError *error) {
        failure(error);
    }];
}

@end
