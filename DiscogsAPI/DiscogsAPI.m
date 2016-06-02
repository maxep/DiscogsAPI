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
#import "DGAuthentication+HTTPCLient.h"

#import "DGHTTPClient.h"

#define kDGMediaTypeAsString(enum) @[@"discogs", @"html", @"plaintext"][enum]
#define kStringDGMediaType(str) [@{@"discogs":@0, @"html":@1, @"plaintext":@2}[str] integerValue]

@interface DiscogsAPI ()
@property (nonatomic, strong) DGAuthentication  *authentication;
@property (nonatomic, strong) DGDatabase        *database;
@property (nonatomic, strong) DGUser            *user;
@property (nonatomic, strong) DGMarketplace     *marketplace;
@property (nonatomic, strong) DGResource        *resource;
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
        RKObjectManager *objectManager = [RKObjectManager managerWithBaseURL:[NSURL URLWithString: kDGBaseURL]];// [[RKObjectManager alloc] initWi];
//        objectManager.requestSerializationMIMEType = RKMIMETypeJSON;
        
        //Configure Object manager
        self.authentication = [[DGAuthentication alloc] initWithManager:objectManager];
        self.authentication.delegate = self;
        
        self.database       = [[DGDatabase alloc] initWithManager:objectManager];
        self.database.delegate = self;
        
        self.user           = [[DGUser alloc] initWithManager:objectManager];
        self.user.delegate = self;
        
        self.marketplace    = [[DGMarketplace alloc] initWithManager:objectManager];
        self.marketplace.delegate = self;
        
        self.resource       = [[DGResource alloc] initWithManager:objectManager];
        self.resource.delegate = self;
        
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

- (void)cancelAllOperations {
    [RKObjectManager.sharedManager.operationQueue cancelAllOperations];
}

- (void)isAuthenticated:(void (^)(BOOL success))success {
    
    [self identifyUserWithSuccess:^{
        success(YES);
    } failure:^(NSError *error) {
        success(    error.code == NSURLErrorNotConnectedToInternet/* &&
                    self.authentication.oAuth1Client.accessToken*/);
    }];
}

#pragma mark Private Methods

- (void)setReachability:(AFNetworkReachabilityStatus) status {
    self.isReachable = status != AFNetworkReachabilityStatusNotReachable;
}

#pragma mark Properties

- (DGMediaType)mediaType {
    return kStringDGMediaType(self.authentication.HTTPClient.mediaType);
}

- (void)setMediaType:(DGMediaType)mediaType {
    self.authentication.HTTPClient.mediaType = kDGMediaTypeAsString(mediaType);
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
