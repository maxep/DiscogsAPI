//
//  DGCollectionFolder+Mapping.m
//  Pods
//
//  Created by Maxime Epain on 28/08/2015.
//
//

#import "DGCollectionFolder+Mapping.h"
#import "DGReleaseInstance+Mapping.h"

@implementation DGCollectionFolderRequest (Mapping)

- (NSDictionary*) parameters {
    NSMutableDictionary* parameters = [NSMutableDictionary dictionary];
    if( self.name ) {
        [parameters setObject:self.name forKey:@"name"];
    }
    return parameters;
}

@end

@implementation DGCreateCollectionFolderRequest (Mapping)

- (NSDictionary*) parameters {
    NSMutableDictionary* parameters = [NSMutableDictionary dictionary];
    if( self.folderName ) {
        [parameters setObject:self.folderName forKey:@"name"];
    }
    return parameters;
}

@end


@implementation DGCollectionFolder (Mapping)

+ (RKObjectMapping*) mapping {
    RKObjectMapping *mapping = [RKObjectMapping mappingForClass:[DGCollectionFolder class]];
    [mapping addAttributeMappingsFromDictionary:@{
                                                  @"id"             : @"ID",
                                                  @"count"          : @"count",
                                                  @"name"           : @"name",
                                                  @"resource_url"   : @"resourceURL"
                                                  }];
    return mapping;
}

+ (RKResponseDescriptor*) foldersResponseDescriptor {
    return [RKResponseDescriptor responseDescriptorWithMapping:[DGCollectionFolder mapping] method:RKRequestMethodAny pathPattern:nil keyPath:@"folders" statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)];
}

+ (RKResponseDescriptor*) responseDescriptor {
    return [RKResponseDescriptor responseDescriptorWithMapping:[DGCollectionFolder mapping] method:RKRequestMethodAny pathPattern:nil keyPath:nil statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)];
}

@end

@implementation DGCollectionFoldersRequest (Mapping)

+ (RKResponseDescriptor*) responseDescriptor {
    RKObjectMapping *mapping = [RKObjectMapping mappingForClass:[DGCollectionFoldersRequest class]];
    
    [mapping addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"folders" toKeyPath:@"folders" withMapping:[DGCollectionFolder mapping]]];
    
    return [RKResponseDescriptor responseDescriptorWithMapping:mapping method:RKRequestMethodAny pathPattern:nil keyPath:nil statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)];
}

- (NSDictionary*) parameters {
    return nil; // @{ @"username" : self.userName };
}

@end

@implementation DGAddToCollectionFolderRequest (Mapping)

- (NSDictionary*) parameters {
    return nil;
}

@end

@implementation DGAddToCollectionFolderResponse (Mapping)

+ (RKObjectMapping*) mapping {
    RKObjectMapping *mapping = [RKObjectMapping mappingForClass:[DGAddToCollectionFolderResponse class]];
    
    [mapping addAttributeMappingsFromDictionary:@{
                                                  @"instance_id"    : @"ID",
                                                  @"resource_url"   : @"resourceURL"
                                                  }];
    
    return mapping;
}

+ (RKResponseDescriptor*) responseDescriptor {
    return [RKResponseDescriptor responseDescriptorWithMapping:[DGAddToCollectionFolderResponse mapping] method:RKRequestMethodAny pathPattern:nil keyPath:nil statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)];
}

@end

@implementation DGCollectionReleasesRequest (Mapping)

- (NSDictionary*) parameters {
    NSMutableDictionary* parameters = [NSMutableDictionary dictionaryWithDictionary:@{
                                                                                      @"sort"       : kDGSortKeyAsString(self.sort),
                                                                                      @"sort_order" : kDGSortOrderAsString(self.sortOrder)
                                                                                      }];
    
    [parameters addEntriesFromDictionary:[self.pagination parameters]];
    return parameters;
}

@end

@implementation DGCollectionReleasesResponse (Mapping)

+ (RKObjectMapping*) mapping {
    RKObjectMapping *mapping = [RKObjectMapping mappingForClass:[DGCollectionReleasesResponse class]];
    
    [mapping addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"pagination" toKeyPath:@"pagination" withMapping:[DGPagination mapping]]];
    
    [mapping addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"releases" toKeyPath:@"releases" withMapping:[DGReleaseInstance mapping]]];
    
    return mapping;
}

+ (RKResponseDescriptor*) responseDescriptor {
    return [RKResponseDescriptor responseDescriptorWithMapping:[DGCollectionReleasesResponse mapping] method:RKRequestMethodAny pathPattern:nil keyPath:nil statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)];
}

@end


