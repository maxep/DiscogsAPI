// DiscogsAPI.m
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

#import "DiscogsAPI.h"
#import "DGEndpoint+Configuration.h"

static DiscogsAPI * sharedClient = nil;

@interface DiscogsAPI ()
@property (nonatomic, strong) DGAuthentication * authentication;
@property (nonatomic, strong) DGDatabase       * database;
@property (nonatomic, strong) DGUser           * user;
@property (nonatomic, strong) DGResource       * resource;
@property (nonatomic, readwrite) BOOL          isReachable;
@end

@implementation DiscogsAPI

+ (void) setSharedClient:(DiscogsAPI*)discogsAPI {
    sharedClient = discogsAPI;
}

+ (DiscogsAPI*) sharedClient {
    return sharedClient;
}

+ (DiscogsAPI*) discogsWithConsumerKey:(NSString*) consumerKey consumerSecret:(NSString*) consumerSecret {
    return [[DiscogsAPI alloc] initWithConsumerKey:consumerKey consumerSecret:consumerSecret];
}

- (id) initWithConsumerKey:(NSString*) consumerKey consumerSecret:(NSString*) consumerSecret {
    self = [super init];
    if (self) {
        
        RKLogConfigureByName("RestKit/Network", RKLogLevelTrace);
        
        self.authentication = [DGAuthentication authenticationWithConsumerKey:consumerKey consumerSecret:consumerSecret];
        self.authentication.delegate = self;
        
        RKObjectManager *objectManager = [[RKObjectManager alloc] initWithHTTPClient:[self.authentication oAuth1Client]];
        objectManager.requestSerializationMIMEType = RKMIMETypeJSON;
        
        //Set up database
        self.database           = [DGDatabase database];
        self.database.delegate  = self;
        [self.database configureManager:objectManager];
        
        //Set up user
        self.user           = [DGUser user];
        self.user.delegate  = self;
        [self.user configureManager:objectManager];
        
        //Set up resource
        self.resource   = [DGResource resource];
        self.resource.delegate = self;
        
        [objectManager addResponseDescriptor:[RKErrorMessage responseDescriptor]];

        [AFNetworkActivityIndicatorManager sharedManager].enabled = YES;
        
        [objectManager.HTTPClient setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
            [self setReachability:status];
        }];
        [self setReachability:objectManager.HTTPClient.networkReachabilityStatus];
        
        [RKObjectManager setSharedManager:objectManager];
    }
    return self;
}

- (void) setReachability:(AFNetworkReachabilityStatus) status {
    if (status == AFNetworkReachabilityStatusNotReachable) {
        self.isReachable = NO;
    }
    else {
        self.isReachable = YES;
    }
}

- (void) identifyUserWithSuccess:(void (^)())success failure:(void (^)(NSError* error))failure {
    [self.user identityWithSuccess:^(DGIdentity *identity) {
        success();
    } failure:failure];
}

- (void) startOperation:(RKObjectRequestOperation*) requestOperation {
 //   [requestOperation start];
    [[RKObjectManager sharedManager] enqueueObjectRequestOperation:requestOperation];
}

- (NSOperation*) createImageRequestOperationWithUrl:(NSString*)url success:(void (^)(UIImage*image))success failure:(void (^)(NSError* error))failure {
    return [self.resource createImageRequestOperationWithUrl:url success:success failure:failure];
}

- (void) cancelAllOperations {
    [RKObjectManager.sharedManager.operationQueue cancelAllOperations];
}

- (void) isAuthenticated:(void (^)(BOOL success))success {
    
    [self identifyUserWithSuccess:^{
        success(YES);
    } failure:^(NSError *error) {
        
        if (error.code == NSURLErrorNotConnectedToInternet && self.authentication.oAuth1Client.accessToken) {
            success(YES);
        }
        else {
            success(NO);
        }
        
    }];
}

@end
