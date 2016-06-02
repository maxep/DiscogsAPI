// DGEndpoint.h
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

#import <Foundation/Foundation.h>

/**
 Defines of a progress block.
 
 @param numberOfFinishedOperations Number of finished operations.
 @param totalNumberOfOperations    Total number of operations.
 */
typedef void (^DGProgressBlock) (NSUInteger numberOfFinishedOperations, NSUInteger totalNumberOfOperations);

/**
 DGEndpoint delegate protocol.
 */
@protocol DGEndpointDelegate <NSObject>

/**
 Tells whether or not Discogs API is reachable.
 
 @return Discogs API reachability.
 */
@required
- (BOOL) isReachable;

/**
 Identifies the user. This method will verify that the user stored in the depot still authorize the current OAuth token.
 
 @param success A block object to be executed when the search operation finishes successfully. This block has no return value and no argument.
 @param failure A block object to be executed when the synchronization operation finishes unsuccessfully. This block has no return value and takes one argument: The `NSError` object describing the error that occurred.
 */
@required
- (void) identifyUserWithSuccess:(void (^)())success failure:(void (^)(NSError* error))failure;

/**
 Creates an Image request for AFNetworking (https://github.com/AFNetworking/AFNetworking ).
 
 @param url     The Discogs image URL.
 @param success A block object to be executed when the get operation finishes successfully. This block has no return value and one argument: the image.
 @param failure A block object to be executed when the synchronization operation finishes unsuccessfully. This block has no return value and takes one argument: The `NSError` object describing the error that occurred.
 
 @return The image request operation.
 */
@required
- (NSOperation*) createImageRequestOperationWithUrl:(NSString*)url success:(void (^)(UIImage*image))success failure:(void (^)(NSError* error))failure;

@end

/**
 Discogs api endpoint superclass.
 */
@interface DGEndpoint : NSObject

/**
 Delegate instance.
 */
@property (nonatomic, assign) id /*<DGEndpointDelegate>*/ delegate;

/**
 Progress block property.
 */
@property (nonatomic, strong) DGProgressBlock progress;

/**
 Creates an NSError.
 
 @param code Error code.
 @param info Error info.
 
 @return The created NSError.
 */
- (NSError*)errorWithCode:(NSInteger)code info:(NSString*)info;

- (instancetype)init NS_UNAVAILABLE;
+ (instancetype)new NS_UNAVAILABLE;

@end
