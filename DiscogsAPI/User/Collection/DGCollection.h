// DGCollection.h
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

#import <Foundation/Foundation.h>
#import "DGEndpoint.h"
#import "DGPagination.h"
#import "DGReleaseInstance.h"

@interface DGCollectionFolderRequest : NSObject

@property (nonatomic, strong) NSNumber *folderID;
@property (nonatomic, strong) NSString *userName;

+ (DGCollectionFolderRequest*) request;

@end

@interface DGCollectionFolder : DGObject

@property (nonatomic, strong) NSNumber *count;
@property (nonatomic, strong) NSString *name;

+ (DGCollectionFolder*) folder;

@end

@interface DGCollectionFolders : NSObject

@property (nonatomic, strong) NSString *userName;
@property (nonatomic, strong) NSArray  *folders;

+ (DGCollectionFolders*) collection;

@end

@interface DGAddToCollectionFolderRequest : NSObject

@property (nonatomic, strong) NSString  *userName;
@property (nonatomic, strong) NSNumber  *releaseID;
@property (nonatomic, strong) NSNumber  *folderID;

+ (DGAddToCollectionFolderRequest*) request;

@end

@interface DGAddToCollectionFolderResponse : DGObject

+ (DGAddToCollectionFolderResponse*) response;

@end

@interface DGCollectionReleasesRequest : NSObject

@property (nonatomic, strong) DGPagination      *pagination;
@property (nonatomic, strong) NSString          *userName;
@property (nonatomic, strong) NSNumber          *folderID;
@property (nonatomic, readwrite) DGSortKey      sort;
@property (nonatomic, readwrite) DGSortOrder    sortOrder;

+ (DGCollectionReleasesRequest*) request;

@end

@interface DGCollectionReleasesResponse : NSObject

@property (nonatomic, strong) DGPagination  *pagination;
@property (nonatomic, strong) NSArray       *releases;

+ (DGCollectionReleasesResponse*) response;

- (void) loadNextPageWithSuccess:(void (^)())success failure:(void (^)(NSError* error))failure;

@end

/**
 The DGCollection class to manage operation with User's collection.
 */
@interface DGCollection : DGEndpoint

/**
 Creates and initializes an 'DGCollection' object.
 
 @return The newly-initialized collection object.
 */
+ (DGCollection*) collection;

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
 Add release to user's collection folder.
 
 @param request The request.
 @param success A block object to be executed when the get operation finishes successfully. This block has no return value and one argument: the response.
 @param failure A block object to be executed when the synchronization operation finishes unsuccessfully. This block has no return value and takes one argument: The `NSError` object describing the error that occurred.
 */
- (void) addToCollectionFolder:(DGAddToCollectionFolderRequest*)request success:(void (^)(DGAddToCollectionFolderResponse* response))success failure:(void (^)(NSError* error))failure;

/**
 Change release's rating.
 
 @param request The request.
 @param success A block object to be executed when the get operation finishes successfully. This block has no return value and no argument.
 @param failure A block object to be executed when the synchronization operation finishes unsuccessfully. This block has no return value and takes one argument: The `NSError` object describing the error that occurred.
 */
- (void) changeRatingOfRelease:(DGChangeRatingOfReleaseRequest*)request success:(void (^)())success failure:(void (^)(NSError* error))failure;

/**
 Delete release from user's collection folder.
 
 @param request The request.
 @param success A block object to be executed when the get operation finishes successfully. This block has no return value no argument: the wanted release.
 @param failure A block object to be executed when the synchronization operation finishes unsuccessfully. This block has no return value and takes one argument: The `NSError` object describing the error that occurred.
 */
- (void) deleteInstanceFromFolder:(DGReleaseInstanceRequest*)request success:(void (^)())success failure:(void (^)(NSError* error))failure;

/**
 Change the value of a notes field on a particular instance.
 
 @param request The request.
 @param success A block object to be executed when the get operation finishes successfully. This block has no return value and no argument.
 @param failure A block object to be executed when the synchronization operation finishes unsuccessfully. This block has no return value and takes one argument: The `NSError` object describing the error that occurred.
 */
- (void) editFieldsInstance:(DGEditFieldsInstanceRequest*)request success:(void (^)())success failure:(void (^)(NSError* error))failure;

@end
