// DGUserTests.m
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

#import <DiscogsAPI/DGProfile+Mapping.h>

@interface DGUserTests : DGTestCase<DGUser *>

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
    
    XCTAssertEqual(operation.HTTPRequestOperation.response.statusCode, 200, @"Expected 200 response");
    XCTAssertTrue([operation.response isKindOfClass:[DGProfile class]], @"Expected to load a profile");
}

- (void)testEditProfileOperation {
    DGProfile *profile = [DGProfile new];
    profile.userName = @"maxepTestUser";
    
    DGOperation<DGProfile *> *operation = [self.manager operationWithRequest:profile method:RKRequestMethodGET responseClass:[DGProfile class]];
    
    [operation start];
    [operation waitUntilFinished];
    
    XCTAssertEqual(operation.HTTPRequestOperation.response.statusCode, 200, @"Expected 200 response");
    XCTAssertTrue([operation.response isKindOfClass:[DGProfile class]], @"Expected to load a profile");
    
    profile = operation.response;
    profile.profile = @"Test";
    operation = [self.manager operationWithRequest:profile method:RKRequestMethodPOST responseClass:[DGProfile class]];
    
    [operation start];
    [operation waitUntilFinished];
    
    XCTAssertEqual(operation.HTTPRequestOperation.response.statusCode, 200, @"Expected 200 response");
    XCTAssertTrue([operation.response isKindOfClass:[DGProfile class]], @"Expected to load a profile");
    XCTAssertEqualObjects([operation.response profile], @"Test", @"Expected to edit profile");
    
    profile.profile = @"";
    operation = [self.manager operationWithRequest:profile method:RKRequestMethodPOST responseClass:[DGProfile class]];
    
    [operation start];
    [operation waitUntilFinished];
}

@end
