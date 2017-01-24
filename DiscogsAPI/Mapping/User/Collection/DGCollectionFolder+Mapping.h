// DGCollectionFolder+Mapping.h
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

#import "DGCollectionFolder.h"
#import "DGPagination+Mapping.h"

@interface DGCollectionFolderRequest (Mapping) <DGRequestObject>

@end

@interface DGCreateCollectionFolderRequest (Mapping) <DGRequestObject>

@end

@interface DGCollectionFolder (Mapping) <DGObject, DGResponseObject>

@end

@interface DGCollectionFoldersRequest (Mapping) <DGRequestObject, DGResponseObject>

@end

@interface DGAddToCollectionFolderRequest (Mapping) <DGRequestObject>

@end

@interface DGAddToCollectionFolderResponse (Mapping) <DGResponseObject>

@end

@interface DGCollectionFolderItemsRequest (Mapping) <DGRequestObject>

@end

@interface DGCollectionReleaseItemsRequest (Mapping) <DGRequestObject>

@end

@interface DGCollectionItemsResponse (Mapping) <DGResponseObject>

@end
