// DGOperationQueue.h
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

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

FOUNDATION_EXTERN NSTimeInterval const kDGRateLimitWindow; // 60s

/**
 DGOperationQueue throttle operations to comply Discogs rate limit.
 Each request operation will update the queue rate limit and the number of remaining requests following responses headers.
 */
@interface DGOperationQueue : NSOperationQueue

/**
 The total number of operations the queue can make in a one minute window. 240 by default.
 */
@property (nonatomic, readonly) NSInteger rateLimit;

/**
 The number of remaining operation returned by the last request response.
 */
@property (nonatomic, readonly) NSInteger rateLimitRemaining;

/**
 Initializes a Discogs operation queue with a default rate limit.

 @param rateLimit The default rate limit.
 @return The initialized operation queue.
 */
- (instancetype)initWithRateLimit:(NSInteger)rateLimit NS_DESIGNATED_INITIALIZER;

@end

NS_ASSUME_NONNULL_END
