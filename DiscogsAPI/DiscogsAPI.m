// DiscogsAPI.m
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

#import "DiscogsAPI.h"
#import "DGEndpoint+Private.h"
#import "DGHTTPClient.h"

static NSString * const kDiscogsConsumerKey    = @"DiscogsConsumerKey";
static NSString * const kDiscogsConsumerSecret = @"DiscogsConsumerSecret";
static NSString * const kDiscogsAccessToken    = @"DiscogsAccessToken";

NSString *DGMediaTypeAsString(DGMediaType type) {
    return @[@"discogs", @"html", @"plaintext"][type];
}

DGMediaType DGMediaTypeFromString(NSString *str) {
    return [@{@"discogs":@0, @"html":@1, @"plaintext":@2}[str] integerValue];
}

@implementation Discogs

static NSString * ConsumerKey    = nil;
static NSString * ConsumerSecret = nil;
static NSString * AccessToken    = nil;

+ (void)setConsumerKey:(NSString *)key consumerSecret:(NSString *)secret {
    ConsumerKey = key;
    ConsumerSecret = secret;
    AccessToken = nil;
}

+ (void)setPersonalAccessToken:(NSString *)token {
    ConsumerKey = nil;
    ConsumerSecret = nil;
    AccessToken = token;
}

+ (Discogs *)api {
    static Discogs *discogs = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        NSString *consumerKey    = ConsumerKey?:    [[NSBundle mainBundle] objectForInfoDictionaryKey:kDiscogsConsumerKey];
        NSString *consumerSecret = ConsumerSecret?: [[NSBundle mainBundle] objectForInfoDictionaryKey:kDiscogsConsumerSecret];
        NSString *accessToken    = AccessToken?:    [[NSBundle mainBundle] objectForInfoDictionaryKey:kDiscogsAccessToken];
        
        DGObjectManager *manager = nil;
        if (consumerKey && consumerSecret) {
            manager = [DGObjectManager managerWithConsumerKey:consumerKey consumerSecret:consumerSecret];
        } else if(accessToken) {
            manager = [DGObjectManager managerWithPersonalAccessToken:accessToken];
        } else {
            manager = [DGObjectManager manager];
        }
        
        //Setup client
        discogs = [[Discogs alloc] initWithManager:manager];
        
        AFRKNetworkActivityIndicatorManager.sharedManager.enabled = YES;
    });
    
    return discogs;
}

- (instancetype)initWithManager:(DGObjectManager *)manager {
    self = [super initWithManager:manager];
    if (self) {
        //Create and configure endpoints
        _authentication = [[DGAuthentication alloc] initWithManager:manager];
        _database       = [[DGDatabase alloc] initWithManager:manager];
        _user           = [[DGUser alloc] initWithManager:manager];
        _marketplace    = [[DGMarketplace alloc] initWithManager:manager];
        _resource       = [[DGResource alloc] initWithManager:manager];
    }
    return self;
}

#pragma mark Properties

- (DGMediaType)mediaType {
    return DGMediaTypeFromString(self.manager.HTTPClient.mediaType);
}

- (void)setMediaType:(DGMediaType)mediaType {
    self.manager.HTTPClient.mediaType = DGMediaTypeAsString(mediaType);
}

@end

@implementation DiscogsAPI

+ (Discogs *)client {
    return [Discogs api];
}

@end
