// DGCollectionFolder.h
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

#import "DGObject.h"
#import "DGPagination.h"

NS_ASSUME_NONNULL_BEGIN

/**
 A collection folder representation.
 */
@interface DGCollectionFolder : DGObject

/// Count of folder's releases.
@property (nonatomic, strong) NSNumber *count;

/// Folder name.
@property (nonatomic, strong, nullable) NSString *name;

@end

#pragma mark - Get Collection Folder

/**
 Sort description of folder items.
 */
typedef NS_ENUM(NSInteger, DGSortFolderItems){
    /**
     Sort by Label.
     */
    DGSortFolderItemsLabel,
    /**
     Sort by Artist.
     */
    DGSortFolderItemsArtist,
    /**
     Sort by Title.
     */
    DGSortFolderItemsTitle,
    /**
     Sort by Catalog Number.
     */
    DGSortFolderItemsCatno,
    /**
     Sort by Format.
     */
    DGSortFolderItemsFormat,
    /**
     Sort by Rating
     */
    DGSortFolderItemsRating,
    /**
     Sort by added date.
     */
    DGSortFolderItemsAdded,
    /**
     Sort by Year.
     */
    DGSortFolderItemsYear
};

extern NSString * DGSortFolderItemsAsString(DGSortFolderItems sort);

/**
 Manage folder request.
 */
@interface DGCollectionFolderRequest : NSObject

/**
 Collectio username.
 */
@property (nonatomic, strong) NSString *userName;

/**
 Requested folder ID.
 */
@property (nonatomic, strong) NSNumber *folderID;

/**
 Requested folder name.
 */
@property (nonatomic, strong) NSString *name;

@end

#pragma mark - Create Collection Folder

/**
 Request to create a collection folder.
 */
@interface DGCreateCollectionFolderRequest : NSObject

/**
 The collection username.
 */
@property (nonatomic, strong) NSString *userName;

/**
 The collection folder name.
 */
@property (nonatomic, strong) NSString *folderName;

@end

#pragma mark - Get Collection Folders

/**
 Request to get the collection folders.
 */
@interface DGCollectionFoldersRequest : NSObject

/**
 The collection username.
 */
@property (nonatomic, strong) NSString *userName;

@end

#pragma mark - Add To Collection Folder

/**
 Request to add a release to a collection folder.
 */
@interface DGAddToCollectionFolderRequest : NSObject

/**
 The collection username.
 */
@property (nonatomic, strong) NSString  *userName;

/**
 The release ID to add.
 */
@property (nonatomic, strong) NSNumber  *releaseID;

/**
 The destination folder ID.
 */
@property (nonatomic, strong) NSNumber  *folderID;

@end

/**
 Response a add request.
 */
@interface DGAddToCollectionFolderResponse : DGObject

@end

#pragma mark - Get Collection Items

/**
 Get collection items by folder request.
 */
@interface DGCollectionFolderItemsRequest : NSObject

/// The pagination paramerters.
@property (nonatomic, strong) DGPagination *pagination;

/// The collection username.
@property (nonatomic, strong) NSString *userName;

/// The requested collection folder ID.
@property (nonatomic, strong) NSNumber *folderID;

/// The sort description.
@property (nonatomic) DGSortFolderItems sort;

/// The sort order.
@property (nonatomic) DGSortOrder sortOrder;

@end

/**
 Get collection items by release request.
 */
@interface DGCollectionReleaseItemsRequest : NSObject

/// The pagination paramerters.
@property (nonatomic, strong) DGPagination *pagination;

/// The collection username.
@property (nonatomic, strong) NSString *userName;

/// The requested collection folder ID.
@property (nonatomic, strong) NSNumber *releaseID;

@end

@class DGReleaseInstance;

/**
 The paginated collection items response.
 */
@interface DGCollectionItemsResponse : NSObject <DGPaginated>

/// The folder releases.
@property (nonatomic, strong) NSArray<DGReleaseInstance *> *releases;

@end

NS_ASSUME_NONNULL_END
