// DiscogsAPI.m
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

#import "DiscogsAPI.h"
#import "DGEndpoint+Configuration.h"

@interface DiscogsAPI ()
@property (nonatomic, strong) DGAuthentication  *authentication;
@property (nonatomic, assign) BOOL isReachable;
@end

@implementation DiscogsAPI

@synthesize database    = _database;
@synthesize user        = _user;
@synthesize resource    = _resource;
@synthesize marketplace = _marketplace;

+ (DiscogsAPI *) client {
    static DiscogsAPI *client = nil;
    
    if (!client) {
        client = [[DiscogsAPI alloc] init];
    }
    return client;
}

#pragma mark Public Methods

- (instancetype)init {
    if (self = [super init]) {
        
        RKLogConfigureByName("RestKit/Network", RKLogLevelTrace);
        
        //Setup Object Manager
        RKObjectManager *objectManager = [[RKObjectManager alloc] initWithHTTPClient:self.authentication.HTTPClient];
        objectManager.requestSerializationMIMEType = RKMIMETypeJSON;
        
        //Configure Object manager
        self.authentication.manager = objectManager;
        self.database.manager       = objectManager;
        self.user.manager           = objectManager;
        self.marketplace.manager    = objectManager;
        self.resource.manager       = objectManager;
        
        //Init reachability
        [objectManager.HTTPClient setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
            [self setReachability:status];
        }];
        [self setReachability:objectManager.HTTPClient.networkReachabilityStatus];
        
        //Share Object Manager
        [RKObjectManager setSharedManager:objectManager];
        
        AFNetworkActivityIndicatorManager.sharedManager.enabled = YES;
    }
    return self;
}

- (void) cancelAllOperations {
    [RKObjectManager.sharedManager.operationQueue cancelAllOperations];
}

- (void) isAuthenticated:(void (^)(BOOL success))success {
    
    [self identifyUserWithSuccess:^{
        success(YES);
    } failure:^(NSError *error) {
        success(    error.code == NSURLErrorNotConnectedToInternet/* &&
                    self.authentication.oAuth1Client.accessToken*/);
    }];
}

#pragma mark Private Methods

- (void) setReachability:(AFNetworkReachabilityStatus) status {
    self.isReachable = status != AFNetworkReachabilityStatusNotReachable;
}

#pragma mark Properties

- (DGAuthentication *)authentication {
    if (!_authentication) {
        _authentication = [DGAuthentication authentication];
        _authentication.delegate = self;
    }
    return _authentication;
}

- (DGDatabase *)database {
    if (!_database) {
        _database           = [DGDatabase database];
        _database.delegate  = self;
    }
    return _database;
}

- (DGUser *)user {
    if (!_user) {
        _user           = [DGUser user];
        _user.delegate  = self;
    }
    return _user;
}

- (DGMarketplace *)marketplace {
    if (!_marketplace) {
        _marketplace           = [DGMarketplace marketplace];
        _marketplace.delegate  = self;
    }
    return _marketplace;
}

- (DGResource *)resource {
    if (!_resource) {
        _resource           = [DGResource resource];
        _resource.delegate  = self;
    }
    return _resource;
}

- (DGMediaType)mediaType {
    return self.authentication.HTTPClient.mediaType;
}

- (void)setMediaType:(DGMediaType)mediaType {
    self.authentication.HTTPClient.mediaType = mediaType;
}

#pragma mark <DGEndpointDelegate>

- (void) identifyUserWithSuccess:(void (^)())success failure:(void (^)(NSError* error))failure {
    [self.user identityWithSuccess:^(DGIdentity *identity) {
        success();
    } failure:failure];
}

- (NSOperation*)createImageRequestOperationWithUrl:(NSString*)url success:(void (^)(UIImage*image))success failure:(void (^)(NSError* error))failure {
    return [self.resource createImageRequestOperationWithUrl:url success:success failure:failure];
}

@end
