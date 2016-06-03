// DGSearch.h
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
#import "DGPagination.h"

NS_ASSUME_NONNULL_BEGIN

@interface DGSearchRequest : NSObject

@property (nonatomic, strong, nullable) NSString *query;
@property (nonatomic, strong, nullable) NSString *type;
@property (nonatomic, strong, nullable) NSString *title;
@property (nonatomic, strong, nullable) NSString *releaseTitle;
@property (nonatomic, strong, nullable) NSString *credit;
@property (nonatomic, strong, nullable) NSString *artist;
@property (nonatomic, strong, nullable) NSString *anv;
@property (nonatomic, strong, nullable) NSString *label;
@property (nonatomic, strong, nullable) NSString *genre;
@property (nonatomic, strong, nullable) NSString *style;
@property (nonatomic, strong, nullable) NSString *country;
@property (nonatomic, strong, nullable) NSString *year;
@property (nonatomic, strong, nullable) NSString *format;
@property (nonatomic, strong, nullable) NSString *catno;
@property (nonatomic, strong, nullable) NSString *barcode;
@property (nonatomic, strong, nullable) NSString *track;
@property (nonatomic, strong, nullable) NSString *submitter;
@property (nonatomic, strong, nullable) NSString *contributor;
@property (nonatomic, strong) DGPagination *pagination;

+ (DGSearchRequest *)request;

@end

@interface DGSearchResult : NSObject

@property (nonatomic, strong, nullable) NSArray<NSString *> *style;
@property (nonatomic, strong, nullable) NSString *thumb;
@property (nonatomic, strong, nullable) NSString *title;
@property (nonatomic, strong, nullable) NSString *country;
@property (nonatomic, strong, nullable) NSArray<NSString *> *format;
@property (nonatomic, strong, nullable) NSString *uri;
/* ADD COMMUNITY */
@property (nonatomic, strong, nullable) NSArray<NSString *> *label;
@property (nonatomic, strong, nullable) NSString *catno;
@property (nonatomic, strong, nullable) NSString *year;
@property (nonatomic, strong, nullable) NSArray<NSString *> *genre;
@property (nonatomic, strong, nullable) NSString *resourceUrl;
@property (nonatomic, strong, nullable) NSString *type;
@property (nonatomic, strong, nullable) NSNumber *ID;

+ (DGSearchResult *)result;

@end

@interface DGSearchResponse : NSObject <DGPaginated>

@property (nonatomic, strong, nullable) NSArray<DGSearchResult *> *results;

+ (DGSearchResponse *)response;

@end

NS_ASSUME_NONNULL_END
