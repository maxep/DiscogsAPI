// DGEndpoint.h
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

NS_ASSUME_NONNULL_BEGIN

/**
 Discogs HTTP error code.
 
 - DGErrorCodeUnauthorized: You’re attempting to access a resource that first requires authentication.
 - DGErrorCodeForbidden: You’re not allowed to access this resource. Even if you authenticated, or already have, you simply don’t have permission. Trying to modify another user’s profile, for example, will produce this error.
 - DGErrorCodeNotFound: The resource you requested doesn’t exist.
 - DGErrorCodeMethodNotAllowed: You’re trying to use an HTTP verb that isn’t supported by the resource. Trying to PUT to /artists/1, for example, will fail because Artists are read-only.
 - DGErrorCodeUnprocessableEntity: Your request was well-formed, but there’s something semantically wrong with the body of the request. This can be due to malformed JSON, a parameter that’s missing or the wrong type, or trying to perform an action that doesn’t make any sense. Check the response body for specific information about what went wrong.
 - DGErrorCodeInternalServerError: Something went wrong on our end while attempting to process your request. The response body’s message field will contain an error code that you can send to Discogs Support (which will help us track down your specific issue).
 */
typedef NS_ENUM(NSInteger, DGErrorCode){
    DGErrorCodeUnauthorized = 401,
    DGErrorCodeForbidden = 403,
    DGErrorCodeNotFound = 404,
    DGErrorCodeMethodNotAllowed = 405,
    DGErrorCodeUnprocessableEntity = 422,
    DGErrorCodeInternalServerError = 500
};

/**
 Discogs api endpoint superclass.
 */
@interface DGEndpoint : NSObject

/**
 A block that can act as a failure for a task.
 */
typedef void(^DGFailureBlock)(NSError * _Nullable error);

/**
 Endpoint operation queue.
 */
@property (nonatomic, readonly) NSOperationQueue *queue;

- (instancetype)init NS_UNAVAILABLE;
+ (instancetype)new NS_UNAVAILABLE;

@end

NS_ASSUME_NONNULL_END
