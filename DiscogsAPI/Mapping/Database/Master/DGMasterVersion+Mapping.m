// DGMasterVersion+Mapping.m
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

#import "DGMasterVersion+Mapping.h"
#import "DGPagination+Mapping.h"

@implementation DGMasterVersion (Mapping)

+ (RKMapping *)mapping {
    RKObjectMapping *mapping = [RKObjectMapping mappingForClass:[DGMasterVersion class]];
    [mapping addAttributeMappingsFromDictionary:@{
                                                  @"status"         : @"status",
                                                  @"thumb"          : @"thumb",
                                                  @"title"          : @"title",
                                                  @"format"         : @"format",
                                                  @"label"          : @"label",
                                                  @"country"        : @"country",
                                                  @"released"       : @"released",
                                                  @"catno"          : @"catno",
                                                  @"resource_url"   : @"resourceURL",
                                                  @"id"             : @"ID"
                                                  }
     ];
    
    return mapping;
}

@end

@implementation DGMasterVersionRequest (Mapping)

- (NSDictionary *)parameters {
    return self.pagination.parameters;
}

@end

@implementation DGMasterVersionResponse (Mapping)

+ (RKResponseDescriptor *)responseDescriptor {
    RKObjectMapping *mapping = [RKObjectMapping mappingForClass:[DGMasterVersionResponse class]];
    
    [mapping addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"pagination" toKeyPath:@"pagination" withMapping:[DGPagination mapping]]];
    
    [mapping addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"versions" toKeyPath:@"versions" withMapping:[DGMasterVersion mapping]]];
    
    return [RKResponseDescriptor responseDescriptorWithMapping:mapping method:RKRequestMethodAny pathPattern:nil keyPath:nil statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)];
}

@end
