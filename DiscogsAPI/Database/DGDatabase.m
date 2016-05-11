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

#import "DGEndpoint+Configuration.h"
#import "DGSearch+Mapping.h"
#import "DGArtist+Mapping.h"
#import "DGArtistRelease+Mapping.h"
#import "DGRelease+Mapping.h"
#import "DGMaster+Mapping.h"
#import "DGMasterVersion+Mapping.h"
#import "DGLabel+Mapping.h"
#import "DGLabelRelease+Mapping.h"

#import "DGDatabase.h"

@implementation DGDatabase

+ (DGDatabase*) database {
    return [[DGDatabase alloc] init];
}

- (void) configureManager:(RKObjectManager*)objectManager {
    [super configureManager:objectManager];
    
    //search
    [objectManager.router.routeSet addRoute:[RKRoute routeWithClass:[DGSearchRequest class] pathPattern:@"database/search" method:RKRequestMethodGET]];
    
    //Artist
    [objectManager.router.routeSet addRoute:[RKRoute routeWithClass:[DGArtist class] pathPattern:@"artists/:ID" method:RKRequestMethodGET]];
    [objectManager.router.routeSet addRoute:[RKRoute routeWithClass:[DGArtistReleaseRequest class] pathPattern:@"artists/:artistID/releases" method:RKRequestMethodGET]];
    
    //Release
    [objectManager.router.routeSet addRoute:[RKRoute routeWithClass:[DGRelease class] pathPattern:@"releases/:ID" method:RKRequestMethodGET]];
    
    //Master
    [objectManager.router.routeSet addRoute:[RKRoute routeWithClass:[DGMaster class] pathPattern:@"masters/:ID" method:RKRequestMethodGET]];
    [objectManager.router.routeSet addRoute:[RKRoute routeWithClass:[DGMasterVersionRequest class] pathPattern:@"masters/:masterID/versions" method:RKRequestMethodGET]];
    
    //Label
    [objectManager.router.routeSet addRoute:[RKRoute routeWithClass:[DGLabel class] pathPattern:@"labels/:ID" method:RKRequestMethodGET]];
    [objectManager.router.routeSet addRoute:[RKRoute routeWithClass:[DGLabelReleasesRequest class] pathPattern:@"labels/:labelID/releases" method:RKRequestMethodGET]];
}

- (void) searchFor:(DGSearchRequest*)request success:(void (^)(DGSearchResponse* response))success failure:(void (^)(NSError* error))failure {
    DGCheckReachability();
    
    NSURLRequest *requestURL = [self.manager requestWithObject:request method:RKRequestMethodGET path:nil parameters:request.parameters];
    
    RKObjectRequestOperation *objectRequestOperation = [[RKObjectRequestOperation alloc] initWithRequest:requestURL responseDescriptors:@[ [DGSearchResponse responseDescriptor] ]];
    
    [objectRequestOperation setCompletionBlockWithSuccess:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
        NSArray* results = mappingResult.array;
        if ([[results firstObject] isKindOfClass:[DGSearchResponse class]]) {
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

- (void) getArtist:(NSNumber*)artistID success:(void (^)(DGArtist* artist))success failure:(void (^)(NSError* error))failure {
    DGCheckReachability();
    
    DGArtist* artist    = [DGArtist artist];
    artist.ID           = artistID;
    
    NSURLRequest *requestURL = [self.manager requestWithObject:artist method:RKRequestMethodGET path:nil parameters:nil];
    
    RKObjectRequestOperation *objectRequestOperation = [[RKObjectRequestOperation alloc] initWithRequest:requestURL responseDescriptors:@[ [DGArtist responseDescriptor] ]];
    
    [objectRequestOperation setCompletionBlockWithSuccess:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
         
         NSArray* results = mappingResult.array;
         if ([[results firstObject] isKindOfClass:[DGArtist class]]) {
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

- (void) getArtistReleases:(DGArtistReleaseRequest*)request success:(void (^)(DGArtistReleaseResponse* response))success failure:(void (^)(NSError* error))failure {
    DGCheckReachability();
    
    NSURLRequest *requestURL = [self.manager requestWithObject:request method:RKRequestMethodGET path:nil parameters:request.parameters];
    
    RKObjectRequestOperation *objectRequestOperation = [[RKObjectRequestOperation alloc] initWithRequest:requestURL responseDescriptors:@[ [DGArtistReleaseResponse responseDescriptor] ]];
    
    [objectRequestOperation setCompletionBlockWithSuccess:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
         NSArray* results = mappingResult.array;
         if ([[results firstObject] isKindOfClass:[DGArtistReleaseResponse class]]) {
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

- (void) getRelease:(NSNumber*)releaseID success:(void (^)(DGRelease* release))success failure:(void (^)(NSError* error))failure {
    DGCheckReachability();
    
    DGRelease* release  = [DGRelease release];
    release.ID          = releaseID;
    
    NSURLRequest *requestURL = [self.manager requestWithObject:release method:RKRequestMethodGET path:nil parameters:nil];
    
    RKObjectRequestOperation *objectRequestOperation = [[RKObjectRequestOperation alloc] initWithRequest:requestURL responseDescriptors:@[ [DGRelease responseDescriptor] ]];
    
    [objectRequestOperation setCompletionBlockWithSuccess:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
         NSArray* results = mappingResult.array;
         if ([[results firstObject] isKindOfClass:[DGRelease class]]) {
             DGRelease* release = [results firstObject];
             
             success(release);
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

- (void) getMaster:(NSNumber*)masterID success:(void (^)(DGMaster* master))success failure:(void (^)(NSError* error))failure {
    DGCheckReachability();
    
    DGMaster* master    = [DGMaster master];
    master.ID           = masterID;
    
    NSURLRequest *requestURL = [self.manager requestWithObject:master method:RKRequestMethodGET path:nil parameters:nil];
    
    RKObjectRequestOperation *objectRequestOperation = [[RKObjectRequestOperation alloc] initWithRequest:requestURL responseDescriptors:@[ [DGMaster responseDescriptor] ]];
    
    [objectRequestOperation setCompletionBlockWithSuccess:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
         NSArray* results = mappingResult.array;
         if ([[results firstObject] isKindOfClass:[DGMaster class]]) {
             DGMaster* master = [results firstObject];
             
             success(master);
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

- (void) getMasterVersion:(DGMasterVersionRequest*)request success:(void (^)(DGMasterVersionResponse* response))success failure:(void (^)(NSError* error))failure {
    DGCheckReachability();
    
    NSURLRequest *requestURL = [self.manager requestWithObject:request method:RKRequestMethodGET path:nil parameters:request.parameters];
    
    RKObjectRequestOperation *objectRequestOperation = [[RKObjectRequestOperation alloc] initWithRequest:requestURL responseDescriptors:@[ [DGMasterVersionResponse responseDescriptor] ]];
    
    [objectRequestOperation setCompletionBlockWithSuccess:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
         NSArray* results = mappingResult.array;
         if ([[results firstObject] isKindOfClass:[DGMasterVersionResponse class]]) {
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

- (void) getLabel:(NSNumber*)labelID success:(void (^)(DGLabel* label))success failure:(void (^)(NSError* error))failure {
    DGCheckReachability();
    
    DGLabel* label  = [DGLabel label];
    label.ID        = labelID;
    
    NSURLRequest *requestURL = [self.manager requestWithObject:label method:RKRequestMethodGET path:nil parameters:nil];
    
    RKObjectRequestOperation *objectRequestOperation = [[RKObjectRequestOperation alloc] initWithRequest:requestURL responseDescriptors:@[ [DGLabel responseDescriptor] ]];
    
    [objectRequestOperation setCompletionBlockWithSuccess:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
         NSArray* results = mappingResult.array;
         if ([[results firstObject] isKindOfClass:[DGLabel class]]) {
             DGLabel* label = [results firstObject];
             
             success(label);
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

- (void) getLabelReleases:(DGLabelReleasesRequest*)request success:(void (^)(DGLabelReleasesResponse* response))success failure:(void (^)(NSError* error))failure {
    DGCheckReachability();
    
    NSURLRequest *requestURL = [self.manager requestWithObject:request method:RKRequestMethodGET path:nil parameters:request.parameters];
    
    RKObjectRequestOperation *objectRequestOperation = [[RKObjectRequestOperation alloc] initWithRequest:requestURL responseDescriptors:@[ [DGLabelReleasesResponse responseDescriptor] ]];
    
    [objectRequestOperation setCompletionBlockWithSuccess:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
         NSArray* results = mappingResult.array;
         if ([[results firstObject] isKindOfClass:[DGLabelReleasesResponse class]]) {
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

@end
