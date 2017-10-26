// DGOrder.m
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

#import "DGOrder+Mapping.h"
#import "DGPagination+Mapping.h"

NSString * DGSortOrdersAsString(DGSortOrders sort) {
    return @[@"id", @"buyer", @"created", @"status", @"last_activity"][sort];
}

@implementation DGOrderItem

@end

@implementation DGOrder

@end

@implementation DGListOrdersRequest

- (instancetype)init {
    self = [super init];
    if (self) {
        self.status = @"All";
        self.pagination = [DGPagination new];
    }
    return self;
}

@end

@implementation DGListOrdersResponse

@synthesize pagination;

- (instancetype)init {
    self = [super init];
    if (self) {
        self.orders = @[];
    }
    return self;
}

- (void)loadNextPageWithSuccess:(void (^)(void))success failure:(nullable void (^)(NSError * _Nullable error))failure {
    
    [self.pagination loadNextPageWithResponseClass:[DGListOrdersResponse class] success:^(DGListOrdersResponse *response) {
        self.pagination = response.pagination;
        self.orders = [self.orders arrayByAddingObjectsFromArray:response.orders];
        success();
    } failure:^(NSError *error) {
        RKLogError(@"Operation failed with error: %@", error);
        if (failure) failure(error);
    }];
}

@end

