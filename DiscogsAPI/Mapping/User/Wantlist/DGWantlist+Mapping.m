// DGWantlist+Mapping.m
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

#import "DGWantlist+Mapping.h"
#import "DGPagination+Mapping.h"
#import "DGRelease+Mapping.h"

@implementation DGWantlistRequest (Mapping)

- (NSDictionary *)parameters {
    return self.pagination.parameters;
}
    
@end

@implementation DGWantlistResponse (Mapping)

+ (RKMapping *)mapping {
    RKObjectMapping *mapping = [RKObjectMapping mappingForClass:[DGWantlistResponse class]];
    
    [mapping addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"pagination" toKeyPath:@"pagination" withMapping:[DGPagination mapping]]];
    
    [mapping addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"wants" toKeyPath:@"wants" withMapping:[DGWant mapping]]];
    
    return mapping;
}

+ (RKResponseDescriptor *)responseDescriptor {
    return [RKResponseDescriptor responseDescriptorWithMapping:[DGWantlistResponse mapping] method:RKRequestMethodAny pathPattern:nil keyPath:nil statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)];
}

@end

@implementation DGWantRequest (Mapping)

- (NSDictionary *)parameters {
    return @{ @"notes"  : self.notes,
              @"rating" : self.rating
            };
}

@end

@implementation DGWant (Mapping)

+ (RKMapping *)mapping {
    RKObjectMapping *mapping = [RKObjectMapping mappingForClass:[DGWant class]];
    [mapping addAttributeMappingsFromDictionary:@{
                                                  @"id"             : @"ID",
                                                  @"rating"         : @"rating",
                                                  @"notes"          : @"notes",
                                                  @"resource_url"   : @"resourceURL"
                                                  }];
    
    [mapping addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"basic_information" toKeyPath:@"DGRelease" withMapping:[DGRelease mapping]]];
    
    return mapping;
}

+ (RKResponseDescriptor *)responseDescriptor {
    return [RKResponseDescriptor responseDescriptorWithMapping:[DGWant mapping] method:RKRequestMethodAny pathPattern:nil keyPath:nil statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)];
}

@end
