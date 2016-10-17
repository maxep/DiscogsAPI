// DGOperation.h
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

#import <RestKit/RestKit.h>
#import "DGMapping.h"

/**
 `DGOperation` is an `RKObjectRequestOperation` subclass that uses `DGResponseObject` class to perform response mapping.
 */
@interface DGOperation<DGResponseType> : RKObjectRequestOperation

/**
 Creates and initializers an operation with the given URL request and map to the response class.

 @param request       The request object to be used with the underlying network operation.
 @param responseClass An class adopting the `DGResponseObject` protocol specifying how object mapping is to be performed on the response loaded by the network operation.

 @return The newly-initialized operation.
 */
+ (instancetype)operationWithRequest:(NSURLRequest *)request responseClass:(Class<DGResponseObject>)responseClass;

/**
 Initializers an operation with the given URL request and map to the response class.

 @param request       The request object to be used with the underlying network operation.
 @param responseClass An class adopting the `DGResponseObject` protocol specifying how object mapping is to be performed on the response loaded by the network operation.

 @return The initialized operation.
 */
- (instancetype)initWithRequest:(NSURLRequest *)request responseClass:(Class<DGResponseObject>)responseClass NS_DESIGNATED_INITIALIZER;

/**
 Sets the `completionBlock` property with a block that executes either the specified success or failure block, depending on the state of the object request on completion. 
 If `error` returns a value, which can be set during HTTP transport by the underlying `HTTPRequestOperation` or during object mapping by the `DGResponseObject` protocol, then `failure` is executed. 
 If the object request operation is cancelled, then the failure block will be executed with either a `RKOperationCancelledError` or a `NSURLErrorCancelled`, depending on the internal state of the operation at time of cancellation. Otherwise, `success` is executed.

 @param success The block to be executed on the completion of a successful operation. This block has no return value and takes one argument: the response object.
 @param failure The block to be executed on the completion of an unsuccessful operation. This block has no return value and takes two arguments: the receiver operation and the error that occurred during the execution of the operation.
 */
- (void)setCompletionBlockWithSuccess:(void (^)(DGResponseType response))success failure:(void (^)(NSError *error))failure;

@end

/**
 An RKObjectManager category that creates `DGOperation` objects.
 */
@interface RKObjectManager (DGOperation)

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
- (DGOperation *)operationWithRequest:(id<DGRequestObject>)request method:(RKRequestMethod)method responseClass:(Class<DGResponseObject>)responseClass;

@end
