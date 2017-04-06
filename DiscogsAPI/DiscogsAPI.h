// DiscogsAPI.h
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

#import <Foundation/Foundation.h>

#import "DGAuthentication.h"
#import "DGDatabase.h"
#import "DGUser.h"
#import "DGResource.h"
#import "DGMarketplace.h"

NS_ASSUME_NONNULL_BEGIN

/**
 If you are requesting information from an endpoint that may have text formatting in it, you can choose which kind of formatting you want to be returned by settin the media type. We currently support 3 types:

 - DGDiscogsMediaType: Discogs format {@see https://www.discogs.com/help/text-formatting.html}
 - DGHTMLMediaType: HTML format.
 - DGPlainTextMediaType: Plain text format.
 */
typedef NS_ENUM(NSInteger, DGMediaType){
    DGDiscogsMediaType = 0,
    DGHTMLMediaType,
    DGPlainTextMediaType
};

/**
 Discogs API client class to manage client initialization and api endpoints.
 */
@interface Discogs : DGEndpoint

/**
 Autentication endpoint.
 */
@property (nonatomic, readonly) DGAuthentication *authentication;

/**
 Database endpoint.
 */
@property (nonatomic, readonly) DGDatabase *database;

/**
 User endpoint.
 */
@property (nonatomic, readonly) DGUser *user;

/**
 Marketplace endpoint.
 */
@property (nonatomic, readonly) DGMarketplace *marketplace;

/**
 Resource endpoint.
 */
@property (nonatomic, readonly) DGResource *resource;

/**
 Media Type.
 */
@property (nonatomic,readwrite) DGMediaType mediaType;

/**
 The operation queue which manages endpoints requests.
 */
@property (nonatomic, strong) NSOperationQueue *operationQueue;

/**
 Sets the application consumer key and secret.
 This method should be called before any call to `Discogs.api`.
 
 @param key The consumer key.
 @param secret The consumer secret.
 */
+ (void)setConsumerKey:(NSString *)key consumerSecret:(NSString *)secret;

/**
 Sets the application personal access token.
 This method should be called before any call to `Discogs.api`.
 
 @param token The personal access token.
 */
+ (void)setPersonalAccessToken:(NSString *)token;

/**
 The shared discogs api client.
 
 @return The shared discogs api client.
 */
@property (class, readonly) Discogs *api;

@end

@interface DiscogsAPI : Discogs

+ (Discogs *)client DEPRECATED_MSG_ATTRIBUTE("[DiscogsAPI client] has been renamed to [Discogs api]");

@end

NS_ASSUME_NONNULL_END
