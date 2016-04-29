// DGRelease.h
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

#import "DGObject.h"
#import "DGCommunity.h"
#import "DGFormat.h"
#import "DGIdentifier.h"

/**
 Release description class.
 */
@interface DGRelease : DGObject

/**
 Release title.
 */
@property (nonatomic, strong) NSString * title;

/**
 Master ID this release is based on
 */
@property (nonatomic, strong) NSNumber *masterID;

/**
 API URL to Master this release is based on
 */
@property (nonatomic, strong) NSString *masterURL;

/**
 List of artists that contibuted to the release.
 */
@property (nonatomic, strong) NSArray  * artists;

/**
 Data quality.
 */
@property (nonatomic, strong) NSString * dataQuality;

/**
 Release thumbnail image URL.
 */
@property (nonatomic, strong) NSString * thumb;

/**
 Community that contibuted to the release.
 */
@property (nonatomic, strong) DGCommunity * community;

/* ADD COMPANIES */

/**
 Release images.
 */
@property (nonatomic, strong) NSArray  * images;

/**
 Release videos.
 */
@property (nonatomic, strong) NSArray  * videos;

/**
 Release country.
 */
@property (nonatomic, strong) NSString * country;

/**
 Release creation date on Discogs.
 */
@property (nonatomic, strong) NSString * dateAdded;

/**
 Last update on discogs.
 */
@property (nonatomic, strong) NSString * dateChanged;

/**
 Estimated weight of the release.
 */
@property (nonatomic, strong) NSNumber * estimatedWeight;

/**
 Extra artists.
 */
@property (nonatomic, strong) NSArray  * extraArtists;

/**
 Quantity of the format.
 */
@property (nonatomic, strong) NSNumber * formatQuantity;

/**
 Formats pertaining to this release
 */
@property (nonatomic, strong) NSArray<DGFormat *> *formats;

/**
 Genres of release music.
 */
@property (nonatomic, strong) NSArray  * genres;

/**
 Styles of release music.
 */
@property (nonatomic, strong) NSArray  * styles;

/**
 Release track list.
 */
@property (nonatomic, strong) NSArray  * trackList;

/**
 Released year.
 */
@property (nonatomic, strong) NSNumber * year;

/**
 Release notes.
 */
@property (nonatomic, strong) NSString * notes;

/**
 Identifiers
 */
@property (nonatomic, strong) NSArray<DGIdentifier *> *identifiers;

/* ADD THE REST */

/**
 Creates and initializes a `DGRelease` object.
 
 @return The newly-initialized release object.
 */
+ (DGRelease*) release;

@end
