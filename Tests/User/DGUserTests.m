//
//  DGUserTests.m
//  DiscogsAPI
//
//  Created by Maxime Epain on 22/10/2016.
//  Copyright © 2016 Maxime Epain. All rights reserved.
//

#import "DGTestCase.h"

#import <DiscogsAPI/DGProfile+Mapping.h>
#import <DiscogsAPI/DGWantlist+Mapping.h>

@interface DGUserTests<DGUser> : DGTestCase

@end

@implementation DGUserTests

- (void)setUp {
    [super setUp];
    
    self.endpoint = [[DGUser alloc] initWithManager:self.manager];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

#pragma mark Profile

- (void)testProfileMapping {
    id json = [RKTestFixture parsedObjectWithContentsOfFixture:@"profile.json"];
    RKMappingTest *test = [RKMappingTest testForMapping:[DGProfile mapping] sourceObject:json destinationObject:nil];
    
    [test addExpectation:[RKPropertyMappingTestExpectation expectationWithSourceKeyPath:@"username" destinationKeyPath:@"userName" value:@"rodneyfool"]];
    [test addExpectation:[RKPropertyMappingTestExpectation expectationWithSourceKeyPath:@"id" destinationKeyPath:@"ID" value:@1578108]];
    XCTAssertTrue(test.evaluate);
}

- (void)testProfileOperation {
    DGProfile *profile = [DGProfile new];
    profile.userName = @"rodneyfool";
    
    DGOperation *operation = [self.manager operationWithRequest:profile method:RKRequestMethodGET responseClass:[DGProfile class]];
    
    [operation start];
    [operation waitUntilFinished];
    
    XCTAssertTrue(operation.HTTPRequestOperation.response.statusCode == 200, @"Expected 200 response");
    XCTAssertTrue([operation.mappingResult.firstObject isKindOfClass:[DGProfile class]], @"Expected to load a profile");
}

- (void)testEditProfileOperation {
    DGProfile *profile = [DGProfile new];
    profile.userName = @"maxepTestUser";
    
    DGOperation<DGProfile *> *operation = [self.manager operationWithRequest:profile method:RKRequestMethodGET responseClass:[DGProfile class]];
    
    [operation start];
    [operation waitUntilFinished];
    
    XCTAssertTrue(operation.HTTPRequestOperation.response.statusCode == 200, @"Expected 200 response");
    XCTAssertTrue([operation.mappingResult.firstObject isKindOfClass:[DGProfile class]], @"Expected to load a profile");
    
    profile = operation.mappingResult.firstObject;
    profile.profile = @"Test";
    operation = [self.manager operationWithRequest:profile method:RKRequestMethodPOST responseClass:[DGProfile class]];
    
    [operation start];
    [operation waitUntilFinished];
    
    XCTAssertTrue(operation.HTTPRequestOperation.response.statusCode == 200, @"Expected 200 response");
    XCTAssertTrue([operation.mappingResult.firstObject isKindOfClass:[DGProfile class]], @"Expected to load a profile");
    XCTAssertEqualObjects([operation.mappingResult.firstObject profile], @"Test", @"Expected to edit profile");
    
    profile.profile = @"";
    operation = [self.manager operationWithRequest:profile method:RKRequestMethodPOST responseClass:[DGProfile class]];
    
    [operation start];
    [operation waitUntilFinished];
}

#pragma mark Wantlist

- (void)testWantlistMapping {
    
    DGWantlistResponse *response = [DGWantlistResponse new];
    id json = [RKTestFixture parsedObjectWithContentsOfFixture:@"wantlist.json"];
    RKMappingTest *test = [RKMappingTest testForMapping:DGWantlistResponse.responseDescriptor.mapping sourceObject:json destinationObject:response];
    
    XCTAssertTrue(test.evaluate);
    
    XCTAssertEqualObjects(response.pagination.perPage, @50);
    XCTAssertEqualObjects(response.pagination.pages, @1);
    XCTAssertEqualObjects(response.pagination.page, @1);
    XCTAssertEqualObjects(response.pagination.items, @2);
    
    DGWant *want = response.wants[0];
    XCTAssertEqualObjects(want.rating, @4);
    XCTAssertEqualObjects(want.basicInformation.title, @"Year Zero");
    XCTAssertEqualObjects(want.basicInformation.ID, @1867708);
}

- (void)testWantlistOperation {
    DGWantlistRequest *request = [DGWantlistRequest new];
    request.userName = @"maxepTestUser";
    
    DGOperation *operation = [self.manager operationWithRequest:request method:RKRequestMethodGET responseClass:[DGWantlistResponse class]];
    
    [operation start];
    [operation waitUntilFinished];
    
    XCTAssertTrue(operation.HTTPRequestOperation.response.statusCode == 200, @"Expected 200 response");
    XCTAssertTrue([operation.mappingResult.firstObject isKindOfClass:[DGWantlistResponse class]], @"Expected to load a profile");
}

@end
