// DGMaster+Mapping.m
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

#import "DGMaster+Mapping.h"
#import "DGArtist+Mapping.h"
#import "DGImage+Mapping.h"
#import "DGTrack+Mapping.h"

@implementation DGMaster (Mapping)

+ (RKMapping *)mapping {
    
    RKObjectMapping *mapping = [RKObjectMapping mappingForClass:[DGMaster class]];
    
    [mapping addAttributeMappingsFromDictionary:@{
                                                  @"title"              : @"title",
                                                  @"id"                 : @"ID",
                                                  @"data_quality"       : @"dataQuality",
                                                  @"thumb"              : @"thumb",
                                                  @"year"               : @"year",
                                                  @"genres"             : @"genres",
                                                  @"styles"             : @"styles",
                                                  @"main_release"       : @"mainReleaseID",
                                                  @"uri"                : @"uri"
                                                  }
     ];
    
    [mapping addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"artists" toKeyPath:@"artists" withMapping:[DGArtist mapping]]];
    
    [mapping addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"images" toKeyPath:@"images" withMapping:[DGImage mapping]]];
    
    [mapping addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"tracklist" toKeyPath:@"trackList" withMapping:[DGTrack mapping]]];
    
    return mapping;
}

+ (RKResponseDescriptor *)responseDescriptor {
    return [RKResponseDescriptor responseDescriptorWithMapping:[DGMaster mapping] method:RKRequestMethodAny pathPattern:nil keyPath:nil statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)];
}

@end
