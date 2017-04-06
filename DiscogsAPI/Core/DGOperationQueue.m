// DGOperationQueue.m
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

#import "DGOperationQueue.h"

NSTimeInterval const kDGRateLimitWindow = 60;

@interface DGOperationQueue ()

@property (nonatomic) NSInteger rateLimit;
@property (nonatomic) NSInteger rateLimitRemaining;

/// The delay between requests that comply the rate limit.
@property (nonatomic, readonly) NSTimeInterval delay;

@property (nonatomic, strong) NSOperationQueue *throttlingQueue;
@property (nonatomic, strong) NSOperationQueue *updateQueue;
@end

@implementation DGOperationQueue {
    dispatch_queue_t _serial_queue;
}

static NSString * const kDGRatelimit = @"X-Discogs-Ratelimit";
static NSString * const kDGRatelimitRemaining = @"X-Discogs-Ratelimit-Remaining";

- (instancetype)init {
    return [self initWithRateLimit:240];
}

- (instancetype)initWithRateLimit:(NSInteger)rateLimit {
    self = [super init];
    if (self) {
        self.rateLimit = rateLimit;
        self.rateLimitRemaining = rateLimit;
        
        _serial_queue = dispatch_queue_create("fr.maxep.DiscogsAPI.throttlingQueue", DISPATCH_QUEUE_SERIAL);
        
        self.throttlingQueue = [[NSOperationQueue alloc] init];
        self.throttlingQueue.underlyingQueue = _serial_queue;
        
        self.updateQueue = [[NSOperationQueue alloc] init];
        self.updateQueue.maxConcurrentOperationCount = 1;
    }
    return self;
}

- (void)addOperation:(NSOperation *)op {
    
    if (self.delay > 0) {
        NSOperation *delayOperation = [NSBlockOperation blockOperationWithBlock:^{
            [NSThread sleepForTimeInterval:self.delay];
        }];
        [op addDependency:delayOperation];
        [self.throttlingQueue addOperation:delayOperation];
    }

    NSInvocationOperation *updateOperation = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(updateRateLimit:) object:op];
    [updateOperation addDependency:op];
    [self.updateQueue addOperation:updateOperation];
    
    [super addOperation:op];    
}

- (NSTimeInterval)delay {
    if (self.operationCount == 0 || self.rateLimit < 1) {
        return 0;
    }
    
    if (self.rateLimit == 1) {
        return kDGRateLimitWindow;
    }
    
    return kDGRateLimitWindow / (self.rateLimit - 1);
}

- (void)updateRateLimit:(NSOperation *)operation {
    NSDictionary *headers = nil;
    
    if ([operation isKindOfClass:[RKObjectRequestOperation class]]) {
        headers = [(RKObjectRequestOperation *)operation HTTPRequestOperation].response.allHeaderFields;
    } else if ([operation isKindOfClass:[AFRKHTTPRequestOperation class]]) {
        headers = [(AFRKHTTPRequestOperation *)operation response].allHeaderFields;
    }
    
    if (headers[kDGRatelimit]) {
        self.rateLimit = [headers[kDGRatelimit] integerValue];
    }
    
    if (headers[kDGRatelimitRemaining]) {
        self.rateLimitRemaining = [headers[kDGRatelimitRemaining] integerValue];
    }
}

@end
