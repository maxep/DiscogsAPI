// DGDatabase.h
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
#import "DGSearch.h"
#import "DGArtist.h"
#import "DGArtistRelease.h"
#import "DGRelease.h"
#import "DGMaster.h"
#import "DGMasterVersion.h"
#import "DGLabel.h"
#import "DGLabelRelease.h"
#import "DGImage.h"
#import "DGVideo.h"
#import "DGMember.h"
#import "DGTrack.h"

/**
 Database class to manage operation with Discogs database.
 */
@interface DGDatabase : DGEndpoint

/**
 Creates and initializes a `DGDatabase` object.
 
 @return The newly-initialized Database object.
 */
+ (DGDatabase*) database;

/**
 Searches in Discogs database.
 
 @param request The search request.
 @param success A block object to be executed when the search operation finishes successfully. This block has no return value and one argument: the search response.
 @param failure A block object to be executed when the synchronization operation finishes unsuccessfully. This block has no return value and takes one argument: The `NSError` object describing the error that occurred.
 */
- (void) searchFor:(DGSearchRequest*)request success:(void (^)(DGSearchResponse* response))success failure:(void (^)(NSError* error))failure;

/**
 Gets an artist from Discogs database.
 
 @param artistID The requested artist ID.
 @param success  A block object to be executed when the get operation finishes successfully. This block has no return value and one argument: the artist.
 @param failure  A block object to be executed when the synchronization operation finishes unsuccessfully. This block has no return value and takes one argument: The `NSError` object describing the error that occurred.
 */
- (void) getArtist:(NSNumber*)artistID success:(void (^)(DGArtist* artist))success failure:(void (^)(NSError* error))failure;

/**
 Gets an artist's releases.
 
 @param request The paginated artist releases request.
 @param success A block object to be executed when the get operation finishes successfully. This block has no return value and one argument: the paginated artist releases response.
 @param failure A block object to be executed when the synchronization operation finishes unsuccessfully. This block has no return value and takes one argument: The `NSError` object describing the error that occurred.
 */
- (void) getArtistReleases:(DGArtistReleaseRequest*)request success:(void (^)(DGArtistReleaseResponse* response))success failure:(void (^)(NSError* error))failure;

/**
 Gets a release from Discogs database.
 
 @param releaseID The requested release ID.
 @param success   A block object to be executed when the get operation finishes successfully. This block has no return value and one argument: the release.
 @param failure   A block object to be executed when the synchronization operation finishes unsuccessfully. This block has no return value and takes one argument: The `NSError` object describing the error that occurred.
 */
- (void) getRelease:(NSNumber*)releaseID success:(void (^)(DGRelease* release))success failure:(void (^)(NSError* error))failure;

/**
 Gets a master release from Dsicogs database.
 
 @param masterID The master ID.
 @param success  A block object to be executed when the get operation finishes successfully. This block has no return value and one argument: the master release.
 @param failure  A block object to be executed when the synchronization operation finishes unsuccessfully. This block has no return value and takes one argument: The `NSError` object describing the error that occurred.
 */
- (void) getMaster:(NSNumber*)masterID success:(void (^)(DGMaster* master))success failure:(void (^)(NSError* error))failure;

/**
 Gets a label from Discogs database.
 
 @param labelID The label ID.
 @param success A block object to be executed when the get operation finishes successfully. This block has no return value and one argument: the label.
 @param failure A block object to be executed when the synchronization operation finishes unsuccessfully. This block has no return value and takes one argument: The `NSError` object describing the error that occurred.
 */
- (void) getLabel:(NSNumber*)labelID success:(void (^)(DGLabel* label))success failure:(void (^)(NSError* error))failure;

/**
 Gets a labels's releases.
 
 @param request The paginated label's releases request.
 @param success A block object to be executed when the get operation finishes successfully. This block has no return value and one argument: the paginated label releases response.
 @param failure A block object to be executed when the synchronization operation finishes unsuccessfully. This block has no return value and takes one argument: The `NSError` object describing the error that occurred.
 */
- (void) getLabelReleases:(DGLabelReleasesRequest*)request success:(void (^)(DGLabelReleasesResponse* response))success failure:(void (^)(NSError* error))failure;

/**
 Gets a master's versions
 
 @param request The master versions paginated request.
 @param success A block object to be executed when the get operation finishes successfully. This block has no return value and one argument: the paginated master releases response.
 @param failure A block object to be executed when the synchronization operation finishes unsuccessfully. This block has no return value and takes one argument: The `NSError` object describing the error that occurred.
 */
- (void) getMasterVersion:(DGMasterVersionRequest*)request success:(void (^)(DGMasterVersionResponse* response))success failure:(void (^)(NSError* error))failure;

@end
