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
    [manager.router.routeSet addRoute:[RKRoute routeWithClass:[DGPriceSuggestionsRequest class] pathPattern:@"/marketplace/price_suggestions/:releaseID" method:RKRequestMethodGET]];
}

- (void)getInventory:(DGInventoryRequest *)request success:(void (^)(DGInventoryResponse *response))success failure:(nullable DGFailureBlock)failure {
    DGCheckReachability();
    
    DGOperation *operation = [self.manager operationWithRequest:request method:RKRequestMethodGET responseClass:[DGInventoryResponse class]];
    [operation setCompletionBlockWithSuccess:success failure:failure];
    
    [self.manager enqueueObjectRequestOperation:operation];
}

- (void)getListing:(DGListingRequest *)request success:(void (^)(DGListing *listing))success failure:(nullable DGFailureBlock)failure {
    DGCheckReachability();
    
    DGOperation *operation = [self.manager operationWithRequest:request method:RKRequestMethodGET responseClass:[DGListing class]];
    [operation setCompletionBlockWithSuccess:success failure:failure];

    [self.manager enqueueObjectRequestOperation:operation];
}

- (void)editListing:(DGListing *)listing success:(void (^)())success failure:(nullable DGFailureBlock)failure {
    DGCheckReachability();
    
    DGOperation *operation = [self.manager operationWithRequest:listing method:RKRequestMethodPOST];
    [operation setCompletionBlockWithSuccess:success failure:failure];
    
    [self.manager enqueueObjectRequestOperation:operation];
}

- (void)createListing:(DGListing *)listing success:(void (^)(DGListing *listing))success failure:(nullable DGFailureBlock)failure {
    DGCheckReachability();
    
    DGCreateListingRequest *request = [DGCreateListingRequest new];
    request.listing = listing;
    
    DGOperation<DGCreateListingResponse *> *operation = [self.manager operationWithRequest:request method:RKRequestMethodGET responseClass:[DGCreateListingResponse class]];
    [operation setCompletionBlockWithSuccess:^(DGCreateListingResponse *response) {
        listing.ID = response.listingID;
        listing.resourceURL = response.resourceURL;
        success(listing);
    } failure:failure];
    
    [self.manager enqueueObjectRequestOperation:operation];
}

- (void)deleteListing:(DGListing *)listing success:(void (^)())success failure:(nullable DGFailureBlock)failure {
    DGCheckReachability();
    
    DGOperation *operation = [self.manager operationWithRequest:listing method:RKRequestMethodDELETE];
    [operation setCompletionBlockWithSuccess:success failure:failure];
    
    [self.manager enqueueObjectRequestOperation:operation];
}

- (void)getPriceSuggestions:(NSNumber *)releaseID success:(void (^)(DGPriceSuggestionsResponse *response))success failure:(void (^)(NSError* error))failure {
    DGCheckReachability();
    
    DGPriceSuggestionsRequest *request = [DGPriceSuggestionsRequest new];
    request.releaseID = releaseID;
    
    DGOperation *operation = [self.manager operationWithRequest:request method:RKRequestMethodGET responseClass:[DGPriceSuggestionsResponse class]];
    [operation setCompletionBlockWithSuccess:success failure:failure];
    
    [self.manager enqueueObjectRequestOperation:operation];
}

@end
