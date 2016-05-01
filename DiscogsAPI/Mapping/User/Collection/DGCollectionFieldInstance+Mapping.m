//
//  DGCollectionFieldInstance+Mapping.m
//  Pods
//
//  Created by Nate Rivard on 5/1/16.
//
//

#import "DGCollectionFieldInstance+Mapping.h"

@implementation DGCollectionFieldInstance (Mapping)

+ (RKObjectMapping *)mapping {
    RKObjectMapping *mapping = [RKObjectMapping mappingForClass:[DGCollectionFieldInstance class]];
    [mapping addAttributeMappingsFromDictionary:@{
                                                  @"field_id" : @"fieldID",
                                                  @"value" : @"value",
                                                  }];
    return mapping;
}

@end
