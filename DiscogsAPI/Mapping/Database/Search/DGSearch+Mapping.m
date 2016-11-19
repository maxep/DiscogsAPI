// DGSearch+Mapping.m
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

#import "DGSearch+Mapping.h"

@implementation DGSearchRequest (Mapping)

+ (RKRequestDescriptor *)requestDescriptor {
    RKObjectMapping *mapping = [RKObjectMapping requestMapping];
    mapping.assignsDefaultValueForMissingAttributes = NO;
    [mapping addAttributeMappingsFromDictionary:@{
                                                  @"query"          : @"q",
                                                  @"type"           : @"type",
                                                  @"title"          : @"title",
                                                  @"releaseTitle"   : @"release_title",
                                                  @"credit"         : @"credit",
                                                  @"artist"         : @"artist",
                                                  @"anv"            : @"anv",
                                                  @"label"          : @"label",
                                                  @"genre"          : @"genre",
                                                  @"style"          : @"style",
                                                  @"country"        : @"country",
                                                  @"year"           : @"year",
                                                  @"format"         : @"format",
                                                  @"catno"          : @"catno",
                                                  @"barcode"        : @"barcode",
                                                  @"track"          : @"track",
                                                  @"submitter"      : @"submitter",
                                                  @"contributor"    : @"contributor",
                                                  @"pagination.page": @"page",
                                                  @"pagination.perPage" :@"per_page"
                                                  }
     ];
    
    return [RKRequestDescriptor requestDescriptorWithMapping:mapping objectClass:[DGSearchRequest class] rootKeyPath:@"search" method:RKRequestMethodGET];
}

- (NSDictionary *)parameters {
    NSMutableDictionary* parameters = [NSMutableDictionary dictionary];
    
    if( self.query ) {
        [parameters setObject:self.query forKey:@"q"];
    }
    if( self.type ) {
        [parameters setObject:self.type forKey:@"type"];
    }
    if( self.title ) {
        [parameters setObject:self.title forKey:@"title"];
    }
    if( self.releaseTitle ) {
        [parameters setObject:self.releaseTitle forKey:@"release_title"];
    }
    if( self.credit ) {
        [parameters setObject:self.credit forKey:@"credit"];
    }
    if( self.artist ) {
        [parameters setObject:self.artist forKey:@"artist"];
    }
    if( self.anv ) {
        [parameters setObject:self.anv forKey:@"anv"];
    }
    if( self.label ) {
        [parameters setObject:self.label forKey:@"label"];
    }
    if( self.genre ) {
        [parameters setObject:self.genre forKey:@"genre"];
    }
    if( self.style ) {
        [parameters setObject:self.style forKey:@"style"];
    }
    if( self.country ) {
        [parameters setObject:self.country forKey:@"country"];
    }
    if( self.year ) {
        [parameters setObject:self.year forKey:@"year"];
    }
    if( self.format ) {
        [parameters setObject:self.format forKey:@"format"];
    }
    if( self.catno ) {
        [parameters setObject:self.catno forKey:@"catno"];
    }
    if( self.barcode ) {
        [parameters setObject:self.barcode forKey:@"barcode"];
    }
    if( self.track ) {
        [parameters setObject:self.track forKey:@"track"];
    }
    if( self.submitter ) {
        [parameters setObject:self.submitter forKey:@"submitter"];
    }
    if( self.contributor ) {
        [parameters setObject:self.contributor forKey:@"contributor"];
    }
    
    [parameters addEntriesFromDictionary:self.pagination.parameters];
    
    return parameters;
}

@end

@implementation DGSearchResult (Mapping)

+ (RKMapping *)mapping {
    RKObjectMapping *mapping = [RKObjectMapping mappingForClass:[DGSearchResult class]];
    [mapping addAttributeMappingsFromDictionary:@{
                                                  @"style"          : @"style",
                                                  @"thumb"          : @"thumb",
                                                  @"title"          : @"title",
                                                  @"country"        : @"country",
                                                  @"format"         : @"format",
                                                  @"uri"            : @"uri",
                                                  @"label"          : @"label",
                                                  @"catno"          : @"catno",
                                                  @"year"           : @"year",
                                                  @"genre"          : @"genre",
                                                  @"resource_url"   : @"resourceURL",
                                                  @"type"           : @"type",
                                                  @"id"             : @"ID"
                                                  }
     ];
    
    return mapping;
}

@end

@implementation DGSearchResponse (Mapping)

+ (RKResponseDescriptor *)responseDescriptor {
    RKObjectMapping *mapping = [RKObjectMapping mappingForClass:[DGSearchResponse class]];
    
    [mapping addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"pagination" toKeyPath:@"pagination" withMapping:[DGPagination mapping]]];
    
    [mapping addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"results" toKeyPath:@"results" withMapping:[DGSearchResult mapping]]];
    
    return [RKResponseDescriptor responseDescriptorWithMapping:mapping method:RKRequestMethodAny pathPattern:nil keyPath:nil statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)];
}

@end
