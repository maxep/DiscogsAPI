// DGListing.h
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
#import "DGPrice.h"
#import "DGPagination.h"

NS_ASSUME_NONNULL_BEGIN

/**
 Sort listing descriptor

 - DGListingSortListed: Sort by listed time.
 - DGListingSortPrice: Sort by price.
 - DGListingSortItem: Sort by Item.
 - DGListingSortArtist: Sort by Artist.
 - DGListingSortLabel: Sort by Label.
 - DGListingSortCatno: Sort by Catno.
 - DGListingSortAudio: Sort by Audio.
 - DGListingSortStatus: Sort by listing status.
 - DGListingSortLocation: Sort by location.
 */
typedef NS_ENUM(NSInteger, DGListingSort){
    DGListingSortListed,
    DGListingSortPrice,
    DGListingSortItem,
    DGListingSortArtist,
    DGListingSortLabel,
    DGListingSortCatno,
    DGListingSortAudio,
    DGListingSortStatus,
    DGListingSortLocation
};

/**
 Returns a sort descriptor as string.

 @param sort A sort desciptor.
 @return A sort descriptor string.
 */
extern NSString *DGListingSortAsString(DGListingSort sort);

@class DGProfile;
@class DGRelease;

/**
 A listing respresentation.
 */
@interface DGListing : DGObject

/// Listing status.
@property (nonatomic, strong, nullable) NSString *status;

/// Listing price.
@property (nonatomic, strong, nullable) DGPrice *price;

/// Is the listing allows offers.
@property (nonatomic) BOOL allowOffers;

/// Sleeve condition description.
@property (nonatomic, strong, nullable) NSString *sleeveCondition;

/// General lsiting condition.
@property (nonatomic, strong, nullable) NSString *condition;

/// Posted date.
@property (nonatomic, strong, nullable) NSDate *posted;

/// Ships location.
@property (nonatomic, strong, nullable) NSString *shipsFrom;

/// Listing comments.
@property (nonatomic, strong, nullable) NSString *comments;

/// Listing seller profile.
@property (nonatomic, strong, nullable) DGProfile *seller;

/// Listing release.
@property (nonatomic, strong, nullable) DGRelease *release_;

/// Has audio.
@property (nonatomic) BOOL audio;

/// Listing location.
@property (nonatomic, strong, nullable) NSString *location;

/// Listing external id.
@property (nonatomic, strong, nullable) NSString *externalID;

/// Listing weight.
@property (nonatomic, strong, nullable) NSNumber *weight;

/// Format quantity.
@property (nonatomic, strong, nullable) NSNumber *formatQuantity;

@end

/**
 Listing request.
 */
@interface DGListingRequest : NSObject

/// Listing ID to request.
@property (nonatomic, strong) NSNumber *listingID;

/// Listing requested currency.
@property (nonatomic) DGCurrency currency;

@end

/**
 Create a listing request.
 */
@interface DGCreateListingRequest : NSObject

/// The listing to create.
@property (nonatomic, strong, nullable) DGListing *listing;

@end

/// The listing creation response.
@interface DGCreateListingResponse : NSObject

/// The created listing ID.
@property (nonatomic, strong, nullable) NSNumber *listingID;

/// The listing resource URL.
@property (nonatomic, strong, nullable) NSString *resourceURL;

@end

NS_ASSUME_NONNULL_END
