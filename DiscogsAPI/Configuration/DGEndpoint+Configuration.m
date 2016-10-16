// DGEndpoint+Configuration.m
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

#import <objc/runtime.h>
#import "DGEndpoint+Configuration.h"

@implementation DGEndpoint (Configuration)

- (instancetype)initWithManager:(RKObjectManager *)manager {
    self = [super init];
    if (self) {
        objc_setAssociatedObject(self, @selector(manager), manager, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        [self configureManager:manager];
    }
    return self;
}

- (void)configureManager:(RKObjectManager *)objectManager {

}

- (NSError *)errorWithCode:(NSInteger)code info:(NSString *)info {
    return [NSError errorWithDomain:@"Discogs.api" code:code userInfo:@{ NSLocalizedDescriptionKey : info}];
}

#pragma mark Properties

- (RKObjectManager *)manager {
    return objc_getAssociatedObject(self, @selector(manager));
}

- (BOOL)isReachable {
    return self.manager.HTTPClient.networkReachabilityStatus != AFNetworkReachabilityStatusNotReachable;
}

@end

@implementation RKErrorMessage (Mapping)

+ (RKMapping *)mapping {
    RKObjectMapping *mapping = [RKObjectMapping mappingForClass:[RKErrorMessage class]];
    
    [mapping addPropertyMapping:[RKAttributeMapping attributeMappingFromKeyPath:@"message" toKeyPath:@"errorMessage"]];
    
    return mapping;
}

+ (RKResponseDescriptor *)responseDescriptor {
    RKObjectMapping *mapping = [RKObjectMapping mappingForClass:[RKErrorMessage class]];
    
    [mapping addPropertyMapping:[RKAttributeMapping attributeMappingFromKeyPath:@"message" toKeyPath:@"errorMessage"]];
    
    return [RKResponseDescriptor responseDescriptorWithMapping:mapping method:RKRequestMethodAny pathPattern:nil keyPath:nil statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)];
}

@end
