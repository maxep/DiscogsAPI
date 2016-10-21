//
//  DGDatabaseTests.m
//  DiscogsAPI
//
//  Created by Maxime Epain on 21/10/2016.
//  Copyright © 2016 Maxime Epain. All rights reserved.
//

#import "DGTestCase.h"

#import <DiscogsAPI/DGRelease+Mapping.h>
#import <DiscogsAPI/DGMaster+Mapping.h>
#import <DiscogsAPI/DGArtist+Mapping.h>
#import <DiscogsAPI/DGLabel+Mapping.h>

@interface DGDatabaseTests<DGDatabase> : DGTestCase

@end

@implementation DGDatabaseTests

- (void)setUp {
    [super setUp];
    
    self.endpoint = [[DGDatabase alloc] initWithManager:self.manager];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

#pragma mark Release

- (void)testReleaseMapping {
    id json = [RKTestFixture parsedObjectWithContentsOfFixture:@"release.json"];
    RKMappingTest *test = [RKMappingTest testForMapping:[DGRelease mapping] sourceObject:json destinationObject:nil];
    
    [test addExpectation:[RKPropertyMappingTestExpectation expectationWithSourceKeyPath:@"title" destinationKeyPath:@"title" value:@"Never Gonna Give You Up"]];
    [test addExpectation:[RKPropertyMappingTestExpectation expectationWithSourceKeyPath:@"id" destinationKeyPath:@"ID" value:@249504]];
    XCTAssertTrue(test.evaluate);
}
    
- (void)testReleaseOperation {
    DGRelease *release = [DGRelease new];
    release.ID = @249504;
    
    DGOperation *operation = [self.manager operationWithRequest:release method:RKRequestMethodGET responseClass:[DGRelease class]];
    
    [operation start];
    [operation waitUntilFinished];
    
    XCTAssertTrue(operation.HTTPRequestOperation.response.statusCode == 200, @"Expected 200 response");
    XCTAssertTrue([operation.mappingResult.firstObject isKindOfClass:[DGRelease class]], @"Expected to load a release");
}

#pragma mark Master

- (void)testMasterMapping {
    id json = [RKTestFixture parsedObjectWithContentsOfFixture:@"master.json"];
    RKMappingTest *test = [RKMappingTest testForMapping:[DGMaster mapping] sourceObject:json destinationObject:nil];
    
    [test addExpectation:[RKPropertyMappingTestExpectation expectationWithSourceKeyPath:@"title" destinationKeyPath:@"title" value:@"Stardiver"]];
    [test addExpectation:[RKPropertyMappingTestExpectation expectationWithSourceKeyPath:@"id" destinationKeyPath:@"ID" value:@1000]];
    XCTAssertTrue(test.evaluate);
}

- (void)testMasterOperation {
    DGMaster *master = [DGMaster new];
    master.ID = @1000;
    
    DGOperation *operation = [self.manager operationWithRequest:master method:RKRequestMethodGET responseClass:[DGMaster class]];
    
    [operation start];
    [operation waitUntilFinished];
    
    XCTAssertTrue(operation.HTTPRequestOperation.response.statusCode == 200, @"Expected 200 response");
    XCTAssertTrue([operation.mappingResult.firstObject isKindOfClass:[DGMaster class]], @"Expected to load a master");
}

#pragma mark Artist

- (void)testArtistMapping {
    id json = [RKTestFixture parsedObjectWithContentsOfFixture:@"artist.json"];
    RKMappingTest *test = [RKMappingTest testForMapping:[DGMaster mapping] sourceObject:json destinationObject:nil];
    
    [test addExpectation:[RKPropertyMappingTestExpectation expectationWithSourceKeyPath:@"id" destinationKeyPath:@"ID" value:@108713]];
    XCTAssertTrue(test.evaluate);
}

- (void)testArtistOperation {
    DGArtist *artist = [DGArtist new];
    artist.ID = @108713;
    
    DGOperation *operation = [self.manager operationWithRequest:artist method:RKRequestMethodGET responseClass:[DGArtist class]];
    
    [operation start];
    [operation waitUntilFinished];
    
    XCTAssertTrue(operation.HTTPRequestOperation.response.statusCode == 200, @"Expected 200 response");
    XCTAssertTrue([operation.mappingResult.firstObject isKindOfClass:[DGArtist class]], @"Expected to load an artist");
}

#pragma mark Label

- (void)testLabeltMapping {
    id json = [RKTestFixture parsedObjectWithContentsOfFixture:@"label.json"];
    RKMappingTest *test = [RKMappingTest testForMapping:[DGMaster mapping] sourceObject:json destinationObject:nil];
    
    [test addExpectation:[RKPropertyMappingTestExpectation expectationWithSourceKeyPath:@"id" destinationKeyPath:@"ID" value:@1]];
    XCTAssertTrue(test.evaluate);
}

- (void)testLabelOperation {
    DGLabel *label = [DGLabel new];
    label.ID = @1;
    
    DGOperation *operation = [self.manager operationWithRequest:label method:RKRequestMethodGET responseClass:[DGLabel class]];
    
    [operation start];
    [operation waitUntilFinished];
    
    XCTAssertTrue(operation.HTTPRequestOperation.response.statusCode == 200, @"Expected 200 response");
    XCTAssertTrue([operation.mappingResult.firstObject isKindOfClass:[DGLabel class]], @"Expected to load a label");
}

@end
