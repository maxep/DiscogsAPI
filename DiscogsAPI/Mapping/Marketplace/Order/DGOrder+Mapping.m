// DGOrder+Mapping.m
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

#import "DGOrder+Mapping.h"
#import "DGPrice+Mapping.h"
#import "DGProfile+Mapping.h"
#import "DGPagination+Mapping.h"

@implementation DGOrderItem (Mapping)

+ (RKMapping *)mapping {
    RKObjectMapping *mapping = [RKObjectMapping mappingForClass:[DGOrderItem class]];
    [mapping addAttributeMappingsFromDictionary:@{
                                                  @"id"                    : @"ID",
                                                  @"release.id"            : @"releaseID",
                                                  @"release.description"   : @"releaseDescription"
                                                  }];
    
    [mapping addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"price" toKeyPath:@"price" withMapping:[DGPrice mapping]]];
    return mapping;
}

@end

@implementation DGOrder (Mapping)

+ (RKMapping *)mapping {
    RKObjectMapping *mapping = [RKObjectMapping mappingForClass:[DGOrder class]];
    [mapping addAttributeMappingsFromDictionary:@{
                                                  @"id"             : @"ID",
                                                  @"uri"            : @"uri",
                                                  @"resource_url"   : @"resourceURL",
                                                  @"message_url"    : @"messageURL",
                                                  @"status"         : @"status",
                                                  @"next_status"    : @"nextStatus",
                                                  @"created"        : @"created",
                                                  @"shipping_address" : @"shippingAddress",
                                                  @"additional_instructions" : @"additionalInstructions",
                                                  @"last_activity"  : @"lastActivity"
                                                  }];
    
    [mapping addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"free" toKeyPath:@"fee" withMapping:[DGPrice mapping]]];
    [mapping addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"shipping" toKeyPath:@"shipping" withMapping:[DGPrice mapping]]];
    [mapping addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"items" toKeyPath:@"items" withMapping:[DGOrderItem mapping]]];
    [mapping addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"seller" toKeyPath:@"seller" withMapping:[DGProfile mapping]]];
    [mapping addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"buyer" toKeyPath:@"buyer" withMapping:[DGProfile mapping]]];
    [mapping addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"total" toKeyPath:@"total" withMapping:[DGPrice mapping]]];
    return mapping;
}

+ (RKResponseDescriptor *)responseDescriptor {
    return [RKResponseDescriptor responseDescriptorWithMapping:[DGOrder mapping] method:RKRequestMethodGET pathPattern:nil keyPath:nil statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)];
}

+ (RKRequestDescriptor *)requestDescriptor {
    RKObjectMapping *mapping = [RKObjectMapping requestMapping];
    mapping.assignsDefaultValueForMissingAttributes = NO;
    
    [mapping addAttributeMappingsFromDictionary:@{
                                                  @"ID"         : @"order_id",
                                                  @"status"     : @"status",
                                                  @"shipping"   : @"shipping.value"
                                                  }];
    
    return [RKRequestDescriptor requestDescriptorWithMapping:mapping objectClass:[DGOrder class] rootKeyPath:nil method:RKRequestMethodPOST];
}

@end

@implementation DGListOrdersRequest (Mapping)

- (NSDictionary *)parameters {
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    
    if( self.status ) {
        parameters[@"status"] = self.status;
    }
    parameters[@"sort"] = DGSortOrdersAsString(self.sort);
    parameters[@"sort_order"] = DGSortOrderAsString(self.sortOrder);
    
    [parameters addEntriesFromDictionary:self.pagination.parameters];
    
    return parameters;
}

@end

@implementation DGListOrdersResponse (Mapping)

+ (RKResponseDescriptor *)responseDescriptor {
    RKObjectMapping *mapping = [RKObjectMapping mappingForClass:[DGListOrdersResponse class]];
    
    [mapping addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"pagination" toKeyPath:@"pagination" withMapping:[DGPagination mapping]]];
    
    [mapping addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"orders" toKeyPath:@"orders" withMapping:[DGOrder mapping]]];
    
    return [RKResponseDescriptor responseDescriptorWithMapping:mapping method:RKRequestMethodAny pathPattern:nil keyPath:nil statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)];
}

@end
