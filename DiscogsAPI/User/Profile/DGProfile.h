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

@interface DGProfile : DGObject

@property (nonatomic, strong, nullable) NSString *profile;
@property (nonatomic, strong, nullable) NSString *wantlistURL;
@property (nonatomic, strong, nullable) NSNumber *rank;
@property (nonatomic, strong, nullable) NSNumber *numPending;
@property (nonatomic, strong, nullable) NSNumber *numForSale;
@property (nonatomic, strong, nullable) NSString *homePage;
@property (nonatomic, strong, nullable) NSString *location;
@property (nonatomic, strong, nullable) NSString *collectionFoldersURL;
@property (nonatomic, strong, nullable) NSString *userName;
@property (nonatomic, strong, nullable) NSString *collectionFieldsURL;
@property (nonatomic, strong, nullable) NSNumber *releasesContributed;
@property (nonatomic, strong, nullable) NSString *registered;
@property (nonatomic, strong, nullable) NSNumber *ratingAvg;
@property (nonatomic, strong, nullable) NSNumber *numCollection;
@property (nonatomic, strong, nullable) NSNumber *releasesRated;
@property (nonatomic, strong, nullable) NSNumber *numLists;
@property (nonatomic, strong, nullable) NSString *name;
@property (nonatomic, strong, nullable) NSNumber *numWantlist;
@property (nonatomic, strong, nullable) NSString *inventoryURL;
@property (nonatomic, strong, nullable) NSString *avatarURL;
@property (nonatomic, strong, nullable) NSString *email;

+ (DGProfile*) profile;

@end

NS_ASSUME_NONNULL_END
