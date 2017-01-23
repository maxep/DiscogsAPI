// DGReleaseInstance+Mapping.m
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

#import "DGReleaseInstance+Mapping.h"

#import "DGRelease+Mapping.h"
#import "DGCollectionFieldInstance+Mapping.h"

@implementation DGReleaseInstance (Mapping)

+ (RKMapping *)mapping {
    RKObjectMapping *mapping = [RKObjectMapping mappingForClass:[DGReleaseInstance class]];
    [mapping addAttributeMappingsFromDictionary:@{
                                                  @"instance_id"    : @"id",
                                                  @"uri"            : @"uri",
                                                  @"resource_url"   : @"resourceURL",
                                                  @"rating"         : @"rating",
                                                  @"folder_id"      : @"folderID"
                                                  }];
    
    [mapping addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"basic_information" toKeyPath:@"basicInformation" withMapping:[DGRelease mapping]]];
    
    [mapping addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"notes" toKeyPath:@"notes" withMapping:[DGCollectionFieldInstance mapping]]];
    
    return mapping;
}

+ (RKResponseDescriptor *)responseDescriptor {
    return [RKResponseDescriptor responseDescriptorWithMapping:[DGReleaseInstance mapping] method:RKRequestMethodAny pathPattern:nil keyPath:nil statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)];
}

@end

@implementation DGReleaseInstanceRequest (Mapping)

- (NSDictionary*) parameters {
    return nil;
}

@end

@implementation DGEditFieldsInstanceRequest (Mapping)

+ (RKRequestDescriptor *)requestDescriptor {
    RKObjectMapping *mapping = [RKObjectMapping requestMapping];
    
    [mapping addAttributeMappingsFromDictionary:@{@"value" : @"value"}];
    
    return [RKRequestDescriptor requestDescriptorWithMapping:mapping objectClass:[DGEditFieldsInstanceRequest class] rootKeyPath:nil method:RKRequestMethodPOST];
}

- (NSDictionary *)parameters {
    return @{@"value" : self.value};
}

@end

@implementation DGChangeRatingOfReleaseRequest (Mapping)

- (NSDictionary *)parameters {
    if( self.rating ) {
        return @{ @"rating" : self.rating };
    }
    return nil;
}

@end
