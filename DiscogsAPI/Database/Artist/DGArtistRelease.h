// DGArtistRelease.h
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

#import "DGRelease.h"
#import "DGPagination.h"

/**
 Artist release description class.
 */
@interface DGArtistRelease : DGRelease

/**
 Sttus of the release.
 */
@property (nonatomic, strong) NSString *status;

/**
 Release format.
 */
@property (nonatomic, strong) NSString *format;

/**
 Release label.
 */
@property (nonatomic, strong) NSString *label;

/**
 Role of the artist on the release.
 */
@property (nonatomic, strong) NSString *role;

/**
 Track info.
 */
@property (nonatomic, strong) NSString *trackInfo;

/**
 Release artist.
 */
@property (nonatomic, strong) NSString *artist;

/**
 Release or Master type.
 */
@property (nonatomic, strong) NSString *type;

/**
 Creates and initializes a `DGArtistRelease` object.
 
 @return The newly-initialized artist release object.
 */
+ (DGArtistRelease *)release;

@end

/**
 Artist releases and masters request. 
 */
@interface DGArtistReleaseRequest : NSObject

@property (nonatomic, strong) DGPagination  *pagination;
@property (nonatomic, strong) NSNumber      *artistID;

+ (DGArtistReleaseRequest *)request;

@end

@interface DGArtistReleaseResponse : NSObject <DGPaginated>

@property (nonatomic, strong) NSArray *releases;

+ (DGArtistReleaseResponse *)response;

@end
