// Marketplace.m
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

#import "DGEndpoint+Private.h"
#import "DGMarketplace.h"

#import "DGInventory+Mapping.h"
#import "DGListing+Mapping.h"
#import "DGOrder+Mapping.h"
#import "DGPrice+Mapping.h"

@implementation DGMarketplace

- (void)configureManager:(DGObjectManager *)manager {
    
    //Inventory
    [manager.router.routeSet addRoute:[RKRoute routeWithClass:[DGInventoryRequest class] pathPattern:@"/users/:username/inventory" method:RKRequestMethodGET]];
    [manager addResponseDescriptor:[DGInventoryResponse responseDescriptor]];
    
    //Listing
    [manager.router.routeSet addRoute:[RKRoute routeWithClass:[DGListingRequest class] pathPattern:@"/marketplace/listings/:listingID" method:RKRequestMethodGET]];
    
    [manager.router.routeSet addRoute:[RKRoute routeWithClass:[DGListing class] pathPattern:@"/marketplace/listings/:ID" method:RKRequestMethodPOST]];
    [manager addRequestDescriptor:[DGListing requestDescriptor]];
    
    [manager.router.routeSet addRoute:[RKRoute routeWithClass:[DGCreateListingRequest class] pathPattern:@"/marketplace/listings" method:RKRequestMethodPOST]];
    [manager addRequestDescriptor:[DGCreateListingRequest requestDescriptor]];
    
    [manager.router.routeSet addRoute:[RKRoute routeWithClass:[DGListing class] pathPattern:@"/marketplace/listings/:ID" method:RKRequestMethodDELETE]];
    
    //Order
    [manager.router.routeSet addRoute:[RKRoute routeWithClass:[DGListOrdersRequest class] pathPattern:@"/marketplace/orders" method:RKRequestMethodGET]];
    [manager.router.routeSet addRoute:[RKRoute routeWithClass:[DGOrder class] pathPattern:@"/marketplace/orders/:ID" method:RKRequestMethodAny]];
    [manager addRequestDescriptor:[DGOrder requestDescriptor]];
    
    //Price suggestions
    [manager.router.routeSet addRoute:[RKRoute routeWithClass:[DGPriceSuggestionsRequest class] pathPattern:@"/marketplace/price_suggestions/:releaseID" method:RKRequestMethodGET]];
}

- (void)getInventory:(DGInventoryRequest *)request success:(void (^)(DGInventoryResponse *response))success failure:(nullable DGFailureBlock)failure {
    
    DGOperation *operation = [self.manager operationWithRequest:request method:RKRequestMethodGET responseClass:[DGInventoryResponse class]];
    [operation setCompletionBlockWithSuccess:success failure:failure];
    
    [self.manager enqueueOperation:operation];
}

- (void)getListing:(DGListingRequest *)request success:(void (^)(DGListing *listing))success failure:(nullable DGFailureBlock)failure {
    
    DGOperation *operation = [self.manager operationWithRequest:request method:RKRequestMethodGET responseClass:[DGListing class]];
    [operation setCompletionBlockWithSuccess:success failure:failure];

    [self.manager enqueueOperation:operation];
}

- (void)editListing:(DGListing *)listing success:(void (^)())success failure:(nullable DGFailureBlock)failure {
    
    DGOperation *operation = [self.manager operationWithRequest:listing method:RKRequestMethodPOST];
    [operation setCompletionBlockWithSuccess:success failure:failure];
    
    [self.manager enqueueOperation:operation];
}

- (void)createListing:(DGListing *)listing success:(void (^)(DGListing *listing))success failure:(nullable DGFailureBlock)failure {
    
    DGCreateListingRequest *request = [DGCreateListingRequest new];
    request.listing = listing;
    
    DGOperation<DGCreateListingResponse *> *operation = [self.manager operationWithRequest:request method:RKRequestMethodGET responseClass:[DGCreateListingResponse class]];
    [operation setCompletionBlockWithSuccess:^(DGCreateListingResponse *response) {
        listing.ID = response.listingID;
        listing.resourceURL = response.resourceURL;
        success(listing);
    } failure:failure];
    
    [self.manager enqueueOperation:operation];
}

- (void)deleteListing:(DGListing *)listing success:(void (^)())success failure:(nullable DGFailureBlock)failure {
    
    DGOperation *operation = [self.manager operationWithRequest:listing method:RKRequestMethodDELETE];
    [operation setCompletionBlockWithSuccess:success failure:failure];
    
    [self.manager enqueueOperation:operation];
}

- (void)getOrder:(NSNumber *)orderID success:(void (^)(DGOrder *order))success failure:(nullable DGFailureBlock)failure {
    
    DGOrder *order = [DGOrder new];
    order.ID = orderID;
    
    DGOperation *operation = [self.manager operationWithRequest:order method:RKRequestMethodGET responseClass:[DGOrder class]];
    [operation setCompletionBlockWithSuccess:success failure:failure];
    
    [self.manager enqueueOperation:operation];
}

- (void)getOrders:(DGListOrdersRequest *)request success:(void (^)(DGListOrdersResponse *response))success failure:(nullable DGFailureBlock)failure {
    
    DGOperation *operation = [self.manager operationWithRequest:request method:RKRequestMethodGET responseClass:[DGListOrdersResponse class]];
    [operation setCompletionBlockWithSuccess:success failure:failure];
    
    [self.manager enqueueOperation:operation];
}

- (void)editOrder:(DGOrder *)order success:(void (^)(DGOrder *order))success failure:(nullable DGFailureBlock)failure {
    
    DGOperation *operation = [self.manager operationWithRequest:order method:RKRequestMethodPOST responseClass:[DGOrder class]];
    [operation setCompletionBlockWithSuccess:success failure:failure];
    
    [self.manager enqueueOperation:operation];
}

- (void)getPriceSuggestions:(NSNumber *)releaseID success:(void (^)(DGPriceSuggestionsResponse *response))success failure:(nullable DGFailureBlock)failure {
    
    DGPriceSuggestionsRequest *request = [DGPriceSuggestionsRequest new];
    request.releaseID = releaseID;
    
    DGOperation *operation = [self.manager operationWithRequest:request method:RKRequestMethodGET responseClass:[DGPriceSuggestionsResponse class]];
    [operation setCompletionBlockWithSuccess:success failure:failure];
    
    [self.manager enqueueOperation:operation];
}

@end
