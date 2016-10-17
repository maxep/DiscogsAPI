// DGUser.m
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
#import "DGIdentity+Mapping.h"
#import "DGProfile+Mapping.h"

#import "DGUser.h"

@implementation DGUser

@synthesize wantlist    = _wantlist;
@synthesize collection  = _collection;

#pragma mark Properties

- (DGWantlist *)wantlist {
    if (!_wantlist) {
        _wantlist = [[DGWantlist alloc] initWithManager:self.manager];
    }
    return _wantlist;
}

- (DGCollection *)collection {
    if (!_collection) {
        _collection = [[DGCollection alloc] initWithManager:self.manager];
    }
    return _collection;
}

#pragma mark Configuration

- (void)configureManager:(RKObjectManager*)objectManager {
    //User Profile
    [objectManager.router.routeSet addRoute:[RKRoute routeWithClass:[DGProfile class] pathPattern:@"users/:userName" method:RKRequestMethodAny]];
}

#pragma mark Public Methods

- (void)getProfile:(NSString *)userName success:(void (^)(DGProfile *profile))success failure:(void (^)(NSError *error))failure {
    DGCheckReachability();
    
    DGProfile *profile = [DGProfile profile];
    profile.userName = userName;
    
    DGOperation *operation = [self.manager operationWithRequest:profile method:RKRequestMethodGET responseClass:[DGProfile class]];
    [operation setCompletionBlockWithSuccess:success failure:failure];
    
    [self.manager enqueueObjectRequestOperation:operation];
}

- (void)editProfile:(DGProfile *)profile success:(void (^)(DGProfile *profile))success failure:(void (^)(NSError *error))failure {

    DGCheckReachability();
    
    DGOperation *operation = [self.manager operationWithRequest:profile method:RKRequestMethodPOST responseClass:[DGProfile class]];
    [operation setCompletionBlockWithSuccess:success failure:failure];
    
    [self.manager enqueueObjectRequestOperation:operation];
}

@end
