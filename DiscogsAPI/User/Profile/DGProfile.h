// DGProfile.h
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

@interface DGProfile : DGObject

@property (nonatomic, strong) NSString * profile;
@property (nonatomic, strong) NSString * wantlistURL;
@property (nonatomic, strong) NSNumber * rank;
@property (nonatomic, strong) NSNumber * numPending;
@property (nonatomic, strong) NSNumber * numForSale;
@property (nonatomic, strong) NSString * homePage;
@property (nonatomic, strong) NSString * location;
@property (nonatomic, strong) NSString * collectionFoldersURL;
@property (nonatomic, strong) NSString * userName;
@property (nonatomic, strong) NSString * collectionFieldsURL;
@property (nonatomic, strong) NSNumber * releasesContributed;
@property (nonatomic, strong) NSString * registered;
@property (nonatomic, strong) NSNumber * ratingAvg;
@property (nonatomic, strong) NSNumber * numCollection;
@property (nonatomic, strong) NSNumber * releasesRated;
@property (nonatomic, strong) NSNumber * numLists;
@property (nonatomic, strong) NSString * name;
@property (nonatomic, strong) NSNumber * numWantlist;
@property (nonatomic, strong) NSString * inventoryURL;
@property (nonatomic, strong) NSString * avatarURL;
@property (nonatomic, strong) NSString * email;

+ (DGProfile*) profile;

@end
