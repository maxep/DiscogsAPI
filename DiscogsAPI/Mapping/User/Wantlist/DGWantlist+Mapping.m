// DGWantlist+Mapping.m
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

#import "DGWantlist+Mapping.h"
#import "DGReleaseInstance+Mapping.h"

@implementation DGWantlist (Mapping)

@end

@implementation DGWantlistRequest (Mapping)

- (NSDictionary*) parameters
{
    return [self.pagination parameters];
}
    
@end

@implementation DGWantlistResponse (Mapping)

+ (RKObjectMapping*) mapping
{
    RKObjectMapping *mapping = [RKObjectMapping mappingForClass:[DGWantlistResponse class]];
    
    [mapping addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"pagination" toKeyPath:@"pagination" withMapping:[DGPagination mapping]]];
    
    [mapping addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"wants" toKeyPath:@"releases" withMapping:[DGReleaseInstance mapping]]];
    
    return mapping;
}

+ (RKResponseDescriptor*) responseDescriptor
{
    return [RKResponseDescriptor responseDescriptorWithMapping:[DGWantlistResponse mapping] method:RKRequestMethodAny pathPattern:nil keyPath:nil statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)];
}

@end

@implementation DGPutInWantlistRequest (Mapping)

- (NSDictionary*) parameters
{
    NSMutableDictionary* parameters = [NSMutableDictionary dictionaryWithDictionary:@{
                                                                                      @"notes"      : self.notes,
                                                                                      @"rating"     : self.rating
                                                                                      }
                                       ];
    
    
    return parameters;
}

@end
