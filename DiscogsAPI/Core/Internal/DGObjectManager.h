// DGObjectManager.h
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

#import <RestKit/RestKit.h>

#import "DGHTTPClient.h"
#import "DGOperation.h"

NS_ASSUME_NONNULL_BEGIN

/**
 The `DGObjectManager` class provides a centralized interface for creating Discogs operations.
 */
@interface DGObjectManager : RKObjectManager

/**
 Creates and initializes a `DGObjectManager` object.
 
 @return The newly-initialized Discogs object manager.
 */
+ (instancetype)manager;

/**
 Creates and initializes a `DGObjectManager` object.
 
 @param key    The Discogs app consumer key.
 @param secret The Discogs app consumer secret.
 
 @return The newly-initialized Discogs object manager.
 */
+ (instancetype)managerWithConsumerKey:(NSString *)key consumerSecret:(NSString *)secret;

/**
 Creates and initializes a `DGObjectManager` object.
 
 @param token The Discogs personal access token.
 
 @return The newly-initialized Discogs object manager.
 */
+ (instancetype)managerWithPersonalAccessToken:(NSString *)token;

/**
 Initializes the receiver with the given Discogs HTTP client object, adopting the network configuration from the client.
 
 This is the designated initializer. If the `sharedManager` instance is `nil`, the receiver will be set as the `sharedManager`. The default headers and parameter encoding of the given HTTP client are adopted by the receiver to initialize the values of the `defaultHeaders` and `requestSerializationMIMEType` properties.
 
 @param client The Discogs HTTP client with which to initialize the receiver.
 @return The receiver, initialized with the given client.
 */
- (instancetype)initWithHTTPClient:(DGHTTPClient *)client NS_DESIGNATED_INITIALIZER;

/**
 The Discogs HTTP client with which the receiver makes requests.
 */
@property (nonatomic, strong, readwrite) DGHTTPClient *HTTPClient;

/**
 Creates a `DGOperation` operation with the given request object.
 
 @param request The request object.
 @param method  The HTTP method for request.
 
 @return The operation.
 */
- (DGOperation *)operationWithRequest:(id<DGRequestObject>)request method:(RKRequestMethod)method;

/**
 Creates a `DGOperation` operation with the given request object for the given response class.
 
 @param request       The request object.
 @param method        The HTTP method for request.
 @param responseClass The response class.
 
 @return The operation.
 */
- (DGOperation *)operationWithRequest:(id<DGRequestObject>)request method:(RKRequestMethod)method responseClass:(nullable Class<DGResponseObject>)responseClass;

/**
 Enqueues an `DGOperation` to the object manager's operation queue.
 
 @param operation The object request operation to be enqueued.
 */
- (void)enqueueOperation:(DGOperation *)operation;

@end

NS_ASSUME_NONNULL_END
