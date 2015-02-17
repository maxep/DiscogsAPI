// DGMasterVersion.h
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

#import "DGLabelRelease.h"

/**
 Master version description class.
 */
@interface DGMasterVersion : DGLabelRelease

/**
 Creates and initializes a `DGMasterVersion` object.
 
 @return The newly-initialized master version object.
 */
+ (DGMasterVersion*) version;

@end

@interface DGMasterVersionRequest : NSObject

@property (nonatomic, strong) DGPagination  * pagination;
@property (nonatomic, strong) NSNumber      * masterID;

+ (DGMasterVersionRequest*) request;

@end

@interface DGMasterVersionResponse : NSObject

@property (nonatomic, strong) DGPagination * pagination;
@property (nonatomic, strong) NSArray * versions;

+ (DGMasterVersionResponse*) response;

- (void) loadNextPageWithSuccess:(void (^)())success failure:(void (^)(NSError* error))failure;

@end