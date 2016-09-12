// DGCompany.h
//
// Copyright (c) 2016 Nate Rivard
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

#import "DGObject.h"

#import "DGCompany+DiscogsAPI.h"

NS_ASSUME_NONNULL_BEGIN

/** Sample JSON
     {
         catno = "86777-1";
         "entity_type" = 1;
         "entity_type_name" = Label;
         id = 1873;
         name = "Anti-";
         "resource_url" = "https://api.discogs.com/labels/1873";
     }
 */

/**
 Represents Labels and Companies (aka Entities) on a release
 */
@interface DGCompany : DGObject

/**
 entity type. "Label" is 1. Use this in conjunction with entityTypeName to determine what entity type this is
 */
@property (nonatomic, strong, nullable) NSNumber *entityType;

/** 
 Entity type name. 1 is "Label". Use this in conjunction with entityType to determine what entity type this is.
 */
@property (nonatomic, strong, nullable) NSString *entityTypeName;

/**
 Name of this company/entity
 */
@property (nonatomic, strong, nullable) NSString *name;

/**
 Catalog number per entity for a release. can be empty if this entity isn't an actual label (ie, Copyright, Phonograph Copyright, etc.)
 */
@property (nonatomic, strong, nullable) NSString *catno;

/**
 use to create a new DGCompany object
 */
+ (instancetype)company;

@end

NS_ASSUME_NONNULL_END
