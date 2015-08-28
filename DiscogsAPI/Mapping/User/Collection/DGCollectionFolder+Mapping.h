//
//  DGCollectionFolder+Mapping.h
//  Pods
//
//  Created by Maxime Epain on 28/08/2015.
//
//

#import "DGCollectionFolder.h"
#import "DGPagination+Mapping.h"

@interface DGCollectionFolderRequest (Mapping)

- (NSDictionary*) parameters;

@end

@interface DGCreateCollectionFolderRequest (Mapping)

- (NSDictionary*) parameters;

@end

@interface DGCollectionFolder (Mapping)

+ (RKObjectMapping*) mapping;

+ (RKResponseDescriptor*) responseDescriptor;

+ (RKResponseDescriptor*) foldersResponseDescriptor;

@end

@interface DGCollectionFoldersRequest (Mapping)

+ (RKResponseDescriptor*) responseDescriptor;

- (NSDictionary*) parameters;

@end

@interface DGAddToCollectionFolderRequest (Mapping)

- (NSDictionary*) parameters;

@end

@interface DGAddToCollectionFolderResponse (Mapping)

+ (RKObjectMapping*) mapping;

+ (RKResponseDescriptor*) responseDescriptor;

@end

@interface DGCollectionReleasesRequest (Mapping)

- (NSDictionary*) parameters;

@end

@interface DGCollectionReleasesResponse (Mapping)

+ (RKObjectMapping*) mapping;

+ (RKResponseDescriptor*) responseDescriptor;

@end

