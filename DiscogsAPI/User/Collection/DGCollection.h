// DGCollection.h
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

#import <Foundation/Foundation.h>
#import "DGPagination.h"

@interface DGCollectionFolderRequest : NSObject

@property (nonatomic, strong) NSNumber * folderID;
@property (nonatomic, strong) NSString * userName;

+ (DGCollectionFolderRequest*) request;

@end

@interface DGCollectionFolder : NSObject

@property (nonatomic, strong) NSNumber * folderID;
@property (nonatomic, strong) NSNumber * count;
@property (nonatomic, strong) NSString * name;
@property (nonatomic, strong) NSString * resourceURL;
@property (nonatomic, strong) NSArray  * releases;

+ (DGCollectionFolder*) folder;

@end

@interface DGCollectionFolders : NSObject

@property (nonatomic, strong) NSString * userName;
@property (nonatomic, strong) NSArray  * folders;

+ (DGCollectionFolders*) collection;

@end

@interface DGPutReleaseInFolderRequest : NSObject

@property (nonatomic, strong) NSString* userName;
@property (nonatomic, strong) NSNumber* releaseID;
@property (nonatomic, strong) NSNumber* folderID;

+ (DGPutReleaseInFolderRequest*) request;

@end

@interface DGPutReleaseInFolderResponse : NSObject

@property (nonatomic, strong) NSNumber* instanceID;
@property (nonatomic, strong) NSString* resourceURL;

+ (DGPutReleaseInFolderResponse*) response;

@end

@interface DGCollectionReleasesRequest : NSObject

@property (nonatomic, strong) DGPagination  * pagination;
@property (nonatomic, strong) NSString * userName;
@property (nonatomic, strong) NSNumber * folderID;
@property (nonatomic, readwrite) DGSortKey sort;
@property (nonatomic, readwrite) DGSortOrder sortOrder;

+ (DGCollectionReleasesRequest*) request;

@end

@interface DGCollectionReleasesResponse : NSObject

@property (nonatomic, strong) DGPagination * pagination;
@property (nonatomic, strong) NSArray * releases;

+ (DGCollectionReleasesResponse*) response;

- (void) loadNextPageWithSuccess:(void (^)())success failure:(void (^)(NSError* error))failure;

@end
