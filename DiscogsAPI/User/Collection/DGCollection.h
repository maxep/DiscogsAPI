// DGCollection.h
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
#import "DGReleaseInstance.h"
#import "DGCollectionFolder.h"
#import "DGCollectionField.h"

NS_ASSUME_NONNULL_BEGIN

/**
 The DGCollection class to manage operation with User's collection.
 */
@interface DGCollection : DGEndpoint

/**
 Gets the user's collection folders.
 
 @param userName The user's name.
 @param success  A block object to be executed when the get operation finishes successfully. This block has no return value and one argument: the collection folders.
 @param failure  A block object to be executed when the synchronization operation finishes unsuccessfully. This block has no return value and takes one argument: The `NSError` object describing the error that occurred.
 */
- (void)getFolders:(NSString *)userName success:(void (^)(NSArray<DGCollectionFolder *> *folders))success failure:(nullable DGFailureBlock)failure;

/**
 Gets a collection folder.
 
 @param request The collection folder request.
 @param success A block object to be executed when the get operation finishes successfully. This block has no return value and one argument: the collection folder.
 @param failure A block object to be executed when the synchronization operation finishes unsuccessfully. This block has no return value and takes one argument: The `NSError` object describing the error that occurred.
 */
- (void)getFolder:(DGCollectionFolderRequest *)request success:(void (^)(DGCollectionFolder *folder))success failure:(nullable DGFailureBlock)failure;

/**
 Edits a collection folder.
 
 @param request The collection folder request.
 @param success A block object to be executed when the get operation finishes successfully. This block has no return value and one argument: the collection folder.
 @param failure A block object to be executed when the synchronization operation finishes unsuccessfully. This block has no return value and takes one argument: The `NSError` object describing the error that occurred.
 */
- (void)editFolder:(DGCollectionFolderRequest *)request success:(void (^)(DGCollectionFolder *folder))success failure:(nullable DGFailureBlock)failure;

/**
 Deletes a collection folder.
 
 @param request The request.
 @param success A block object to be executed when the get operation finishes successfully. This block has no return value and no argument.
 @param failure A block object to be executed when the synchronization operation finishes unsuccessfully. This block has no return value and takes one argument: The `NSError` object describing the error that occurred.
 */
- (void)deleteFolder:(DGCollectionFolderRequest *)request success:(void (^)())success failure:(nullable DGFailureBlock)failure;

/**
 Creates a collection folder.
 
 @param request The create collection folder request.
 @param success A block object to be executed when the get operation finishes successfully. This block has no return value and one argument: the created collection folder.
 @param failure A block object to be executed when the synchronization operation finishes unsuccessfully. This block has no return value and takes one argument: The `NSError` object describing the error that occurred.
 */
- (void)createFolder:(DGCreateCollectionFolderRequest *)request success:(void (^)(DGCollectionFolder *folder))success failure:(nullable DGFailureBlock)failure;

/**
 Gets the collection items by folder.
 
 @param request The paginated collection items request.
 @param success A block object to be executed when the get operation finishes successfully. This block has no return value and one argument: the paginated collection releases response.
 @param failure A block object to be executed when the synchronization operation finishes unsuccessfully. This block has no return value and takes one argument: The `NSError` object describing the error that occurred.
 */
- (void)getItemsByFolder:(DGCollectionFolderItemsRequest *)request success:(void (^)(DGCollectionItemsResponse *response))success failure:(nullable DGFailureBlock)failure;

/**
 Gets the collection items by release.
 
 @param request The collection items request.
 @param success A block object to be executed when the get operation finishes successfully. This block has no return value and one argument: the paginated collection releases response.
 @param failure A block object to be executed when the synchronization operation finishes unsuccessfully. This block has no return value and takes one argument: The `NSError` object describing the error that occurred.
 */
- (void)getItemsByRelease:(DGCollectionReleaseItemsRequest *)request success:(void (^)(DGCollectionItemsResponse *response))success failure:(nullable DGFailureBlock)failure;

/**
 Adds release to user's collection folder.
 
 @param request The request.
 @param success A block object to be executed when the get operation finishes successfully. This block has no return value and one argument: the response.
 @param failure A block object to be executed when the synchronization operation finishes unsuccessfully. This block has no return value and takes one argument: The `NSError` object describing the error that occurred.
 */
- (void)addToFolder:(DGAddToCollectionFolderRequest *)request success:(void (^)(DGAddToCollectionFolderResponse *response))success failure:(nullable DGFailureBlock)failure;

/**
 Changes release's rating.
 
 @param request The request.
 @param success A block object to be executed when the get operation finishes successfully. This block has no return value and no argument.
 @param failure A block object to be executed when the synchronization operation finishes unsuccessfully. This block has no return value and takes one argument: The `NSError` object describing the error that occurred.
 */
- (void)changeRatingOfRelease:(DGChangeRatingOfReleaseRequest *)request success:(void (^)())success failure:(nullable DGFailureBlock)failure;

/**
 Gets user collection instance from specific folder
 
 @param request the request that represents the specific folder instance
 @param success A block object to be executed when the get operation finishes successfully. This block has no return value and one argument: the collection instance
 @param failure A block object to be executed when the GET operation fails. The block has no return value and one argument: the associated error
 */
- (void)getInstanceFromFolder:(DGReleaseInstanceRequest *)request success:(void (^)(DGReleaseInstance *response))success failure:(nullable DGFailureBlock)failure;

/**
 Deletes release from user's collection folder.
 
 @param request The request.
 @param success A block object to be executed when the get operation finishes successfully. This block has no return value and no argument.
 @param failure A block object to be executed when the synchronization operation finishes unsuccessfully. This block has no return value and takes one argument: The `NSError` object describing the error that occurred.
 */
- (void)deleteInstanceFromFolder:(DGReleaseInstanceRequest *)request success:(void (^)())success failure:(nullable DGFailureBlock)failure;

/**
 Gets the user's collection fields.
 
 @param userName The user's name.
 @param success  A block object to be executed when the get operation finishes successfully. This block has no return value and one argument: the collection fields.
 @param failure  A block object to be executed when the synchronization operation finishes unsuccessfully. This block has no return value and takes one argument: The `NSError` object describing the error that occurred.
 */
- (void)getFields:(NSString *)userName success:(void (^)(NSArray<DGCollectionField *> *fields))success failure:(nullable DGFailureBlock)failure;

/**
 Changes the value of a notes field on a particular instance.
 
 @param request The request.
 @param success A block object to be executed when the get operation finishes successfully. This block has no return value and no argument.
 @param failure A block object to be executed when the synchronization operation finishes unsuccessfully. This block has no return value and takes one argument: The `NSError` object describing the error that occurred.
 */
- (void)editField:(DGEditFieldsInstanceRequest *)request success:(void (^)())success failure:(nullable DGFailureBlock)failure;

@end

NS_ASSUME_NONNULL_END
