// DGDatabase.m
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

#import "DGDatabase.h"

#import "DGEndpoint+Configuration.h"
#import "DGSearch+Mapping.h"
#import "DGArtist+Mapping.h"
#import "DGArtistRelease+Mapping.h"
#import "DGRelease+Mapping.h"
#import "DGMaster+Mapping.h"
#import "DGMasterVersion+Mapping.h"
#import "DGLabel+Mapping.h"
#import "DGLabelRelease+Mapping.h"

@implementation DGDatabase

- (void)configureManager:(RKObjectManager *)manager {
    
    //Search
    [manager.router.routeSet addRoute:[RKRoute routeWithClass:[DGSearchRequest class] pathPattern:@"database/search" method:RKRequestMethodGET]];
    
    //Artist
    [manager.router.routeSet addRoute:[RKRoute routeWithClass:[DGArtist class] pathPattern:@"artists/:ID" method:RKRequestMethodGET]];
    [manager.router.routeSet addRoute:[RKRoute routeWithClass:[DGArtistReleaseRequest class] pathPattern:@"artists/:artistID/releases" method:RKRequestMethodGET]];
    
    //Release
    [manager.router.routeSet addRoute:[RKRoute routeWithClass:[DGRelease class] pathPattern:@"releases/:ID" method:RKRequestMethodGET]];
    
    //Master
    [manager.router.routeSet addRoute:[RKRoute routeWithClass:[DGMaster class] pathPattern:@"masters/:ID" method:RKRequestMethodGET]];
    [manager.router.routeSet addRoute:[RKRoute routeWithClass:[DGMasterVersionRequest class] pathPattern:@"masters/:masterID/versions" method:RKRequestMethodGET]];
    
    //Label
    [manager.router.routeSet addRoute:[RKRoute routeWithClass:[DGLabel class] pathPattern:@"labels/:ID" method:RKRequestMethodGET]];
    [manager.router.routeSet addRoute:[RKRoute routeWithClass:[DGLabelReleasesRequest class] pathPattern:@"labels/:labelID/releases" method:RKRequestMethodGET]];
}

- (void)searchFor:(DGSearchRequest *)request success:(void (^)(DGSearchResponse *response))success failure:(void (^)(NSError *error))failure {
    
    DGOperation *operation = [self.manager operationWithRequest:request method:RKRequestMethodGET responseClass:[DGSearchResponse class]];
    [operation setCompletionBlockWithSuccess:success failure:failure];

    [self.queue addOperation:operation];
}

- (void)getArtist:(NSNumber *)artistID success:(void (^)(DGArtist *artist))success failure:(void (^)(NSError *error))failure {
    
    DGArtist *artist    = [DGArtist new];
    artist.ID           = artistID;
    
    DGOperation *operation = [self.manager operationWithRequest:artist method:RKRequestMethodGET responseClass:[DGArtist class]];
    [operation setCompletionBlockWithSuccess:success failure:failure];
    
    [self.queue addOperation:operation];
}

- (void)getArtistReleases:(DGArtistReleaseRequest *)request success:(void (^)(DGArtistReleaseResponse *response))success failure:(void (^)(NSError *error))failure {
    
    DGOperation *operation = [self.manager operationWithRequest:request method:RKRequestMethodGET responseClass:[DGArtistReleaseResponse class]];
    [operation setCompletionBlockWithSuccess:success failure:failure];
    
    [self.queue addOperation:operation];
}

- (void)getRelease:(NSNumber *)releaseID success:(void (^)(DGRelease *release))success failure:(void (^)(NSError *error))failure {
    
    DGRelease *release  = [DGRelease new];
    release.ID          = releaseID;
    
    DGOperation *operation = [self.manager operationWithRequest:release method:RKRequestMethodGET responseClass:[DGRelease class]];
    [operation setCompletionBlockWithSuccess:success failure:failure];
    
    [self.queue addOperation:operation];
}

- (void)getMaster:(NSNumber *)masterID success:(void (^)(DGMaster *master))success failure:(void (^)(NSError *error))failure {
    
    DGMaster *master    = [DGMaster new];
    master.ID           = masterID;
    
    DGOperation *operation = [self.manager operationWithRequest:master method:RKRequestMethodGET responseClass:[DGMaster class]];
    [operation setCompletionBlockWithSuccess:success failure:failure];
    
    [self.queue addOperation:operation];
}

- (void)getMasterVersion:(DGMasterVersionRequest *)request success:(void (^)(DGMasterVersionResponse *response))success failure:(void (^)(NSError *error))failure {
    
    DGOperation *operation = [self.manager operationWithRequest:request method:RKRequestMethodGET responseClass:[DGMasterVersionResponse class]];
    [operation setCompletionBlockWithSuccess:success failure:failure];

    [self.queue addOperation:operation];
}

- (void)getLabel:(NSNumber *)labelID success:(void (^)(DGLabel *label))success failure:(void (^)(NSError *error))failure {
    
    DGLabel *label  = [DGLabel new];
    label.ID        = labelID;
    
    DGOperation *operation = [self.manager operationWithRequest:label method:RKRequestMethodGET responseClass:[DGLabel class]];
    [operation setCompletionBlockWithSuccess:success failure:failure];
    
    [self.queue addOperation:operation];
}

- (void)getLabelReleases:(DGLabelReleasesRequest *)request success:(void (^)(DGLabelReleasesResponse *response))success failure:(void (^)(NSError *error))failure {
    
    DGOperation *operation = [self.manager operationWithRequest:request method:RKRequestMethodGET responseClass:[DGLabelReleasesResponse class]];
    [operation setCompletionBlockWithSuccess:success failure:failure];
    
    [self.queue addOperation:operation];
}

@end
