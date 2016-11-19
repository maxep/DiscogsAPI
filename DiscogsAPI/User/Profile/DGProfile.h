// DGProfile.h
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

NS_ASSUME_NONNULL_BEGIN

/**
 Discogs User profile.
 */
@interface DGProfile : DGObject

/// The user profile description.
@property (nonatomic, strong, nullable) NSString *profile;

/// The user wantlistURL.
@property (nonatomic, strong, nullable) NSString *wantlistURL;

/// User rank.
@property (nonatomic, strong, nullable) NSNumber *rank;

/// Number of pending contribution.
@property (nonatomic, strong, nullable) NSNumber *numPending;

/// Number of item for sale.
@property (nonatomic, strong, nullable) NSNumber *numForSale;

/// User homepage.
@property (nonatomic, strong, nullable) NSString *homePage;

/// User location
@property (nonatomic, strong, nullable) NSString *location;

/// User collection folders URL.
@property (nonatomic, strong, nullable) NSString *collectionFoldersURL;

/// User name.
@property (nonatomic, strong, nullable) NSString *userName;

/// User collection fields URL.
@property (nonatomic, strong, nullable) NSString *collectionFieldsURL;

/// Number of contributed releases.
@property (nonatomic, strong, nullable) NSNumber *releasesContributed;

/// User registration date.
@property (nonatomic, strong, nullable) NSDate *registered;

/// User rating average
@property (nonatomic, strong, nullable) NSNumber *ratingAvg;

/// Number of release in user collection.
@property (nonatomic, strong, nullable) NSNumber *numCollection;

/// Number of rated release.
@property (nonatomic, strong, nullable) NSNumber *releasesRated;

/// Number of list.
@property (nonatomic, strong, nullable) NSNumber *numLists;

/// User fullname.
@property (nonatomic, strong, nullable) NSString *name;

/// Number on releases in user wantlist.
@property (nonatomic, strong, nullable) NSNumber *numWantlist;

/// User inventory URL.
@property (nonatomic, strong, nullable) NSString * inventoryURL;

/// user avater URL.
@property (nonatomic, strong, nullable) NSString * avatarURL;

/// User email.
@property (nonatomic, strong, nullable) NSString * email;

@end

NS_ASSUME_NONNULL_END
