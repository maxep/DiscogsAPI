// DGHTTPClient.m
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

#import "AFOAuth1Client.h"

FOUNDATION_EXTERN NSString * const kDGBaseURL;

/**
 `DGHTTPClient` encapsulates common patterns to authenticate against the Discogs API server.
 
 @see The Discogs Auth Protocol: http://www.discogs.com/developers/#page:authentication,header:authentication-discogs-auth-flow
 @see RFC 5849 The OAuth 1.0 Protocol: https://tools.ietf.org/html/rfc5849
 */
@interface DGHTTPClient : AFOAuth1Client

/**
 Application media type: 'html', 'plaintext' or 'discogs'.
 */
@property (nonatomic, copy) NSString *mediaType;

/**
 Creates and initializes a `DGHTTPClient` object.
 
 @return The newly-initialized Discogs client object.
 */
+ (DGHTTPClient *)client;

/**
 Creates and initializes a `DGHTTPClient` object.
 
 @param key    The Discogs app consumer key.
 @param secret The Discogs app consumer secret.
 
 @return The newly-initialized Discogs client object.
 */
+ (DGHTTPClient *)clientWithConsumerKey:(NSString *)key consumerSecret:(NSString *)secret;

/**
 Creates and initializes a `DGHTTPClient` object.
 
 @param token The Discogs personal access token.
 
 @return The newly-initialized Discogs client object.
 */
+ (DGHTTPClient *)clientWithAccessToken:(NSString *)token;

/**
 Initializes an `DGHTTPClient` object with the specified consumer key and secret.
 
 @param key The consumer key.
 @param secret The consumer secret.
 */
- (id)initWithConsumerKey:(NSString *)key consumerSecret:(NSString *)secret;

/**
 Initializes an `DGHTTPClient` object with the specified access token.
 
 @param token The personal access token.
 */
- (id)initWithAccessToken:(NSString *)token;

/**
 Creates and enqueues `AFHTTPRequestOperation` objects to make the necessary request token and access token requests.
 
 @param callbackURL The callback URL.
 @param success A block object to be executed when the request operation finishes successfully. This block has no return value and takes two arguments: the OAuth credential returned by the server, and the response object sent from the server.
 @param failure A block object to be executed when the request operation finishes unsuccessfully, or that finishes successfully, but encountered an error while parsing the response data. This block has no return value and takes a single argument: the error returned from the server.
 */
- (void)authorizeUsingOAuthWithCallbackURL:(NSURL *)callbackURL
                                   success:(void (^)(AFOAuth1Token *accessToken, id responseObject))success
                                   failure:(void (^)(NSError *error))failure;

@end
