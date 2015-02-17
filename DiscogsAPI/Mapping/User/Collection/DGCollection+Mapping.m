// DGCollection+Mapping.m
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

#import "DGCollection+Mapping.h"
#import "DGReleaseInstance+Mapping.h"

@implementation DGCollectionFolder (Mapping)

+ (RKObjectMapping*) mapping
{
    RKObjectMapping *mapping = [RKObjectMapping mappingForClass:[DGCollectionFolder class]];
    [mapping addAttributeMappingsFromDictionary:@{
                                                  @"id"             : @"folderID",
                                                  @"count"          : @"count",
                                                  @"name"           : @"name",
                                                  @"resource_url"   : @"resourceURL"
                                                  }
     ];
    return mapping;
}

+ (RKResponseDescriptor*) responseDescriptor
{
    return [RKResponseDescriptor responseDescriptorWithMapping:[DGCollectionFolder mapping] method:RKRequestMethodAny pathPattern:nil keyPath:nil statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)];
}

@end

@implementation DGCollectionFolders (Mapping)

+ (RKResponseDescriptor*) responseDescriptor
{
    RKObjectMapping *mapping = [RKObjectMapping mappingForClass:[DGCollectionFolders class]];
    
    [mapping addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"folders" toKeyPath:@"folders" withMapping:[DGCollectionFolder mapping]]];
    
    return [RKResponseDescriptor responseDescriptorWithMapping:mapping method:RKRequestMethodAny pathPattern:nil keyPath:nil statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)];
}

- (NSDictionary*) parameters
{
    return @{ @"username" : self.userName };
}

@end

@implementation DGPutReleaseInFolderRequest (Mapping)

- (NSDictionary*) parameters
{
    return nil;
}

@end

@implementation DGPutReleaseInFolderResponse (Mapping)

+ (RKObjectMapping*) mapping
{
    RKObjectMapping *mapping = [RKObjectMapping mappingForClass:[DGPutReleaseInFolderResponse class]];
    
    [mapping addAttributeMappingsFromDictionary:@{
                                                  @"instance_id"    : @"instanceID",
                                                  @"resource_url"   : @"resourceURL"
                                                  }
     ];
    
    return mapping;
}

+ (RKResponseDescriptor*) responseDescriptor
{
    return [RKResponseDescriptor responseDescriptorWithMapping:[DGPutReleaseInFolderResponse mapping] method:RKRequestMethodAny pathPattern:nil keyPath:nil statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)];
}

@end

@implementation DGCollectionReleasesRequest (Mapping)

- (NSDictionary*) parameters
{
    NSMutableDictionary* parameters = [NSMutableDictionary dictionaryWithDictionary:@{
                                                                                      @"sort"       : kDGSortKeyAsString(self.sort),
                                                                                      @"sort_order" : kDGSortOrderAsString(self.sortOrder)
                                                                                      }
                                       ];
    
    [parameters addEntriesFromDictionary:[self.pagination parameters]];
    
    return parameters;
}

@end

@implementation DGCollectionReleasesResponse (Mapping)

+ (RKObjectMapping*) mapping
{
    RKObjectMapping *mapping = [RKObjectMapping mappingForClass:[DGCollectionReleasesResponse class]];
    
    [mapping addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"pagination" toKeyPath:@"pagination" withMapping:[DGPagination mapping]]];
    
    [mapping addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"releases" toKeyPath:@"releases" withMapping:[DGReleaseInstance mapping]]];
    
    return mapping;
}

+ (RKResponseDescriptor*) responseDescriptor
{
    return [RKResponseDescriptor responseDescriptorWithMapping:[DGCollectionReleasesResponse mapping] method:RKRequestMethodAny pathPattern:nil keyPath:nil statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)];
}

@end
