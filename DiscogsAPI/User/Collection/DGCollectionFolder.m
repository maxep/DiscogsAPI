// DGCollectionFolder.m
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

#import "DGCollectionFolder+Mapping.h"

extern NSString * DGSortFolderItemsAsString(DGSortFolderItems sort) {
    return @[@"label", @"artist", @"title", @"catno", @"format", @"rating", @"added", @"year"][sort];
}

@implementation DGCreateCollectionFolderRequest

+ (DGCreateCollectionFolderRequest*) request {
    return [[DGCreateCollectionFolderRequest alloc] init];
}

@end

@implementation DGCollectionFolderRequest

+ (DGCollectionFolderRequest*) request {
    return [[DGCollectionFolderRequest alloc] init];
}

@end

@implementation DGCollectionFoldersRequest

+ (DGCollectionFoldersRequest*) collection {
    return [[DGCollectionFoldersRequest alloc] init];
}

@end

@implementation DGCollectionFolder

+ (DGCollectionFolder*) folder {
    return [[DGCollectionFolder alloc] init];
}

@end

@implementation DGAddToCollectionFolderRequest

+ (DGAddToCollectionFolderRequest *)request {
    return [[DGAddToCollectionFolderRequest alloc] init];
}

- (id)init {
    if (self = [super init]) {
        self.folderID = @1;
    }
    return self;
}

@end

@implementation DGAddToCollectionFolderResponse

+ (DGAddToCollectionFolderResponse *)response {
    return [[DGAddToCollectionFolderResponse alloc] init];
}

@end

@implementation DGCollectionReleasesRequest

+ (DGCollectionReleasesRequest *)request {
    return [[DGCollectionReleasesRequest alloc] init];
}

- (id)init {
    if (self = [super init]) {
        
        self.pagination = [DGPagination pagination];
        self.folderID   = @0;
        self.sort       = DGSortFolderItemsArtist;
        self.sortOrder  = DGSortOrderDesc;
    }
    return self;
}

@end

@implementation DGCollectionReleasesResponse

@synthesize pagination;

+ (DGCollectionReleasesResponse*) response {
    return [[DGCollectionReleasesResponse alloc] init];
}

- (void)loadNextPageWithSuccess:(void (^)())success failure:(void (^)(NSError* error))failure {
    
    [self.pagination loadNextPageWithResponseDesciptor:[DGCollectionReleasesResponse responseDescriptor] success:^(NSArray *objects) {
        if ([[objects firstObject] isKindOfClass:[DGCollectionReleasesResponse class]]) {
            DGCollectionReleasesResponse* response = [objects firstObject];
            
            self.pagination = response.pagination;
            NSMutableArray* releases = [self.releases mutableCopy];
            [releases addObjectsFromArray:response.releases];
            self.releases = releases;
            
            success();
        }
    } failure:^(NSError *error) {
        RKLogError(@"Operation failed with error: %@", error);
        if (failure) failure(error);
    }];
}

@end
