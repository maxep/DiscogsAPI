// DGArtist.h
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

/**
 Artist description class.
 */
@interface DGArtist : DGObject

/**
 Artist name.
 */
@property (nonatomic, strong) NSString * name;

/**
 Artist name variations.
 */
@property (nonatomic, strong) NSArray  * namevariations;

/**
 Artist profile.
 */
@property (nonatomic, strong) NSString * profile;

/**
 Artist URLs.
 */
@property (nonatomic, strong) NSArray  * urls;

/**
 Data quality.
 */
@property (nonatomic, strong) NSString * dataQuality;

/**
 Arist role.
 */
@property (nonatomic, strong) NSString * role;

/**
 Artist images.
 */
@property (nonatomic, strong) NSArray  * images;

/**
 Artist members.
 */
@property (nonatomic, strong) NSArray  * members;

/**
 Artist releases URL on Discogs API.
 */
@property (nonatomic, strong) NSString * releasesURL;


/**
 Creates and initializes a `DGArtist` object.
 
 @return The newly-initialized artist object.
 */
+ (DGArtist*) artist;

@end
