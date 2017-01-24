// DGCollectionTests.m
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

#import <DiscogsAPI/DGCollectionFolder+Mapping.h>
#import <DiscogsAPI/DGCollectionField+Mapping.h>
#import <DiscogsAPI/DGCollectionFieldInstance+Mapping.h>

@interface DGCollectionTests : DGTestCase<DGCollection *>

@end

@implementation DGCollectionTests

- (void)setUp {
    [super setUp];
    
    self.endpoint = [[DGCollection alloc] initWithManager:self.manager];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

#pragma mark Folders

- (void)testFolderMapping {
    id json = [RKTestFixture parsedObjectWithContentsOfFixture:@"folder.json"];
    DGCollectionFolder *folder = [DGCollectionFolder new];
    RKMappingTest *test = [RKMappingTest testForMapping:[DGCollectionFolder mapping] sourceObject:json destinationObject:folder];
    
    XCTAssertTrue(test.evaluate);
    
    XCTAssertEqualObjects(folder.ID, @232842);
    XCTAssertEqualObjects(folder.count, @0);
    XCTAssertEqualObjects(folder.name, @"My Music");
    XCTAssertEqualObjects(folder.resourceURL, @"https://api.discogs.com/users/example/collection/folders/232842");
}

- (void)testCollectionFolderOperation {
    DGCollectionFolderItemsRequest *request = [DGCollectionFolderItemsRequest new];
    request.userName = @"maxepTestUser";
    
    DGOperation *operation = [self.manager operationWithRequest:request method:RKRequestMethodGET responseClass:[DGCollectionItemsResponse class]];
    
    [operation start];
    [operation waitUntilFinished];
    
    XCTAssertTrue(operation.HTTPRequestOperation.response.statusCode == 200, @"Expected 200 response");
    XCTAssertTrue([operation.mappingResult.firstObject isKindOfClass:[DGCollectionItemsResponse class]], @"Expected to load a profile");
}

#pragma mark Fields

- (void)testFieldMapping {
    id json = [RKTestFixture parsedObjectWithContentsOfFixture:@"field.json"];
    DGCollectionField *field = [DGCollectionField new];
    RKMappingTest *test = [RKMappingTest testForMapping:[DGCollectionField mapping] sourceObject:json destinationObject:field];
    
    XCTAssertTrue(test.evaluate);
    
    XCTAssertEqualObjects(field.ID, @1);
    XCTAssertEqualObjects(field.position, @1);
    XCTAssertEqualObjects(field.name, @"Media");
    XCTAssertEqualObjects(field.type, @"dropdown");
    XCTAssertTrue(field.isPublic);
    XCTAssertTrue(field.options.count == 8);
}

#pragma mark Collection

- (void)testCollectionMapping {
    
    DGCollectionItemsResponse *response = [DGCollectionItemsResponse new];
    id json = [RKTestFixture parsedObjectWithContentsOfFixture:@"collection.json"];
    RKMappingTest *test = [RKMappingTest testForMapping:DGCollectionItemsResponse.responseDescriptor.mapping sourceObject:json destinationObject:response];
    
    XCTAssertTrue(test.evaluate);
    
    XCTAssertEqualObjects(response.pagination.perPage, @50);
    XCTAssertEqualObjects(response.pagination.pages, @1);
    XCTAssertEqualObjects(response.pagination.page, @1);
    XCTAssertEqualObjects(response.pagination.items, @28);
    
    DGReleaseInstance *instance = response.releases[0];
    XCTAssertEqualObjects(instance.rating, @4);
    XCTAssertEqualObjects(instance.basicInformation.title, @"The BBC Radio Sessions");
    XCTAssertEqualObjects(instance.basicInformation.ID, @7781525);
}

- (void)testCollectionReleaseOperation {
    DGCollectionReleaseItemsRequest *request = [DGCollectionReleaseItemsRequest new];
    request.userName = @"maxepTestUser";
    request.releaseID = @371951;
    
    DGOperation *operation = [self.manager operationWithRequest:request method:RKRequestMethodGET responseClass:[DGCollectionItemsResponse class]];
    
    [operation start];
    [operation waitUntilFinished];
    
    XCTAssertTrue(operation.HTTPRequestOperation.response.statusCode == 200, @"Expected 200 response");
    XCTAssertTrue([operation.mappingResult.firstObject isKindOfClass:[DGCollectionItemsResponse class]], @"Expected to load a profile");
}

@end
