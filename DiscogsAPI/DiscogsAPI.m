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
#import "DGHTTPClient.h"

NSString *DGMediaTypeAsString(DGMediaType type) {
    return @[@"discogs", @"html", @"plaintext"][type];
}

DGMediaType StringDGMediaType(NSString *str) {
    return [@{@"discogs":@0, @"html":@1, @"plaintext":@2}[str] integerValue];
}

@interface Discogs ()
@property (nonatomic, strong) DGAuthentication  *authentication;
@property (nonatomic, strong) DGDatabase        *database;
@property (nonatomic, strong) DGUser            *user;
@property (nonatomic, strong) DGMarketplace     *marketplace;
@property (nonatomic, strong) DGResource        *resource;
@end

@implementation Discogs

+ (Discogs *)api {
    static Discogs *discogs = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        RKLogConfigureByName("RestKit/Network", RKLogLevelTrace);
        
        //Setup client
        RKObjectManager *manager = [RKObjectManager managerWithBaseURL:[NSURL URLWithString: kDGBaseURL]];
        discogs = [[Discogs alloc] initWithManager:manager];
        
        //Share Object Manager
        [RKObjectManager setSharedManager:manager];
        
        AFRKNetworkActivityIndicatorManager.sharedManager.enabled = YES;
    });
    
    return discogs;
}

#pragma mark Public Methods

- (instancetype)initWithManager:(RKObjectManager *)manager {
    self = [super initWithManager:manager];
    if (self) {
        //Create and configure endpoints
        self.authentication = [[DGAuthentication alloc] initWithManager:manager];
        self.database       = [[DGDatabase alloc] initWithManager:manager];
        self.user           = [[DGUser alloc] initWithManager:manager];
        self.marketplace    = [[DGMarketplace alloc] initWithManager:manager];
        self.resource       = [[DGResource alloc] initWithManager:manager];
    }
    return self;
}

- (void)cancelAllOperations {
    [self.manager.operationQueue cancelAllOperations];
}

- (void)isAuthenticated:(void (^)(BOOL success))success {
    
    [self.authentication identityWithSuccess:^(DGIdentity * _Nonnull identity) {
        success(YES);
    } failure:^(NSError *error) {
        success(    error.code == NSURLErrorNotConnectedToInternet/* &&
                    self.authentication.oAuth1Client.accessToken*/);
    }];
}

#pragma mark Properties

- (DGMediaType)mediaType {
    // TODO (maxep) : find a better way
    return StringDGMediaType([(DGHTTPClient *)self.manager.HTTPClient mediaType]);
}

- (void)setMediaType:(DGMediaType)mediaType {
    // TODO (maxep) : find a better way
    [(DGHTTPClient *)self.manager.HTTPClient setMediaType:DGMediaTypeAsString(mediaType)];
}

@end

@implementation DiscogsAPI

+ (Discogs *)client {
    return [Discogs api];
}

@end
