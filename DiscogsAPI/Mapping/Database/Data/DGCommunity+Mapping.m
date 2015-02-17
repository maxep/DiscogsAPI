// DGCommunity+Mapping.m
//
// Copyright (c) 2015 Maxime Epain
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

#import "DGCommunity+Mapping.h"

@implementation DGContributor (Mapping)

+ (RKMapping *) mapping
{
    RKObjectMapping *mapping = [RKObjectMapping mappingForClass:[DGContributor class]];
    [mapping addAttributeMappingsFromDictionary:@{
                                                  @"resource_url"   : @"resourceURL",
                                                  @"username"       : @"userName"
                                                  }
     ];
    
    return mapping;
}

@end

@implementation DGRating (Mapping)

+ (RKMapping *) mapping
{
    RKObjectMapping *mapping = [RKObjectMapping mappingForClass:[DGRating class]];
    [mapping addAttributeMappingsFromDictionary:@{
                                                  @"average"   : @"average",
                                                  @"count"     : @"count"
                                                  }
     ];
    
    return mapping;
}

@end

@implementation DGCommunity (Mapping)

+ (RKMapping *) mapping
{
    RKObjectMapping *mapping = [RKObjectMapping mappingForClass:[DGCommunity class]];
    [mapping addAttributeMappingsFromDictionary:@{

                                                  @"data_quality"   : @"dataQuality",
                                                  @"have"           : @"have",
                                                  @"status"         : @"status",
                                                  @"want"           : @"want"
                                                  }
     ];
    
    [mapping addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"contributors" toKeyPath:@"contributors" withMapping:[DGContributor mapping]]];
    
    [mapping addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"rating" toKeyPath:@"rating" withMapping:[DGRating mapping]]];
    
    [mapping addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"submitter" toKeyPath:@"submitter" withMapping:[DGContributor mapping]]];
    
    return mapping;
}

@end
