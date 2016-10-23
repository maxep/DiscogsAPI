//
//  DGMaketplaceTests.m
//  DiscogsAPI
//
//  Created by Maxime Epain on 23/10/2016.
//  Copyright © 2016 Maxime Epain. All rights reserved.
//

#import "DGTestCase.h"

#import <DiscogsAPI/DGListing+Mapping.h>
#import <DiscogsAPI/DGInventory+Mapping.h>

@interface DGMaketplaceTests<DGMarketplace> : DGTestCase

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


// Need a sample listing on discogs..

//- (void)testListingOperation {
//    DGListingRequest *request = [DGListingRequest new];
//    request.listingID = @349049876;
//    
//    DGOperation *operation = [self.manager operationWithRequest:request method:RKRequestMethodGET responseClass:[DGInventoryResponse class]];
//    
//    [operation start];
//    [operation waitUntilFinished];
//    
//    XCTAssertTrue(operation.HTTPRequestOperation.response.statusCode == 200, @"Expected 200 response");
//    XCTAssertTrue([operation.mappingResult.firstObject isKindOfClass:[DGInventoryResponse class]], @"Expected to load a profile");
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
    
    XCTAssertTrue(operation.HTTPRequestOperation.response.statusCode == 200, @"Expected 200 response");
    XCTAssertTrue([operation.mappingResult.firstObject isKindOfClass:[DGInventoryResponse class]], @"Expected to load a profile");
}

@end
