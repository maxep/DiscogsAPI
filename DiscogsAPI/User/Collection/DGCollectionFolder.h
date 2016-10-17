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

@property (nonatomic, strong) NSString *userName;
@property (nonatomic, strong) NSNumber *folderID;
@property (nonatomic, strong) NSString *name;

@end

@interface DGCreateCollectionFolderRequest : NSObject

@property (nonatomic, strong) NSString *userName;
@property (nonatomic, strong) NSString *folderName;

@end

@interface DGCollectionFoldersRequest : NSObject

@property (nonatomic, strong) NSString *userName;

@end

@interface DGCollectionFolder : DGObject

@property (nonatomic, strong) NSNumber *count;
@property (nonatomic, strong, nullable) NSString *name;

@end

@interface DGAddToCollectionFolderRequest : NSObject

@property (nonatomic, strong) NSString  *userName;
@property (nonatomic, strong) NSNumber  *releaseID;
@property (nonatomic, strong) NSNumber  *folderID;

@end

@interface DGAddToCollectionFolderResponse : DGObject

@end

@interface DGCollectionReleasesRequest : NSObject

@property (nonatomic, strong) DGPagination      *pagination;
@property (nonatomic, strong) NSString          *userName;
@property (nonatomic, strong) NSNumber          *folderID;
@property (nonatomic) DGSortFolderItems      sort;
@property (nonatomic) DGSortOrder    sortOrder;

@end

@class DGReleaseInstance;

@interface DGCollectionReleasesResponse : NSObject <DGPaginated>

@property (nonatomic, strong) NSArray<DGReleaseInstance *> *releases;

@end

NS_ASSUME_NONNULL_END
