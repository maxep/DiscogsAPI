// DGSearch.h
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

#import "DGObject.h"
#import "DGPagination.h"

NS_ASSUME_NONNULL_BEGIN

/**
 The search request.
 */
@interface DGSearchRequest : NSObject

/**
 The search query
 */
@property (nonatomic, strong, nullable) NSString *query;

/**
 Search type. One of `release, `master`, `artist`, `label`.
 */
@property (nonatomic, strong, nullable) NSString *type;

/**
 Search by combined “Artist Name - Release Title” title field.
 */
@property (nonatomic, strong, nullable) NSString *title;

/**
 Search release titles.
 */
@property (nonatomic, strong, nullable) NSString *releaseTitle;

/**
 Search release credits.
 */
@property (nonatomic, strong, nullable) NSString *credit;

/**
 Search artist names.
 */
@property (nonatomic, strong, nullable) NSString *artist;

/**
 Search artist ANV.
 */
@property (nonatomic, strong, nullable) NSString *anv;

/**
 Search label names.
 */
@property (nonatomic, strong, nullable) NSString *label;

/**
 Search genres.
 */
@property (nonatomic, strong, nullable) NSString *genre;

/**
 Search styles.
 */
@property (nonatomic, strong, nullable) NSString *style;

/**
 search release country.
 */
@property (nonatomic, strong, nullable) NSString *country;

/**
 Search release year.
 */
@property (nonatomic, strong, nullable) NSString *year;

/**
 Search formats.
 */
@property (nonatomic, strong, nullable) NSString *format;

/**
 Search catalog number.
 */
@property (nonatomic, strong, nullable) NSString *catno;

/**
 Search barcodes.
 */
@property (nonatomic, strong, nullable) NSString *barcode;

/**
 Search track title.
 */
@property (nonatomic, strong, nullable) NSString *track;

/**
 Search submitter username.
 */
@property (nonatomic, strong, nullable) NSString *submitter;

/**
 Search contributor usernames.
 */
@property (nonatomic, strong, nullable) NSString *contributor;

/**
 The request pagination paramaters.
 */
@property (nonatomic, strong) DGPagination *pagination;

@end

/**
 The search result description.
 */
@interface DGSearchResult : DGObject

/**
 Result styles.
 */
@property (nonatomic, strong) NSArray<NSString *> *style;

/**
 Result thumb resource URL.
 */
@property (nonatomic, strong, nullable) NSString *thumb;

/**
 Result release title.
 */
@property (nonatomic, strong, nullable) NSString *title;

/**
 Result release country.
 */
@property (nonatomic, strong, nullable) NSString *country;

/**
 Result release format.
 */
@property (nonatomic, strong) NSArray<NSString *> *format;

/* ADD COMMUNITY */

/**
 Result release labels.
 */
@property (nonatomic, strong) NSArray<NSString *> *label;

/**
 Result catalog number.
 */
@property (nonatomic, strong, nullable) NSString *catno;

/**
 Result release year.
 */
@property (nonatomic, strong, nullable) NSString *year;

/**
 Result release genres.
 */
@property (nonatomic, strong) NSArray<NSString *> *genre;

/**
 Result type.
 */
@property (nonatomic, strong, nullable) NSString *type;

@end

/**
 The paginated search response.
 */
@interface DGSearchResponse : NSObject <DGPaginated>

/**
 Search results.
 */
@property (nonatomic, strong) NSArray<DGSearchResult *> *results;

@end

NS_ASSUME_NONNULL_END
