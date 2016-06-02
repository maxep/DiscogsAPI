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

@interface DGSearchRequest : NSObject

@property (nonatomic, strong) NSString      *query;
@property (nonatomic, strong) NSString      *type;
@property (nonatomic, strong) NSString      *title;
@property (nonatomic, strong) NSString      *releaseTitle;
@property (nonatomic, strong) NSString      *credit;
@property (nonatomic, strong) NSString      *artist;
@property (nonatomic, strong) NSString      *anv;
@property (nonatomic, strong) NSString      *label;
@property (nonatomic, strong) NSString      *genre;
@property (nonatomic, strong) NSString      *style;
@property (nonatomic, strong) NSString      *country;
@property (nonatomic, strong) NSString      *year;
@property (nonatomic, strong) NSString      *format;
@property (nonatomic, strong) NSString      *catno;
@property (nonatomic, strong) NSString      *barcode;
@property (nonatomic, strong) NSString      *track;
@property (nonatomic, strong) NSString      *submitter;
@property (nonatomic, strong) NSString      *contributor;
@property (nonatomic, strong) DGPagination  *pagination;

+ (DGSearchRequest *)request;

@end

@interface DGSearchResult : NSObject

@property (nonatomic, strong) NSArray   *style;
@property (nonatomic, strong) NSString  *thumb;
@property (nonatomic, strong) NSString  *title;
@property (nonatomic, strong) NSString  *country;
@property (nonatomic, strong) NSArray   *format;
@property (nonatomic, strong) NSString  *uri;
/* ADD COMMUNITY */
@property (nonatomic, strong) NSArray   *label;
@property (nonatomic, strong) NSString  *catno;
@property (nonatomic, strong) NSString  *year;
@property (nonatomic, strong) NSArray   *genre;
@property (nonatomic, strong) NSString  *resourceUrl;
@property (nonatomic, strong) NSString  *type;
@property (nonatomic, strong) NSNumber  *ID;

+ (DGSearchResult *)result;

@end

@interface DGSearchResponse : NSObject <DGPaginated>

@property (nonatomic, strong) NSArray *results;

+ (DGSearchResponse *)response;

@end
