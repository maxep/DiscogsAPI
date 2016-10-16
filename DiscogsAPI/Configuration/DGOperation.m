// DGOperation.m
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

#import "DGOperation.h"

@implementation DGOperation {
    Class _responseClass;
}

+ (instancetype)operationWithRequest:(NSURLRequest *)request responseClass:(Class<DGResponseObject>)responseClass {
    return [[self alloc] initWithRequest:request responseClass:responseClass];
}

- (instancetype)initWithRequest:(NSURLRequest *)request responseClass:(Class<DGResponseObject>)responseClass {
    self = [super initWithRequest:request responseDescriptors:@[ [responseClass responseDescriptor] ]];
    if (self) {
        _responseClass = responseClass;
    }
    return self;
}

- (void)setCompletionBlockWithSuccess:(void (^)(id))success failure:(void (^)(NSError *))failure {
    
    __unsafe_unretained typeof(self) weakSelf = self;
    [super setCompletionBlockWithSuccess:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
        if ([mappingResult.firstObject isKindOfClass:weakSelf->_responseClass]) {
            success(mappingResult.firstObject);
            
        } else if (failure) {
            failure([NSError errorWithDomain:@"Discogs.api"
                                        code:NSURLErrorCannotParseResponse
                                    userInfo:@{NSLocalizedDescriptionKey : @"Bad response from Discogs server"}]);
        }
    } failure:^(RKObjectRequestOperation *operation, NSError *error) {
        RKLogError(@"Operation failed with error: %@", error);
        if (failure) failure(error);
    }];
}

- (NSError *)errorWithCode:(NSInteger)code info:(NSString *)info {
    return [NSError errorWithDomain:@"Discogs.api" code:code userInfo:@{NSLocalizedDescriptionKey : info}];
}

@end
