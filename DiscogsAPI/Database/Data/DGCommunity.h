// DGCommunity.h
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
 Contributo desciption class.
 */
@interface DGContributor: DGObject

/**
 Contributo name.
 */
@property (nonatomic, strong) NSString *userName;

/**
 Creates and initializes a `DGContributor` object.
 
 @return The newly-initialized contributor object.
 */
+ (DGContributor *)contributor;

@end

/**
 Rating desciption class
 */
@interface DGRating : DGObject

/**
 Average rating.
 */
@property (nonatomic, strong) NSNumber *average;

/**
 Count of rating.
 */
@property (nonatomic, strong) NSNumber *count;

/**
 Creates and initializes a `DGRating` object.
 
 @return The newly-initialized rating object.
 */
+ (DGRating *)rating;

@end

/**
 Community description class.
 */
@interface DGCommunity : DGObject


/**
 List of contributor.
 */
@property (nonatomic, strong, nullable) NSArray<DGContributor *> *contributors;

/**
 Data quality.
 */
@property (nonatomic, strong, nullable) NSString *dataQuality;

/**
 Number of 'have'.
 */
@property (nonatomic, strong, nullable) NSNumber *have;

/**
 Rating.
 */
@property (nonatomic, strong, nullable) DGRating *rating;

/**
 Status.
 */
@property (nonatomic, strong, nullable) NSString *status;

/**
 Submitter.
 */
@property (nonatomic, strong, nullable) DGContributor *submitter;

/**
 Number of 'want'.
 */
@property (nonatomic, strong, nullable) NSNumber *want;

/**
 Creates and initializes a `DGCommunity` object.
 
 @return The newly-initialized community object.
 */
+ (DGCommunity *)community;

@end

NS_ASSUME_NONNULL_END
