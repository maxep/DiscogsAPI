// DGRelease+Mapping.m
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

#import "DGRelease+Mapping.h"
#import "DGPagination+Mapping.h"
#import "DGArtist+Mapping.h"
#import "DGCommunity+Mapping.h"
#import "DGFormat+Mapping.h"
#import "DGIdentifier+Mapping.h"
#import "DGImage+Mapping.h"
#import "DGVideo+Mapping.h"
#import "DGTrack+Mapping.h"

@implementation DGRelease (Mapping)

+ (RKMapping *)mapping {
    
    RKObjectMapping *mapping = [RKObjectMapping mappingForClass:[DGRelease class]];
    
    [mapping addAttributeMappingsFromDictionary:@{
                                                  @"title"              : @"title",
                                                  @"id"                 : @"ID",
                                                  @"data_quality"       : @"dataQuality",
                                                  @"thumb"              : @"thumb",
                                                  @"country"            : @"country",
                                                  @"date_added"         : @"dateAdded",
                                                  @"date_changed"       : @"dateChanged",
                                                  @"estimated_weight"   : @"estimatedWeight",
                                                  @"format_quantity"    : @"formatQuantity",
                                                  @"year"               : @"year",
                                                  @"notes"              : @"notes",
                                                  @"styles"             : @"styles",
                                                  @"genres"             : @"genres",
                                                  @"resource_url"       : @"resourceURL",
                                                  @"uri"                : @"uri",
                                                  @"master_id"          : @"masterID",
                                                  @"master_url"         : @"masterURL",
                                                  }
     ];
    
    [mapping addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"artists" toKeyPath:@"artists" withMapping:[DGArtist mapping]]];
    
    [mapping addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"extraartists" toKeyPath:@"extraArtists" withMapping:[DGArtist mapping]]];
    
    [mapping addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"community" toKeyPath:@"community" withMapping:[DGCommunity mapping]]];
    
    [mapping addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"images" toKeyPath:@"images" withMapping:[DGImage mapping]]];
    
    [mapping addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"videos" toKeyPath:@"videos" withMapping:[DGVideo mapping]]];
    
    [mapping addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"tracklist" toKeyPath:@"trackList" withMapping:[DGTrack mapping]]];
    
    [mapping addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"identifiers" toKeyPath:@"identifiers" withMapping:[DGIdentifier mapping]]];
    
    [mapping addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"formats" toKeyPath:@"formats" withMapping:[DGFormat mapping]]];
    
    return mapping;
}

+ (RKResponseDescriptor *)responseDescriptor {
    return [RKResponseDescriptor responseDescriptorWithMapping:[DGRelease mapping] method:RKRequestMethodAny pathPattern:nil keyPath:nil statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)];
}

@end
