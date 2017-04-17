// DGCollectionFolder.m
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

#import "DGCollectionFolder+Mapping.h"

@implementation DGCollectionFolder

- (instancetype)init {
    self = [super init];
    if (self) {
        self.count = @0;
        self.name = @"";
    }
    return self;
}

@end

#pragma mark - Get Collection Folder

extern NSString * DGSortFolderItemsAsString(DGSortFolderItems sort) {
    return @[@"label", @"artist", @"title", @"catno", @"format", @"rating", @"added", @"year"][sort];
}

@implementation DGCollectionFolderRequest

- (instancetype)init {
    self = [super init];
    if (self) {
        self.userName = @"";
        self.folderID = @0;
        self.name = @"";
    }
    return self;
}

@end

#pragma mark - Create Collection Folder

@implementation DGCreateCollectionFolderRequest

- (instancetype)init {
    self = [super init];
    if (self) {
        self.userName = @"";
        self.folderName = @"";
    }
    return self;
}

@end

#pragma mark - Get Collection Folders

@implementation DGCollectionFoldersRequest

- (instancetype)init {
    self = [super init];
    if (self) {
        self.userName = @"";
    }
    return self;
}

@end

#pragma mark - Add To Collection Folder

@implementation DGAddToCollectionFolderRequest

- (id)init {
    if (self = [super init]) {
        self.folderID = @1;
        self.userName = @"";
        self.releaseID = @0;
    }
    return self;
}

@end

@implementation DGAddToCollectionFolderResponse

@end

#pragma mark - Get Collection Items

@implementation DGCollectionFolderItemsRequest

- (id)init {
    if (self = [super init]) {
        
        self.pagination = [DGPagination new];
        self.folderID   = @0;
        self.userName   = @"";
        self.sort       = DGSortFolderItemsArtist;
        self.sortOrder  = DGSortOrderDesc;
    }
    return self;
}

@end

@implementation DGCollectionReleaseItemsRequest

- (id)init {
    if (self = [super init]) {
        
        self.pagination = [DGPagination new];
        self.releaseID  = @0;
        self.userName   = @"";
    }
    return self;
}

@end

@implementation DGCollectionItemsResponse

@synthesize pagination;

- (instancetype)init {
    self = [super init];
    if (self) {
        self.releases = @[];
    }
    return self;
}

- (void)loadNextPageWithSuccess:(void (^)())success failure:(void (^)(NSError* error))failure {
    
    [self.pagination loadNextPageWithResponseClass:[DGCollectionItemsResponse class] success:^(DGCollectionItemsResponse *response) {
        self.pagination = response.pagination;
        self.releases = [self.releases arrayByAddingObjectsFromArray:response.releases];
        success();
    } failure:failure];
}

@end
