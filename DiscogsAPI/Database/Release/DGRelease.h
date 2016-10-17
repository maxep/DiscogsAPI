// DGRelease.h
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
#import "DGCommunity.h"
#import "DGFormat.h"
#import "DGIdentifier.h"
#import "DGImage.h"
#import "DGTrack.h"
#import "DGVideo.h"

NS_ASSUME_NONNULL_BEGIN

@class DGArtist;

/**
 Release description class.
 */
@interface DGRelease : DGObject

/**
 Release title.
 */
@property (nonatomic, strong, nullable) NSString *title;

/**
 Master ID this release is based on
 */
@property (nonatomic, strong, nullable) NSNumber *masterID;

/**
 API URL to Master this release is based on
 */
@property (nonatomic, strong, nullable) NSString *masterURL;

/**
 List of artists that contibuted to the release.
 */
@property (nonatomic, strong) NSArray<DGArtist *> *artists;

/**
 Data quality.
 */
@property (nonatomic, strong, nullable) NSString *dataQuality;

/**
 Release thumbnail image URL.
 */
@property (nonatomic, strong, nullable) NSString *thumb;

/**
 Community that contibuted to the release.
 */
@property (nonatomic, strong) DGCommunity *community;

/* ADD COMPANIES */

/**
 Release images.
 */
@property (nonatomic, strong) NSArray<DGImage *> *images;

/**
 Release videos.
 */
@property (nonatomic, strong) NSArray<DGVideo *> *videos;

/**
 Release country.
 */
@property (nonatomic, strong, nullable) NSString *country;

/**
 Release creation date on Discogs.
 */
@property (nonatomic, strong, nullable) NSString *dateAdded;

/**
 Last update on discogs.
 */
@property (nonatomic, strong, nullable) NSString *dateChanged;

/**
 Estimated weight of the release.
 */
@property (nonatomic, strong, nullable) NSNumber *estimatedWeight;

/**
 Extra artists.
 */
@property (nonatomic, strong) NSArray<DGArtist *> *extraArtists;

/**
 Quantity of the format.
 */
@property (nonatomic, strong, nullable) NSNumber *formatQuantity;

/**
 Formats pertaining to this release
 */
@property (nonatomic, strong,) NSArray<DGFormat *> *formats;

/**
 Genres of release music.
 */
@property (nonatomic, strong) NSArray<NSString *> *genres;

/**
 Styles of release music.
 */
@property (nonatomic, strong) NSArray<NSString *> *styles;

/**
 Release track list.
 */
@property (nonatomic, strong) NSArray<DGTrack *> *trackList;

/**
 Released year.
 */
@property (nonatomic, strong, nullable) NSNumber *year;

/**
 Release notes.
 */
@property (nonatomic, strong, nullable) NSString *notes;

/**
 Identifiers
 */
@property (nonatomic, strong) NSArray<DGIdentifier *> *identifiers;

/* ADD THE REST */

@end

NS_ASSUME_NONNULL_END
