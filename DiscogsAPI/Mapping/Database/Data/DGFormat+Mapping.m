//
//  DGFormat+Mapping.m
//  Pods
//
//  Created by Nate Rivard on 4/28/16.
//
//

#import "DGFormat+Mapping.h"

@implementation DGFormat (Mapping)

+ (RKMapping *)mapping {
    RKObjectMapping *mapping = [RKObjectMapping mappingForClass:[DGFormat class]];
    [mapping addAttributeMappingsFromDictionary:@{ @"name" : @"name",
                                                   @"qty" : @"quantity",
                                                   @"text" : @"text",
                                                   @"descriptions" : @"descriptions", }];
    
    return mapping;
}

@end
