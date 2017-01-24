// DGMapping.h
//
// Copyright (c) 2017 Maxime Epain
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

#import <Foundation/Foundation.h>

/**
 Protocol adopted by objects mapped with Discogs objects.
 */
@protocol DGObject <NSObject>

/**
 Class method defining the object mapping.

 @return The object mapping.
 */
+ (RKMapping *)mapping;

@end

/**
 Protocol adotped by request object.
 */
@protocol DGRequestObject <NSObject>

@optional

/**
 The request dynamic parameters.
 */
@property (nonatomic, readonly) NSDictionary *parameters;

/**
 Class method defining the request object description for POST and PUT http method.

 @return The request description.
 */
+ (RKRequestDescriptor *)requestDescriptor;

@end

/**
 Protocol adotped by response object.
 */
@protocol DGResponseObject <NSObject>

/**
 Class method defining the response object description.
 
 @return The response description.
 */
+ (RKResponseDescriptor *)responseDescriptor;

@end
