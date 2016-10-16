// DGEndpoint+Configuration.h
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

#import "DGEndpoint.h"
#import "DGOperation.h"

NS_ASSUME_NONNULL_BEGIN

#define DGCheckReachability(ret) { \
    if(!self.isReachable) { \
        if(failure) \
            failure([self errorWithCode:NSURLErrorNotConnectedToInternet info:@"Not connected"]); \
        return ret; \
    } \
}

#define DGCheckURL(url, ret) { \
    if( !url || [url isEqualToString:@""] ) { \
        if (failure) \
            failure([self errorWithCode:NSURLErrorZeroByteResource info:@"URL is empty"]); \
        return ret; \
    } \
}

@interface DGEndpoint (Configuration)

@property (nonatomic, readonly) BOOL isReachable;

@property (nonatomic, readonly) RKObjectManager *manager;

- (instancetype)initWithManager:(RKObjectManager *)manager;

- (void)configureManager:(RKObjectManager *)objectManager;

- (NSError *)errorWithCode:(NSInteger)code info:(nullable NSString *)info;

@end

@interface RKErrorMessage (Mapping)

+ (RKMapping *)mapping;

+ (RKResponseDescriptor *)responseDescriptor;

@end

NS_ASSUME_NONNULL_END
