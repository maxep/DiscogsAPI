// DGProfile+Mapping.m
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

#import "DGProfile+Mapping.h"

@implementation DGProfile (Mapping)

+ (RKMapping *)mapping {
    RKObjectMapping *mapping = [RKObjectMapping mappingForClass:[DGProfile class]];
    [mapping addAttributeMappingsFromDictionary:@{
                                                  @"profile"                : @"profile",
                                                  @"wantlist_url"           : @"wantlistURL",
                                                  @"rank"                   : @"rank",
                                                  @"num_pending"            : @"numPending",
                                                  @"id"                     : @"ID",
                                                  @"num_for_sale"           : @"numForSale",
                                                  @"home_page"              : @"homePage",
                                                  @"location"               : @"location",
                                                  @"collection_folders_url" : @"collectionFoldersURL",
                                                  @"username"               : @"userName",
                                                  @"collection_fields_url"  : @"collectionFieldsURL",
                                                  @"releases_contributed"   : @"releasesContributed",
                                                  @"registered"             : @"registered",
                                                  @"rating_avg"             : @"ratingAvg",
                                                  @"num_collection"         : @"numCollection",
                                                  @"releases_rated"         : @"releasesRated",
                                                  @"num_lists"              : @"numLists",
                                                  @"name"                   : @"name",
                                                  @"num_wantlist"           : @"numWantlist",
                                                  @"inventory_url"          : @"inventoryURL",
                                                  @"avatar_url"             : @"avatarURL",
                                                  @"uri"                    : @"uri",
                                                  @"resource_url"           : @"resourceURL",
                                                  @"email"                  : @"email"
                                                  }
     ];
    return mapping;
}

+ (RKResponseDescriptor *)responseDescriptor {
    return [RKResponseDescriptor responseDescriptorWithMapping:[DGProfile mapping] method:RKRequestMethodAny pathPattern:nil keyPath:nil statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)];
}

- (NSDictionary *)parameters {
    NSMutableDictionary* parameters = [NSMutableDictionary dictionary];
    
    if( self.name ) {
        [parameters setObject:self.name forKey:@"name"];
    }
    if( self.homePage ) {
        [parameters setObject:self.homePage forKey:@"home_page"];
    }
    if( self.location ) {
        [parameters setObject:self.location forKey:@"location"];
    }
    if( self.profile ) {
        [parameters setObject:self.profile forKey:@"profile"];
    }
    
    return parameters;
}

@end
