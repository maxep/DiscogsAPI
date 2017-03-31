// DGCollection.m
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
#import "DGCollection.h"
#import "DGReleaseInstance+Mapping.h"
#import "DGCollectionFolder+Mapping.h"
#import "DGCollectionField+Mapping.h"

@implementation DGCollection

- (void)configureManager:(DGObjectManager *)manager {
    
    //User collection folders
    [manager.router.routeSet addRoute:[RKRoute routeWithClass:[DGCollectionFoldersRequest class] pathPattern:@"users/:userName/collection/folders" method:RKRequestMethodAny]];
    
    //User collection folder request
    [manager.router.routeSet addRoute:[RKRoute routeWithClass:[DGCollectionFolderRequest class] pathPattern:@"users/:userName/collection/folders/:folderID" method:RKRequestMethodAny]];
    
    //Create collection folder request
    [manager.router.routeSet addRoute:[RKRoute routeWithClass:[DGCreateCollectionFolderRequest class] pathPattern:@"users/:userName/collection/folders" method:RKRequestMethodPOST]];
    
    //User collection releases request
    [manager.router.routeSet addRoute:[RKRoute routeWithClass:[DGCollectionFolderItemsRequest class] pathPattern:@"users/:userName/collection/folders/:folderID/releases" method:RKRequestMethodGET]];
    [manager.router.routeSet addRoute:[RKRoute routeWithClass:[DGCollectionReleaseItemsRequest class] pathPattern:@"users/:userName/collection/releases/:releaseID" method:RKRequestMethodGET]];
    
    //Post release in Collection folder
    [manager.router.routeSet addRoute:[RKRoute routeWithClass:[DGAddToCollectionFolderRequest class] pathPattern:@"/users/:userName/collection/folders/:folderID/releases/:releaseID" method:RKRequestMethodPOST]];
    
    //Manage collection's release instance
    [manager.router.routeSet addRoute:[RKRoute routeWithClass:[DGReleaseInstanceRequest class] pathPattern:@"/users/:userName/collection/folders/:folderID/releases/:releaseID/instances/:instanceID" method:RKRequestMethodAny]];
    
    //Change release's rating
    [manager.router.routeSet addRoute:[RKRoute routeWithClass:[DGChangeRatingOfReleaseRequest class] pathPattern:@"/users/:userName/collection/folders/:folderID/releases/:releaseID/instances/:instanceID" method:RKRequestMethodPOST]];
    
    //Get release instance fields
    [manager.router.routeSet addRoute:[RKRoute routeWithClass:[DGCollectionFieldsRequest class] pathPattern:@"users/:userName/collection/fields" method:RKRequestMethodGET]];
    
    //Edit instance field request
    [manager.router.routeSet addRoute:[RKRoute routeWithClass:[DGEditFieldsInstanceRequest class] pathPattern:@"/users/:userName/collection/folders/:folderID/releases/:releaseID/instances/:instanceID/fields/:fieldID" method:RKRequestMethodPOST]];
    [manager addRequestDescriptor:[DGEditFieldsInstanceRequest requestDescriptor]];
}

- (void)getFolders:(NSString *)userName success:(void (^)(NSArray<DGCollectionFolder *> *folders))success failure:(void (^)(NSError *error))failure {
    
    DGCollectionFoldersRequest *request = [DGCollectionFoldersRequest new];
    request.userName = userName;
    
    DGOperation *operation = [self.manager operationWithRequest:request method:RKRequestMethodGET responseClass:[DGCollectionFoldersRequest class]];
    [operation setCompletionBlockWithSuccess:success failure:failure];
    
    [self.queue addOperation:operation];
}

- (void)getFolder:(DGCollectionFolderRequest *)request success:(void (^)(DGCollectionFolder *folder))success failure:(void (^)(NSError *error))failure {
    
    DGOperation *operation = [self.manager operationWithRequest:request method:RKRequestMethodGET responseClass:[DGCollectionFolder class]];
    [operation setCompletionBlockWithSuccess:success failure:failure];
    
    [self.queue addOperation:operation];
}

- (void)createFolder:(DGCreateCollectionFolderRequest *)request success:(void (^)(DGCollectionFolder *folder))success failure:(void (^)(NSError *error))failure {
    
    DGOperation *operation = [self.manager operationWithRequest:request method:RKRequestMethodPOST responseClass:[DGCollectionFolder class]];
    [operation setCompletionBlockWithSuccess:success failure:failure];
    
    [self.queue addOperation:operation];
}

- (void)editFolder:(DGCollectionFolderRequest *)request success:(void (^)(DGCollectionFolder *folder))success failure:(void (^)(NSError *error))failure {
    
    DGOperation *operation = [self.manager operationWithRequest:request method:RKRequestMethodPOST responseClass:[DGCollectionFolder class]];
    [operation setCompletionBlockWithSuccess:success failure:failure];
    
    [self.queue addOperation:operation];
}

- (void)deleteFolder:(DGCollectionFolderRequest *)request success:(void (^)())success failure:(void (^)(NSError *error))failure {
    
    DGOperation *operation = [self.manager operationWithRequest:request method:RKRequestMethodDELETE];
    [operation setCompletionBlockWithSuccess:success failure:failure];
    
    [self.queue addOperation:operation];
}

- (void)getItemsByFolder:(DGCollectionFolderItemsRequest *)request success:(void (^)(DGCollectionItemsResponse *response))success failure:(void (^)(NSError *error))failure {
    
    DGOperation *operation = [self.manager operationWithRequest:request method:RKRequestMethodGET responseClass:[DGCollectionItemsResponse class]];
    [operation setCompletionBlockWithSuccess:success failure:failure];
    
    [self.queue addOperation:operation];
}

- (void)getItemsByRelease:(DGCollectionReleaseItemsRequest *)request success:(void (^)(DGCollectionItemsResponse *response))success failure:(nullable DGFailureBlock)failure {
    
    DGOperation *operation = [self.manager operationWithRequest:request method:RKRequestMethodGET responseClass:[DGCollectionItemsResponse class]];
    [operation setCompletionBlockWithSuccess:success failure:failure];
    
    [self.queue addOperation:operation];
}

- (void)addToFolder:(DGAddToCollectionFolderRequest *)request success:(void (^)(DGAddToCollectionFolderResponse *response))success failure:(void (^)(NSError *error))failure {
    
    DGOperation *operation = [self.manager operationWithRequest:request method:RKRequestMethodPOST responseClass:[DGAddToCollectionFolderResponse class]];
    [operation setCompletionBlockWithSuccess:success failure:failure];
    
    [self.queue addOperation:operation];
}

- (void)changeRatingOfRelease:(DGChangeRatingOfReleaseRequest *)request success:(void (^)())success failure:(void (^)(NSError *error))failure {
    
    DGOperation *operation = [self.manager operationWithRequest:request method:RKRequestMethodPOST];
    [operation setCompletionBlockWithSuccess:success failure:failure];
    
    [self.queue addOperation:operation];
}

- (void)getInstanceFromFolder:(DGReleaseInstanceRequest *)request success:(nonnull void (^)(DGReleaseInstance *response))success failure:(void (^)(NSError *error))failure {
    
    DGOperation *operation = [self.manager operationWithRequest:request method:RKRequestMethodGET responseClass:[DGReleaseInstance class]];
    [operation setCompletionBlockWithSuccess:success failure:failure];
    
    [self.queue addOperation:operation];
}

- (void)deleteInstanceFromFolder:(DGReleaseInstanceRequest *)request success:(void (^)())success failure:(void (^)(NSError *error))failure {
    
    DGOperation *operation = [self.manager operationWithRequest:request method:RKRequestMethodDELETE];
    [operation setCompletionBlockWithSuccess:success failure:failure];
    
    [self.queue addOperation:operation];
}

- (void)getFields:(NSString *)userName success:(void (^)(NSArray<DGCollectionField *> *fields))success failure:(void (^)(NSError *error))failure {
    
    DGCollectionFieldsRequest *request = [DGCollectionFieldsRequest new];
    request.userName = userName;
    
    DGOperation *operation = [self.manager operationWithRequest:request method:RKRequestMethodGET responseClass:[DGCollectionField class]];
    [operation setCompletionBlockWithSuccess:success failure:failure];
    
    [self.queue addOperation:operation];
}

- (void)editField:(DGEditFieldsInstanceRequest *)request success:(void (^)())success failure:(void (^)(NSError *error))failure {
    
    DGOperation *operation = [self.manager operationWithRequest:request method:RKRequestMethodPOST];
    [operation setCompletionBlockWithSuccess:success failure:failure];
    
    [self.queue addOperation:operation];
}

@end
