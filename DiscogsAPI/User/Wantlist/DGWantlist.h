// DGWantlist.h
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
#import "DGEndpoint.h"
#import "DGPagination.h"
#import "DGRelease.h"

NS_ASSUME_NONNULL_BEGIN

/**
 A wanted release reprsentation.
 */
@interface DGWant : DGObject

/// The release rating.
@property (nonatomic, strong, nullable) NSNumber  *rating;

/// The release notes.
@property (nonatomic, strong, nullable) NSString  *notes;

/// The wanted release.
@property (nonatomic, strong, nullable) DGRelease *basicInformation;

@end

/**
 Request a wanted release.
 */
@interface DGWantRequest : NSObject

/// The user name.
@property (nonatomic, strong) NSString *userName;

/// The wanted release ID.
@property (nonatomic, strong) NSNumber *releaseID;

/// The release notes.
@property (nonatomic, strong) NSString *notes;

/// The release rating.
@property (nonatomic, strong) NSNumber *rating;

@end

/**
 Request the user wantlist.
 */
@interface DGWantlistRequest : NSObject

/// The paginated parameters.
@property (nonatomic, strong) DGPagination  *pagination;

/// The user name.
@property (nonatomic, strong) NSString *userName;

@end

/**
 The paginated wantlist response.
 */
@interface DGWantlistResponse : NSObject <DGPaginated>

/**
 The want list.
 */
@property (nonatomic, strong) NSArray<DGWant *> *wants;

@end

/**
 The DGWantlist class to manage operation with User's wantlist.
 */
@interface DGWantlist : DGEndpoint

/**
 Gets the user's wantlist.
 
 @param request The paginated wantlist request.
 @param success A block object to be executed when the get operation finishes successfully. This block has no return value and one argument: the paginated wantlist response.
 @param failure A block object to be executed when the synchronization operation finishes unsuccessfully. This block has no return value and takes one argument: The `NSError` object describing the error that occurred.
 */
- (void)getWantlist:(DGWantlistRequest *)request success:(void (^)(DGWantlistResponse *response))success failure:(nullable DGFailureBlock)failure NS_SWIFT_NAME(get(_:success:failure:));

/**
 Add release to user's wantlist.
 
 @param request The request.
 @param success A block object to be executed when the get operation finishes successfully. This block has no return value and one argument: the wanted release.
 @param failure A block object to be executed when the synchronization operation finishes unsuccessfully. This block has no return value and takes one argument: The `NSError` object describing the error that occurred.
 */
- (void)addToWantlist:(DGWantRequest *)request success:(void (^)(DGWant *want))success failure:(nullable DGFailureBlock)failure NS_SWIFT_NAME(add(_:success:failure:));

/**
 Edit release in user's wantlist.
 
 @param request The request.
 @param success A block object to be executed when the get operation finishes successfully. This block has no return value and one argument: the wanted release.
 @param failure A block object to be executed when the synchronization operation finishes unsuccessfully. This block has no return value and takes one argument: The `NSError` object describing the error that occurred.
 */
- (void)editReleaseInWantlist:(DGWantRequest *)request success:(void (^)(DGWant *want))success failure:(nullable DGFailureBlock)failure NS_SWIFT_NAME(edit(_:success:failure:));

/**
 Delete release from user's wantlist.
 
 @param request The request.
 @param success A block object to be executed when the get operation finishes successfully. This block has no return value no argument: the wanted release.
 @param failure A block object to be executed when the synchronization operation finishes unsuccessfully. This block has no return value and takes one argument: The `NSError` object describing the error that occurred.
 */
- (void)deleteReleaseFromWantlist:(DGWantRequest *)request success:(void (^)(void))success failure:(nullable DGFailureBlock)failure NS_SWIFT_NAME(delete(_:success:failure:));

@end

NS_ASSUME_NONNULL_END
