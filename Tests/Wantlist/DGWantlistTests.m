// DGWantlistTests.m
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

#import <DiscogsAPI/DGWantlist+Mapping.h>

@interface DGWantlistTests : DGTestCase<DGWantlist *>

@end

@implementation DGWantlistTests

- (void)setUp {
    [super setUp];
    
    self.endpoint = [[DGWantlist alloc] initWithManager:self.manager];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
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
    
    XCTAssertEqual(operation.HTTPRequestOperation.response.statusCode, 200, @"Expected 200 response");
    XCTAssertTrue([operation.response isKindOfClass:[DGWantlistResponse class]], @"Expected to load a wantlist response");
}

- (void)testEditWentlist {
    
    DGWantRequest *request = [DGWantRequest new];
    request.userName = @"maxepTestUser";
    request.releaseID = @4997673;
    
    DGOperation *operation = [self.manager operationWithRequest:request method:RKRequestMethodPUT responseClass:[DGWant class]];
    
    [operation start];
    [operation waitUntilFinished];
    
    XCTAssertEqual(operation.HTTPRequestOperation.response.statusCode, 201, @"Expected 201 response");
    XCTAssertTrue([operation.response isKindOfClass:[DGWant class]], @"Expected to load a wanted release");
    
    request.notes = @"Test";
    
    operation = [self.manager operationWithRequest:request method:RKRequestMethodPOST responseClass:[DGWant class]];
    
    [operation start];
    [operation waitUntilFinished];
    
    XCTAssertEqual(operation.HTTPRequestOperation.response.statusCode, 200, @"Expected 200 response");
    XCTAssertTrue([operation.response isKindOfClass:[DGWant class]], @"Expected to load a wanted release");
    XCTAssertEqualObjects([operation.response notes], request.notes);

    operation = [self.manager operationWithRequest:request method:RKRequestMethodDELETE];
    
    [operation start];
    [operation waitUntilFinished];
    
    XCTAssertEqual(operation.HTTPRequestOperation.response.statusCode, 204, @"Expected 204 response");
}


@end
