//
//  DGUserTests.m
//  DiscogsAPI
//
//  Created by Maxime Epain on 22/10/2016.
//  Copyright © 2016 Maxime Epain. All rights reserved.
//

#import "DGTestCase.h"

#import <DiscogsAPI/DGProfile+Mapping.h>

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

@end
