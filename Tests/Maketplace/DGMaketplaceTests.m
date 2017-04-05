// DGMaketplaceTests.m
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

#import "DGTestCase.h"

#import <DiscogsAPI/DGListing+Mapping.h>
#import <DiscogsAPI/DGInventory+Mapping.h>

@interface DGMaketplaceTests : DGTestCase<DGMarketplace *>

@end

@implementation DGMaketplaceTests

- (void)setUp {
    [super setUp];
    
    self.endpoint = [[DGMarketplace alloc] initWithManager:self.manager];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

#pragma mark Listing

- (void)testListingMapping {
    
    DGListing *listing = [DGListing new];
    id json = [RKTestFixture parsedObjectWithContentsOfFixture:@"listing.json"];
    RKMappingTest *test = [RKMappingTest testForMapping:DGListing.mapping sourceObject:json destinationObject:listing];
    
    XCTAssertTrue(test.evaluate);
    
    XCTAssertEqualObjects(listing.status, @"For Sale");
    XCTAssertEqualObjects(listing.price.currency, @"USD");
    XCTAssertEqualObjects(listing.price.value, @120);
    XCTAssertFalse(listing.allowOffers);
    XCTAssertEqualObjects(listing.sleeveCondition, @"Mint (M)");
    XCTAssertEqualObjects(listing.ID, @172723812);
}


// TODO : Need a sample listing on discogs..

//- (void)testListingOperation {
//    DGListingRequest *request = [DGListingRequest new];
//    request.listingID = @349049876;
//    
//    DGOperation *operation = [self.manager operationWithRequest:request method:RKRequestMethodGET responseClass:[DGInventoryResponse class]];
//    
//    [operation start];
//    [operation waitUntilFinished];
//    
//    XCTAssertEqual(operation.HTTPRequestOperation.response.statusCode, 200, @"Expected 200 response");
//    XCTAssertTrue([operation.response isKindOfClass:[DGInventoryResponse class]], @"Expected to load a profile");
//}

#pragma mark Inventory

- (void)testInventoryMapping {
    
    DGInventoryResponse *response = [DGInventoryResponse new];
    id json = [RKTestFixture parsedObjectWithContentsOfFixture:@"inventory.json"];
    RKMappingTest *test = [RKMappingTest testForMapping:DGInventoryResponse.responseDescriptor.mapping sourceObject:json destinationObject:response];
    
    XCTAssertTrue(test.evaluate);
    
    XCTAssertEqualObjects(response.pagination.perPage, @50);
    XCTAssertEqualObjects(response.pagination.pages, @1);
    XCTAssertEqualObjects(response.pagination.page, @1);
    XCTAssertEqualObjects(response.pagination.items, @4);
    
    DGListing *listing = response.listings[0];
    XCTAssertEqualObjects(listing.status, @"For Sale");
    XCTAssertEqualObjects(listing.price.currency, @"USD");
    XCTAssertEqualObjects(listing.price.value, @149.99);
    XCTAssertTrue(listing.allowOffers);
    XCTAssertEqualObjects(listing.sleeveCondition, @"Near Mint (NM or M-)");
    XCTAssertEqualObjects(listing.ID, @150899904);
}

- (void)testInventoryOperation {
    DGInventoryRequest *request = [DGInventoryRequest new];
    request.username = @"maxepTestUser";
    
    DGOperation *operation = [self.manager operationWithRequest:request method:RKRequestMethodGET responseClass:[DGInventoryResponse class]];
    
    [operation start];
    [operation waitUntilFinished];
    
    XCTAssertEqual(operation.HTTPRequestOperation.response.statusCode, 200, @"Expected 200 response");
    XCTAssertTrue([operation.response isKindOfClass:[DGInventoryResponse class]], @"Expected to load a profile");
}

@end
