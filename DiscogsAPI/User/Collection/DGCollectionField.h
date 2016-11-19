// DGCollectionField.h
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

#import "DGObject.h"
#import "DGCollectionFieldInstance.h"

NS_ASSUME_NONNULL_BEGIN

/**
 User's collection fields request.
 */
@interface DGCollectionFieldsRequest : NSObject

/**
 The request user name.
 */
@property (nonatomic, strong, nullable) NSString *userName;

@end

/**
 A collection field.
 */
@interface DGCollectionField : DGObject

/**
 Field name.
 */
@property (nonatomic, strong, nullable) NSString  *name;

/**
 Field number of line.
 */
@property (nonatomic, strong, nullable) NSNumber  *lines;

/**
 Field type.
 */
@property (nonatomic, strong, nullable) NSString  *type;

/**
 Field position.
 */
@property (nonatomic, strong, nullable) NSNumber  *position;

/**
 Field options.
 */
@property (nonatomic, strong) NSArray<NSString *> *options;

/**
 Is Field public.
 */
@property (nonatomic) BOOL isPublic;

@end

NS_ASSUME_NONNULL_END
