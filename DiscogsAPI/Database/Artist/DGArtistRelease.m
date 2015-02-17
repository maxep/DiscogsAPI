// DGArtistRelease.m
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

#import "DGArtistRelease+Mapping.h"
#import "DGPagination+Mapping.h"

@implementation DGArtistRelease

+ (DGArtistRelease*) release
{
    return [[DGArtistRelease alloc] init];
}

@end

@implementation DGArtistReleaseRequest

+ (DGArtistReleaseRequest*) request
{
    return [[DGArtistReleaseRequest alloc] init];
}

- (id) init
{
    self = [super init];
    if (self) {
        
        self.pagination = [DGPagination pagination];
    }
    return self;
}

@end

@implementation DGArtistReleaseResponse

+ (DGArtistReleaseResponse*) response
{
    return [[DGArtistReleaseResponse alloc] init];
}

- (void) loadNextPageWithSuccess:(void (^)())success failure:(void (^)(NSError* error))failure
{
    [self.pagination loadNextPageWithResponseDesciptor:[DGArtistReleaseResponse responseDescriptor] success:^(NSArray *objects) {
        if ([[objects firstObject] isKindOfClass:[DGArtistReleaseResponse class]]) {
            DGArtistReleaseResponse* response = [objects firstObject];
            
            self.pagination = response.pagination;
            NSMutableArray* releases = [self.releases mutableCopy];
            [releases addObjectsFromArray:response.releases];
            self.releases = releases;
            
            success();
        }
    } failure:^(NSError *error) {
        RKLogError(@"Operation failed with error: %@", error);
        failure(error);
    }];
}

@end
