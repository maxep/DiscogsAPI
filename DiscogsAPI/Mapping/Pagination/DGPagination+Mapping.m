// DGPagination+Mapping.m
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

@implementation DGPaginationUrls (Mapping)

+ (RKMapping *)mapping {
    RKObjectMapping *mapping = [RKObjectMapping mappingForClass:[DGPaginationUrls class]];
    [mapping addAttributeMappingsFromDictionary:@{
                                                  @"first"  : @"first",
                                                  @"prev"   : @"prev",
                                                  @"next"   : @"next",
                                                  @"last"   : @"last"
                                                  }
     ];
    
    return mapping;
}

@end

@implementation DGPagination (Mapping)

+ (RKMapping *)mapping {
    RKObjectMapping *mapping = [RKObjectMapping mappingForClass:[DGPagination class]];
    [mapping addAttributeMappingsFromDictionary:@{
                                                  @"page"       : @"page",
                                                  @"pages"      : @"pages",
                                                  @"items"      : @"items",
                                                  @"per_page"   : @"perPage"
                                                  }
     ];
    
    [mapping addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"urls" toKeyPath:@"urls" withMapping:[DGPaginationUrls mapping]]];
    
    return mapping;
}

+ (RKResponseDescriptor *)responseDescriptor {
    return [RKResponseDescriptor responseDescriptorWithMapping:[DGPagination mapping] method:RKRequestMethodAny pathPattern:nil keyPath:@"pagination" statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)];
}

- (NSDictionary *)parameters {
    return @{ @"page" : self.page, @"per_page" : self.perPage };
}

- (void)loadNextPageWithResponseDesciptor:(RKResponseDescriptor *)responseDescriptor success:(void (^)(NSArray *objects))success failure:(void (^)(NSError *error))failure {
    if(self.urls.next) {
        
        RKObjectManager *manager = [RKObjectManager sharedManager];
        NSURLRequest *requestURL = [manager.HTTPClient requestWithMethod:@"GET" path:self.urls.next parameters:nil];
        
        RKObjectRequestOperation *objectRequestOperation = [[RKObjectRequestOperation alloc] initWithRequest:requestURL responseDescriptors:@[ responseDescriptor ]];
        
        [objectRequestOperation setCompletionBlockWithSuccess:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
             success(mappingResult.array);
         } failure:^(RKObjectRequestOperation *operation, NSError *error) {
             RKLogError(@"Operation failed with error: %@", error);
             if (failure) failure(error);
         }];
        
        [manager enqueueObjectRequestOperation:objectRequestOperation];
    }
}

@end
