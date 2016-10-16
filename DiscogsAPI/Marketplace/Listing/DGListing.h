// DGListing.h
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
#import "DGPrice.h"
#import "DGPagination.h"

NS_ASSUME_NONNULL_BEGIN

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

extern NSString *DGListingSortAsString(DGListingSort sort);

@class DGProfile;
@class DGRelease;

@interface DGListing : DGObject

@property (nonatomic, strong, nullable) NSString *status;

@property (nonatomic, strong, nullable) DGPrice *price;

@property (nonatomic) BOOL allowOffers;

@property (nonatomic, strong, nullable) NSString *sleeveCondition;

@property (nonatomic, strong, nullable) NSString *condition;

@property (nonatomic, strong, nullable) NSDate *posted;

@property (nonatomic, strong, nullable) NSString *shipsFrom;

@property (nonatomic, strong, nullable) NSString *comments;

@property (nonatomic, strong, nullable) DGProfile *seller;

@property (nonatomic, strong, nullable) DGRelease *dgRelease;

@property (nonatomic) BOOL audio;

@property (nonatomic, strong, nullable) NSString *location;

@property (nonatomic, strong, nullable) NSString *externalID;

@property (nonatomic, strong, nullable) NSNumber *weight;

@property (nonatomic, strong, nullable) NSNumber *formatQuantity;

@end

@interface DGListingRequest : NSObject

@property (nonatomic, strong) NSNumber *listingID;

@property (nonatomic) DGCurrency currency;

@end

@interface DGCreateListingRequest : NSObject

@property (nonatomic, strong) DGListing *listing;

@end

@interface DGCreateListingResponse : NSObject

@property (nonatomic, strong) NSNumber *listingID;

@property (nonatomic, strong, nullable) NSString *resourceURL;

@end

NS_ASSUME_NONNULL_END
