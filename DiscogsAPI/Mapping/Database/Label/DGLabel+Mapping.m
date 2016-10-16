// DGLabel+Mapping.m
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

#import "DGLabel+Mapping.h"
#import "DGImage+Mapping.h"

@implementation DGLabel (Mapping)

+ (RKMapping *)mapping {
    
    RKObjectMapping *mapping = [RKObjectMapping mappingForClass:[DGLabel class]];
    
    [mapping addAttributeMappingsFromDictionary:@{
                                                  @"profile"        : @"profile",
                                                  @"releases_url"   : @"releasesURL",
                                                  @"name"           : @"name",
                                                  @"contact_info"   : @"contactInfo",
                                                  @"uri"            : @"uri",
                                                  @"urls"           : @"urls",
                                                  @"resource_url"   : @"resourceURL",
                                                  @"id"             : @"ID",
                                                  @"data_quality"   : @"dataQuality"
                                                  }];
    
    RKObjectMapping *subMapping = [RKObjectMapping mappingForClass:[DGLabel class]];
    
    [subMapping addAttributeMappingsFromDictionary:@{
                                                  @"name"           : @"name",
                                                  @"resource_url"   : @"resourceURL",
                                                  @"id"             : @"ID",
                                                  }];
    
    [mapping addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"images" toKeyPath:@"images" withMapping:[DGImage mapping]]];
    
    [mapping addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"sublabels" toKeyPath:@"subLabels" withMapping:subMapping]];
    
    return mapping;
}

+ (RKResponseDescriptor *)responseDescriptor {
    return [RKResponseDescriptor responseDescriptorWithMapping:[DGLabel mapping] method:RKRequestMethodAny pathPattern:nil keyPath:nil statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)];
}

@end
