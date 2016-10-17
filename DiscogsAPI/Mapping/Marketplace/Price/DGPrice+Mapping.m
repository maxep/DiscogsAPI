// DGPrice+Mapping.m
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

#import "DGPrice+Mapping.h"

@implementation DGPrice (Mapping)

+ (RKMapping *)mapping {
    
    RKObjectMapping *mapping = [RKObjectMapping mappingForClass:[DGPrice class]];
    [mapping addAttributeMappingsFromDictionary:@{
                                                  @"currency"   : @"currency",
                                                  @"value"      : @"value"
                                                  }];
    return mapping;
}

@end

@implementation DGPriceSuggestionsResponse (Mapping)

+ (RKMapping *)mapping {
    
    RKObjectMapping *mapping = [RKObjectMapping mappingForClass:[DGPriceSuggestionsResponse class]];
    
    [mapping addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"Mint (M)" toKeyPath:@"mint" withMapping:[DGPrice mapping]]];
    
    [mapping addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"Near Mint (NM or M-)" toKeyPath:@"nearMint" withMapping:[DGPrice mapping]]];
    
    [mapping addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"Very Good Plus (VG+)" toKeyPath:@"veryGoodPlus" withMapping:[DGPrice mapping]]];
    
    [mapping addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"Very Good (VG)" toKeyPath:@"veryGood" withMapping:[DGPrice mapping]]];
    
    [mapping addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"Good Plus (G+)" toKeyPath:@"goodPlus" withMapping:[DGPrice mapping]]];
    
    [mapping addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"Good (G)" toKeyPath:@"good" withMapping:[DGPrice mapping]]];
    
    [mapping addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"Fair (F)" toKeyPath:@"fair" withMapping:[DGPrice mapping]]];
    
    [mapping addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"Poor (P)" toKeyPath:@"poor" withMapping:[DGPrice mapping]]];
    
    return mapping;
}

+ (RKResponseDescriptor *)responseDescriptor {
    return [RKResponseDescriptor responseDescriptorWithMapping:[DGPriceSuggestionsResponse mapping] method:RKRequestMethodAny pathPattern:nil keyPath:nil statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)];
}

@end
