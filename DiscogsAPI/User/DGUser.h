// DGUser.h
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

#import "DGEndpoint.h"
#import "DGIdentity.h"
#import "DGProfile.h"
#import "DGCollection.h"
#import "DGCollectionRelease.h"
#import "DGReleaseInstance.h"
#import "DGWantlist.h"

/**
 The DGUser to manage operation with Discogs Users.
 */
@interface DGUser : DGEndpoint

/**
 Creates and initializes an 'DGUser' object.
 
 @return The newly-initialized user object.
 */
+ (DGUser*) user;

/**
 Gets authentified user identity.
 
 @param success A block object to be executed when the get operation finishes successfully. This block has no return value and one argument: the user identity.
 @param failure A block object to be executed when the synchronization operation finishes unsuccessfully. This block has no return value and takes one argument: The `NSError` object describing the error that occurred.
 */
- (void) identityWithSuccess:(void (^)(DGIdentity* identity))success failure:(void (^)(NSError* error))failure;

/**
 Gets a user profile
 
 @param userName The user's name.
 @param success  A block object to be executed when the get operation finishes successfully. This block has no return value and one argument: the user profile.
 @param failure  A block object to be executed when the synchronization operation finishes unsuccessfully. This block has no return value and takes one argument: The `NSError` object describing the error that occurred.
 */
- (void) getProfile:(NSString*)userName success:(void (^)(DGProfile* profile))success failure:(void (^)(NSError* error))failure;

/**
 Gets the user's collection folders.
 
 @param userName The user's name.
 @param success  A block object to be executed when the get operation finishes successfully. This block has no return value and one argument: the collection folders.
 @param failure  A block object to be executed when the synchronization operation finishes unsuccessfully. This block has no return value and takes one argument: The `NSError` object describing the error that occurred.
 */
- (void) getCollectionFolders:(NSString*)userName success:(void (^)(DGCollectionFolders* collection))success failure:(void (^)(NSError* error))failure;

/**
 Gets a collection folder.
 
 @param request The collection folder request.
 @param success A block object to be executed when the get operation finishes successfully. This block has no return value and one argument: the collection folder.
 @param failure A block object to be executed when the synchronization operation finishes unsuccessfully. This block has no return value and takes one argument: The `NSError` object describing the error that occurred.
 */
- (void) getCollectionFolder:(DGCollectionFolderRequest*)request success:(void (^)(DGCollectionFolder* folder))success failure:(void (^)(NSError* error))failure;

/**
 Gets the collection releases.
 
 @param request The paginated collection releases request.
 @param success A block object to be executed when the get operation finishes successfully. This block has no return value and one argument: the paginated collection releases response.
 @param failure A block object to be executed when the synchronization operation finishes unsuccessfully. This block has no return value and takes one argument: The `NSError` object describing the error that occurred.
 */
- (void) getCollectionReleases:(DGCollectionReleasesRequest*)request success:(void (^)(DGCollectionReleasesResponse* folder))success failure:(void (^)(NSError* error))failure;

/**
 Gets the user's wantlist.
 
 @param request The paginatedwantlist request.
 @param success A block object to be executed when the get operation finishes successfully. This block has no return value and one argument: the paginated wantlist response.
 @param failure A block object to be executed when the synchronization operation finishes unsuccessfully. This block has no return value and takes one argument: The `NSError` object describing the error that occurred.
 */
- (void) getWantlist:(DGWantlistRequest*)request success:(void (^)(DGWantlistResponse* response))success failure:(void (^)(NSError* error))failure;

@end
