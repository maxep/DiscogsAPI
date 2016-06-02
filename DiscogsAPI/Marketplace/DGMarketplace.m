// Marketplace.m
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

#import "DGEndpoint+Configuration.h"
#import "DGMarketplace.h"

#import "DGPrice+Mapping.h"

@implementation DGMarketplace

- (void)configureManager:(RKObjectManager*)objectManager {
    [super configureManager:objectManager];
    
    //Price suggestions
    [objectManager.router.routeSet addRoute:[RKRoute routeWithClass:[DGPriceSuggectionsRequest class] pathPattern:@"/marketplace/price_suggestions/:releaseID" method:RKRequestMethodGET]];
}

- (void)getPriceSuggestions:(NSNumber*)releaseID success:(void (^)(DGPriceSuggectionsResponse* response))success failure:(void (^)(NSError* error))failure {
    DGCheckReachability();
    
    DGPriceSuggectionsRequest* request = [DGPriceSuggectionsRequest request];
    request.releaseID = releaseID;
    
    NSURLRequest *requestURL = [self.manager requestWithObject:request method:RKRequestMethodGET path:nil parameters:nil];
    
    RKObjectRequestOperation *objectRequestOperation = [[RKObjectRequestOperation alloc] initWithRequest:requestURL responseDescriptors:@[ [DGPriceSuggectionsResponse responseDescriptor] ]];
    
    [objectRequestOperation setCompletionBlockWithSuccess:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
        
        NSArray* results = mappingResult.array;
        if ([[results firstObject] isKindOfClass:[DGPriceSuggectionsResponse class]]) {
            success([results firstObject]);
        }
        else {
            failure([self errorWithCode:NSURLErrorCannotParseResponse info:@"Bad response from Discogs server"]);
        }
    } failure:^(RKObjectRequestOperation *operation, NSError *error) {
        RKLogError(@"Operation failed with error: %@", error);
        failure(error);
    }];
    
    [self.manager enqueueObjectRequestOperation:objectRequestOperation];
}

@end
