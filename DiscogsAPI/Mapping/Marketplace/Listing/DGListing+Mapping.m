// DGListing+Mapping.m
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

#import "DGListing+Mapping.h"
#import "DGPrice+Mapping.h"
#import "DGProfile+Mapping.h"
#import "DGRelease+Mapping.h"

@implementation DGListing (Mapping)

+ (RKMapping *)mapping {
    RKObjectMapping *mapping = [RKObjectMapping mappingForClass:[DGListing class]];
    [mapping addAttributeMappingsFromDictionary:@{
                                                  @"id"             : @"ID",
                                                  @"uri"            : @"uri",
                                                  @"resource_url"   : @"resourceURL",
                                                  @"status"         : @"status",
                                                  @"allow_offers"   : @"allowOffers",
                                                  @"condition"      : @"condition",
                                                  @"posted"         : @"posted",
                                                  @"ships_from"     : @"shipsFrom",
                                                  @"comments"       : @"comments",
                                                  @"audio"          : @"audio",
                                                  @"external_id"    : @"externalID",
                                                  @"location"       : @"location",
                                                  @"weight"         : @"weight",
                                                  @"format_quantity": @"formatQuantity",
                                                  @"sleeve_condition": @"sleeveCondition",
                                                  }];
    
    [mapping addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"price" toKeyPath:@"price" withMapping:[DGPrice mapping]]];
    [mapping addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"seller" toKeyPath:@"seller" withMapping:[DGProfile mapping]]];
    [mapping addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"release" toKeyPath:@"dgRelease" withMapping:[DGRelease mapping]]];
    return mapping;
}

+ (RKResponseDescriptor *)responseDescriptor {
    return [RKResponseDescriptor responseDescriptorWithMapping:[DGListing mapping] method:RKRequestMethodGET pathPattern:nil keyPath:nil statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)];
}

+ (RKRequestDescriptor *)requestDescriptor {
    RKObjectMapping *mapping = [RKObjectMapping requestMapping];
    mapping.assignsDefaultValueForMissingAttributes = NO;
    
    [mapping addAttributeMappingsFromDictionary:@{
                                                  @"release.ID"     : @"release_id",
                                                  @"status"         : @"status",
                                                  @"allowOffers"    : @"allow_offers",
                                                  @"condition"      : @"condition",
                                                  @"sleeveCondition": @"sleeve_condition",
                                                  @"comments"       : @"comments",
                                                  @"externalID"     : @"external_id",
                                                  @"location"       : @"location",
                                                  @"weight"         : @"weight",
                                                  @"formatQuantity" : @"format_quantity",
                                                  @"price.value"    : @"price"
                                                  }];
    
    return [RKRequestDescriptor requestDescriptorWithMapping:mapping objectClass:[DGListing class] rootKeyPath:nil method:RKRequestMethodPOST];
}

@end

@implementation DGListingRequest (Mapping)

- (NSDictionary *)parameters {
    if (self.currency != DGCurrencyNone) {
        return @{@"curr_abbr" : DGCurrencyAsString(self.currency)};
    }
    return nil;
}

@end


@implementation DGCreateListingRequest (Mapping)

+ (RKRequestDescriptor *)requestDescriptor {
    RKObjectMapping *mapping = [RKObjectMapping requestMapping];
    mapping.assignsDefaultValueForMissingAttributes = NO;
    
    [mapping addAttributeMappingsFromDictionary:@{
                                                  @"listing.release.ID"     : @"release_id",
                                                  @"listing.status"         : @"status",
                                                  @"listing.allowOffers"    : @"allow_offers",
                                                  @"listing.condition"      : @"condition",
                                                  @"listing.sleeveCondition": @"sleeve_condition",
                                                  @"listing.comments"       : @"comments",
                                                  @"listing.externalID"     : @"external_id",
                                                  @"listing.location"       : @"location",
                                                  @"listing.weight"         : @"weight",
                                                  @"listing.formatQuantity" : @"format_quantity",
                                                  @"listing.price.value"    : @"price"
                                                  }];
    
    return [RKRequestDescriptor requestDescriptorWithMapping:mapping objectClass:[DGCreateListingRequest class] rootKeyPath:nil method:RKRequestMethodPOST];
}

@end

@implementation DGCreateListingResponse (Mapping)

+ (RKMapping *)mapping {
    RKObjectMapping *mapping = [RKObjectMapping mappingForClass:[DGCreateListingResponse class]];
    [mapping addAttributeMappingsFromDictionary:@{
                                                  @"listing_id"     : @"listingID",
                                                  @"resource_url"   : @"resourceURL"
                                                  }];
    return mapping;
}

+ (RKResponseDescriptor *)responseDescriptor {
    return [RKResponseDescriptor responseDescriptorWithMapping:[DGCreateListingResponse mapping] method:RKRequestMethodAny pathPattern:nil keyPath:nil statusCodes:RKStatusCodeIndexSetForClass(201)];
}

@end
