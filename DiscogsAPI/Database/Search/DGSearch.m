// DGSearch.m
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

#import "DGPagination+Mapping.h"
#import "DGSearch+Mapping.h"

@implementation DGSearchRequest

- (id)init {
    self = [super init];
    if (self) {
        self.pagination = [DGPagination new];
    }
    return self;
}

@end

@implementation DGSearchResult

- (instancetype)init {
    self = [super init];
    if (self) {
        self.style = @[];
        self.format = @[];
        self.label = @[];
        self.genre = @[];
    }
    return self;
}

@end

@implementation DGSearchResponse

@synthesize pagination;

- (instancetype)init {
    self = [super init];
    if (self) {
        self.results = @[];
    }
    return self;
}

- (void)loadNextPageWithSuccess:(void (^)())success failure:(void (^)(NSError *error))failure {
    [self.pagination loadNextPageWithResponseDesciptor:[DGSearchResponse responseDescriptor] success:^(NSArray *objects) {
        if ([[objects firstObject] isKindOfClass:[DGSearchResponse class]]) {
            DGSearchResponse* response = [objects firstObject];
            
            self.pagination = response.pagination;
            NSMutableArray* results = [self.results mutableCopy];
            [results addObjectsFromArray:response.results];
            self.results = results;
            
            success();
        }
    } failure:^(NSError *error) {
        RKLogError(@"Operation failed with error: %@", error);
        if (failure) failure(error);
    }];
}

@end
