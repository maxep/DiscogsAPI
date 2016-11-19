// DGReleaseInstance.h
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

@class DGArtist;
@class DGCollectionFieldInstance;
@class DGLabel;

/**
 The collection release instance representation.
 */
@interface DGReleaseInstance : DGObject

/// user rating for this release instance
@property (nonatomic, strong, nullable) NSNumber *rating;

/// release year
@property (nonatomic, strong, nullable) NSNumber *year;

/// thumbnail image URL
@property (nonatomic, strong, nullable) NSString *thumb;

/// release title
@property (nonatomic, strong, nullable) NSString *title;

/// release ID (regular ID is of this instance)
@property (nonatomic, strong, nullable) NSNumber *releaseID;

/// release artists
@property (nonatomic, strong) NSArray<DGArtist *> *artists;

/// technically notes but really encompasses instance fields
@property (nonatomic, strong) NSArray<DGCollectionFieldInstance *> *notes;

/// release labels (dictionary for now)
@property (nonatomic, strong) NSArray<DGLabel *> *labels;

@end

/**
 The collection release instance request?
 */
@interface DGReleaseInstanceRequest : NSObject

/**
 The collection username.
 */
@property (nonatomic, strong) NSString *userName;

/**
 The request folder ID.
 */
@property (nonatomic, strong) NSNumber *folderID;

/**
 The requested release ID.
 */
@property (nonatomic, strong) NSNumber *releaseID;

/**
 the requestion instance ID.
 */
@property (nonatomic, strong) NSNumber *instanceID;

@end

/**
 Edit a fields request.
 */
@interface DGEditFieldsInstanceRequest : DGReleaseInstanceRequest

/**
 The fields ID to edit.
 */
@property (nonatomic, strong) NSNumber *fieldID;

/**
 The fields value.
 */
@property (nonatomic, strong) NSString *value;

@end

/**
 The rating request.
 */
@interface DGChangeRatingOfReleaseRequest : DGReleaseInstanceRequest

/**
 The new release rating.
 */
@property (nonatomic, strong) NSNumber  *rating;

@end

NS_ASSUME_NONNULL_END
