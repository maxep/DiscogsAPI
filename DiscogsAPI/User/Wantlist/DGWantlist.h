// DGWantlist.h
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
#import "DGEndpoint.h"
#import "DGPagination.h"
#import "DGRelease.h"

@interface DGWant : DGObject

@property (nonatomic, strong) NSNumber  *rating;
@property (nonatomic, strong) NSString  *notes;
@property (nonatomic, strong) DGRelease *DGRelease;

+ (DGWant *)want;

@end

@interface DGWantRequest : NSObject

@property (nonatomic, strong) NSString *userName;
@property (nonatomic, strong) NSNumber *releaseID;
@property (nonatomic, strong) NSString *notes;
@property (nonatomic, strong) NSNumber *rating;

+ (DGWantRequest *)request;

@end

@interface DGWantlistRequest : NSObject

@property (nonatomic, strong) DGPagination  *pagination;
@property (nonatomic, strong) NSString      *userName;

+ (DGWantlistRequest *)request;

@end

@interface DGWantlistResponse : NSObject <DGPaginated>
@property (nonatomic, strong) NSArray<DGWant *> *wants;

+ (DGWantlistResponse *)response;

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
- (void)getWantlist:(DGWantlistRequest *)request success:(void (^)(DGWantlistResponse *response))success failure:(void (^)(NSError *error))failure;

/**
 Add release to user's wantlist.
 
 @param request The request.
 @param success A block object to be executed when the get operation finishes successfully. This block has no return value and one argument: the wanted release.
 @param failure A block object to be executed when the synchronization operation finishes unsuccessfully. This block has no return value and takes one argument: The `NSError` object describing the error that occurred.
 */
- (void)addToWantlist:(DGWantRequest *)request success:(void (^)(DGWant *want))success failure:(void (^)(NSError *error))failure;

/**
 Edit release in user's wantlist.
 
 @param request The request.
 @param success A block object to be executed when the get operation finishes successfully. This block has no return value and one argument: the wanted release.
 @param failure A block object to be executed when the synchronization operation finishes unsuccessfully. This block has no return value and takes one argument: The `NSError` object describing the error that occurred.
 */
- (void)editReleaseInWantlist:(DGWantRequest *)request success:(void (^)(DGWant* want))success failure:(void (^)(NSError *error))failure;

/**
 Delete release from user's wantlist.
 
 @param request The request.
 @param success A block object to be executed when the get operation finishes successfully. This block has no return value no argument: the wanted release.
 @param failure A block object to be executed when the synchronization operation finishes unsuccessfully. This block has no return value and takes one argument: The `NSError` object describing the error that occurred.
 */
- (void)deleteReleaseFromWantlist:(DGWantRequest *)request success:(void (^)())success failure:(void (^)(NSError *error))failure;

@end
