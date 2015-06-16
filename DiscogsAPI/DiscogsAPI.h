// DiscogsAPI.h
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

#import <Foundation/Foundation.h>

#import "DGAuthentication.h"
#import "DGDatabase.h"
#import "DGUser.h"
#import "DGResource.h"

/**
 Discogs API client class to manage client initialization and api endpoints.
 */
@interface DiscogsAPI : NSObject <DGEndpointDelegate>

/**
 Autentication endpoint.
 */
@property (nonatomic, readonly) DGAuthentication * authentication;

/**
 Database endpoint.
 */
@property (nonatomic, readonly) DGDatabase * database;

/**
 User endpoint.
 */
@property (nonatomic, readonly) DGUser * user;

/**
 Resource endpoint.
 */
@property (nonatomic, readonly) DGResource * resource;

/**
 Network reachability.
 */
@property (nonatomic, readonly, getter=isReachable) BOOL isReachable;

/**
 Sets the discogs api shared client.
 
 @param discogsAPI The discogs api client.
 */
+ (void) setSharedClient:(DiscogsAPI*)discogsAPI;

/**
 Get the discogs api shared client.
 
 @return The shared discogs api client.
 */
+ (DiscogsAPI*) sharedClient;

/**
 Creates a discogs api client.
 
 @param consumerKey    The application consumer key.
 @param consumerSecret The application comsumer secret.
 
 @return The newly-initialized discogs api client object.
 */
+ (DiscogsAPI*) discogsWithConsumerKey:(NSString*) consumerKey consumerSecret:(NSString*) consumerSecret;

/**
 Initializes a discogs api client.
 
 @param consumerKey    The application consumer key.
 @param consumerSecret The application comsumer secret.
 
 @return The initialized discogs api client object.
 */
- (id) initWithConsumerKey:(NSString*) consumerKey consumerSecret:(NSString*) consumerSecret;

/**
 Cancell all queued and current operations with Discogs.
 */
- (void) cancelAllOperations;

- (void) isAuthenticated:(void (^)(BOOL success))success;

@end
