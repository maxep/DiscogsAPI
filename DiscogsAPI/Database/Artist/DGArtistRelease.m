// DGArtistRelease.m
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

#import "DGArtistRelease+Mapping.h"
#import "DGPagination+Mapping.h"

@implementation DGArtistRelease

@end

@implementation DGArtistReleasesRequest

- (id)init {
    self = [super init];
    if (self) {
        self.pagination = [DGPagination new];
    }
    return self;
}

@end

@implementation DGArtistReleasesResponse

@synthesize pagination;

- (void)loadNextPageWithSuccess:(void (^)())success failure:(nullable void (^)(NSError * _Nullable error))failure {
    
    [self.pagination loadNextPageWithResponseClass:[DGArtistReleasesResponse class] success:^(DGArtistReleasesResponse *response) {
        self.pagination = response.pagination;
        self.releases = [self.releases arrayByAddingObjectsFromArray:response.releases];
        success();
    } failure:^(NSError *error) {
        RKLogError(@"Operation failed with error: %@", error);
        if (failure) failure(error);
    }];
}

@end
