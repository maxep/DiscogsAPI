//
//  DGFormat.h
//  DiscogsAPI
//
//  Created by Nate Rivard on 4/28/16.
//  Copyright © 2016 Maxime Epain. All rights reserved.
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
 Sample JSON
 
 {
    descriptions =             (
        LP,
        Album,
        "Deluxe Edition",
        "Limited Edition",
        Reissue
    );
    name = Vinyl;
    qty = 1;
    text = Red;
 }
 */

/**
 Media format description class
 */
@interface DGFormat : DGObject

/// media type: Vinyl, CD, DVD, etc.
@property (nonatomic, strong) NSString *name;

/// number of physical media objects: double LP == 2, etc.
@property (nonatomic, strong) NSNumber *quantity;

/// any special circumstances, especially applicable to vinyl like color, etc.
@property (nonatomic, strong) NSString *text;

/// a list of descriptions that apply: LP, RSD Release, Limited, etc.
@property (nonatomic, strong) NSArray<NSString *> *descriptions;

/**
 Creates and initializes new release format object
 
 @return new format object
 */
+ (instancetype)format;

@end
