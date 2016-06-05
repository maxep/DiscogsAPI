// DGUser.h
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

#import "DGEndpoint.h"
#import "DGIdentity.h"
#import "DGProfile.h"
#import "DGCollection.h"
#import "DGWantlist.h"

NS_ASSUME_NONNULL_BEGIN

/**
 The DGUser class to manage operation with Discogs Users.
 */
@interface DGUser : DGEndpoint

/**
 The wantlist endpoint.
 */
@property (nonatomic,readonly) DGWantlist *wantlist;

/**
 The collection endpoint.
 */
@property (nonatomic,readonly) DGCollection *collection;

/**
 Gets authentified user identity.
 
 @param success A block object to be executed when the get operation finishes successfully. This block has no return value and one argument: the user identity.
 @param failure A block object to be executed when the synchronization operation finishes unsuccessfully. This block has no return value and takes one argument: The `NSError` object describing the error that occurred.
 */
- (void)identityWithSuccess:(void (^)(DGIdentity *identity))success failure:(nullable DGFailureBlock)failure;

/**
 Gets a user profile
 
 @param userName The user's name.
 @param success  A block object to be executed when the get operation finishes successfully. This block has no return value and one argument: the user profile.
 @param failure  A block object to be executed when the synchronization operation finishes unsuccessfully. This block has no return value and takes one argument: The `NSError` object describing the error that occurred.
 */
- (void)getProfile:(NSString *)userName success:(void (^)(DGProfile *profile))success failure:(nullable DGFailureBlock)failure;

/**
 Edit a user’s profile data
 
 @param profile The edited user's profile.
 @param success  A block object to be executed when the get operation finishes successfully. This block has no return value and one argument: the edited user profile.
 @param failure  A block object to be executed when the synchronization operation finishes unsuccessfully. This block has no return value and takes one argument: The `NSError` object describing the error that occurred.
 */
- (void)editProfile:(DGProfile *)profile success:(void (^)(DGProfile *profile))success failure:(nullable DGFailureBlock)failure;

@end

NS_ASSUME_NONNULL_END
