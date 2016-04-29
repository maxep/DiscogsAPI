// DGPagination.h
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

/**
 Items sort keys.
 */
typedef NS_ENUM(NSInteger, DGSortKey){
    /**
     Sort by Label.
     */
    DGSortKeyLabel,
    /**
     Sort by Artist.
     */
    DGSortKeyArtist,
    /**
     Sort by Title.
     */
    DGSortKeyTitle,
    /**
     Sort by Catalog Number.
     */
    DGSortKeyCatno,
    /**
     Sort by Format.
     */
    DGSortKeyFormat,
    /**
     Sort by Rating
     */
    DGSortKeyRating,
    /**
     Sort by added date.
     */
    DGSortKeyAdded,
    /**
     Sort by Year.
     */
    DGSortKeyYear
};
#define kDGSortKeyAsString(enum) [@[@"label", @"artist", @"title", @"catno", @"format", @"rating", @"added", @"year"] objectAtIndex:enum]

/**
 Items sort orders.
 */
typedef NS_ENUM(NSInteger, DGSortOrder){
    /**
     Ascendent order.
     */
    DGSortOrderAsc,
    /**
     Descendent order.
     */
    DGSortOrderDesc
};
#define kDGSortOrderAsString(enum) [@[@"asc", @"desc"] objectAtIndex:enum]

/**
 Pagination URLs class.
 */
@interface DGPaginationUrls : NSObject

/**
 First page URL.
 */
@property (nonatomic, strong) NSString *first;

/**
 Previous page URL.
 */
@property (nonatomic, strong) NSString *prev;

/**
 Next page URL.
 */
@property (nonatomic, strong) NSString *next;

/**
 Last page URL.
 */
@property (nonatomic, strong) NSString *last;

/**
 Creates and initializes a `DGPaginationUrls` object.
 
 @return The newly-initialized pagination URLs object.
 */
+ (DGPaginationUrls *)urls;

@end

/**
 Pagination class.
 */
@interface DGPagination : NSObject

/**
 Current page number.
 */
@property (nonatomic, strong) NSNumber *page;

/**
 Number of pages.
 */
@property (nonatomic, strong) NSNumber *pages;

/**
 Total number of items.
 */
@property (nonatomic, strong) NSNumber *items;

/**
 Number of items per page.
 */
@property (nonatomic, strong) NSNumber *perPage;

/**
 Pagination URLs.
 */
@property (nonatomic, strong) DGPaginationUrls *urls;

/**
 Creates and initializes a `DGPagination` object.
 
 @return The newly-initialized pagination object.
 */
+ (DGPagination *)pagination;

@end

/**
 Protocol for paginated responses.
 */
@protocol DGPaginated <NSObject>

/**
 The reponse's pagination.
 */
@property (nonatomic, strong) DGPagination *pagination;

/**
 Loads the response next page.
 
 @param success A block object to be executed when the get operation finishes successfully. This block has no return value and no argument.
 @param failure A block object to be executed when the operation finishes unsuccessfully. This block has no return value and takes one argument: The `NSError` object describing the error that occurred.
 */
- (void)loadNextPageWithSuccess:(void (^)())success failure:(void (^)(NSError *error))failure;

@end
