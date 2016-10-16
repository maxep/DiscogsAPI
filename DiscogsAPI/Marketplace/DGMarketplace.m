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
#import "DGInventory+Mapping.h"
#import "DGListing+Mapping.h"

@implementation DGMarketplace

- (void)configureManager:(RKObjectManager *)manager {
    
    //Inventory
    [manager.router.routeSet addRoute:[RKRoute routeWithClass:[DGInventoryRequest class] pathPattern:@"/users/:username/inventory" method:RKRequestMethodGET]];
    [manager addResponseDescriptor:[DGInventoryResponse responseDescriptor]];
    
    //Listing
    [manager.router.routeSet addRoute:[RKRoute routeWithClass:[DGListingRequest class] pathPattern:@"/marketplace/listings/:listingID" method:RKRequestMethodGET]];
    [manager.router.routeSet addRoute:[RKRoute routeWithClass:[DGListing class] pathPattern:@"/marketplace/listings/:ID" method:RKRequestMethodPOST]];
    [manager addRequestDescriptor:[DGListing requestDescriptor]];
    [manager.router.routeSet addRoute:[RKRoute routeWithClass:[DGCreateListingRequest class] pathPattern:@"/marketplace/listings/" method:RKRequestMethodPOST]];
    [manager addRequestDescriptor:[DGCreateListingRequest requestDescriptor]];
    [manager.router.routeSet addRoute:[RKRoute routeWithClass:[DGListing class] pathPattern:@"/marketplace/listings/:ID" method:RKRequestMethodDELETE]];
    
    //Price suggestions
    [manager.router.routeSet addRoute:[RKRoute routeWithClass:[DGPriceSuggectionsRequest class] pathPattern:@"/marketplace/price_suggestions/:releaseID" method:RKRequestMethodGET]];
}

- (void)getInventory:(DGInventoryRequest *)request success:(void (^)(DGInventoryResponse *response))success failure:(nullable DGFailureBlock)failure {
    DGCheckReachability();
    
    NSURLRequest *requestURL = [self.manager requestWithObject:request method:RKRequestMethodGET path:nil parameters:nil];
    
    RKObjectRequestOperation *operation = [self.manager objectRequestOperationWithRequest:requestURL success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
        
        if ([mappingResult.firstObject isKindOfClass:[DGInventoryResponse class]]) {
            success(mappingResult.firstObject);
        } else if (failure) {
            failure([self errorWithCode:NSURLErrorCannotParseResponse info:@"Bad response from Discogs server"]);
        }
    } failure:^(RKObjectRequestOperation *operation, NSError *error) {
        RKLogError(@"Operation failed with error: %@", error);
        if (failure) failure(error);
    }];
    
    [self.manager enqueueObjectRequestOperation:operation];
}

- (void)getListing:(DGListingRequest *)request success:(void (^)(DGListing *listing))success failure:(nullable DGFailureBlock)failure {
    DGCheckReachability();
    
    NSURLRequest *requestURL = [self.manager requestWithObject:request method:RKRequestMethodGET path:nil parameters:request.parameters];
    
    RKObjectRequestOperation *objectRequestOperation = [[RKObjectRequestOperation alloc] initWithRequest:requestURL responseDescriptors:@[ [DGListing responseDescriptor] ]];
    
    [objectRequestOperation setCompletionBlockWithSuccess:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
        
        if ([mappingResult.firstObject isKindOfClass:[DGListing class]]) {
            success(mappingResult.firstObject);
        } else if (failure) {
            failure([self errorWithCode:NSURLErrorCannotParseResponse info:@"Bad response from Discogs server"]);
        }
    } failure:^(RKObjectRequestOperation *operation, NSError *error) {
        RKLogError(@"Operation failed with error: %@", error);
        if (failure) failure(error);
    }];
    
    [self.manager enqueueObjectRequestOperation:objectRequestOperation];
}

- (void)editListing:(DGListing *)listing success:(void (^)())success failure:(nullable DGFailureBlock)failure {
    DGCheckReachability();
    
    NSURLRequest *requestURL = [self.manager requestWithObject:listing method:RKRequestMethodPOST path:nil parameters:nil];
    
    RKObjectRequestOperation *objectRequestOperation = [[RKObjectRequestOperation alloc] initWithRequest:requestURL responseDescriptors:self.manager.responseDescriptors];
    
    [objectRequestOperation setCompletionBlockWithSuccess:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
        success();
    } failure:^(RKObjectRequestOperation *operation, NSError *error) {
        RKLogError(@"Operation failed with error: %@", error);
        if (failure) failure(error);
    }];
    
    [self.manager enqueueObjectRequestOperation:objectRequestOperation];
}

- (void)createListing:(DGListing *)listing success:(void (^)(DGListing *listing))success failure:(nullable DGFailureBlock)failure {
    DGCheckReachability();
    
    DGCreateListingRequest *request = [DGCreateListingRequest new];
    request.listing = listing;
    
    NSURLRequest *requestURL = [self.manager requestWithObject:request method:RKRequestMethodPOST path:nil parameters:nil];
    
    RKObjectRequestOperation *objectRequestOperation = [[RKObjectRequestOperation alloc] initWithRequest:requestURL responseDescriptors:@[ [DGCreateListingResponse responseDescriptor] ]];
    
    [objectRequestOperation setCompletionBlockWithSuccess:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
        
        if ([mappingResult.firstObject isKindOfClass:[DGCreateListingResponse class]]) {
            DGCreateListingResponse *response = mappingResult.firstObject;
            listing.ID = response.listingID;
            listing.resourceURL = response.resourceURL;
            success(listing);
        } else if (failure) {
            failure([self errorWithCode:NSURLErrorCannotParseResponse info:@"Bad response from Discogs server"]);
        }
    } failure:^(RKObjectRequestOperation *operation, NSError *error) {
        RKLogError(@"Operation failed with error: %@", error);
        if (failure) failure(error);
    }];
    
    [self.manager enqueueObjectRequestOperation:objectRequestOperation];
}

- (void)deleteListing:(DGListing *)listing success:(void (^)())success failure:(nullable DGFailureBlock)failure {
    DGCheckReachability();
    
    NSURLRequest *requestURL = [self.manager requestWithObject:listing method:RKRequestMethodDELETE path:nil parameters:nil];
    
    RKObjectRequestOperation *objectRequestOperation = [[RKObjectRequestOperation alloc] initWithRequest:requestURL responseDescriptors:self.manager.responseDescriptors];
    
    [objectRequestOperation setCompletionBlockWithSuccess:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
        success();
    } failure:^(RKObjectRequestOperation *operation, NSError *error) {
        RKLogError(@"Operation failed with error: %@", error);
        if (failure) failure(error);
    }];
    
    [self.manager enqueueObjectRequestOperation:objectRequestOperation];
}

- (void)getPriceSuggestions:(NSNumber *)releaseID success:(void (^)(DGPriceSuggectionsResponse *response))success failure:(void (^)(NSError* error))failure {
    DGCheckReachability();
    
    DGPriceSuggectionsRequest *request = [DGPriceSuggectionsRequest request];
    request.releaseID = releaseID;
    
    NSURLRequest *requestURL = [self.manager requestWithObject:request method:RKRequestMethodGET path:nil parameters:nil];
    
    RKObjectRequestOperation *objectRequestOperation = [[RKObjectRequestOperation alloc] initWithRequest:requestURL responseDescriptors:@[ [DGPriceSuggectionsResponse responseDescriptor] ]];
    
    [objectRequestOperation setCompletionBlockWithSuccess:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
        
        if ([mappingResult.firstObject isKindOfClass:[DGPriceSuggectionsResponse class]]) {
            success(mappingResult.firstObject);
        } else if (failure) {
            failure([self errorWithCode:NSURLErrorCannotParseResponse info:@"Bad response from Discogs server"]);
        }
    } failure:^(RKObjectRequestOperation *operation, NSError *error) {
        RKLogError(@"Operation failed with error: %@", error);
        if (failure) failure(error);
    }];
    
    [self.manager enqueueObjectRequestOperation:objectRequestOperation];
}

@end
