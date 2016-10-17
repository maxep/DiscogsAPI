// DGOrder.h
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
#import "DGPagination.h"

NS_ASSUME_NONNULL_BEGIN

/**
 Sort description of folder items.
 */
typedef NS_ENUM(NSInteger, DGSortOrders){
    /**
     Sort by ID.
     */
    DGSortOrdersID,
    /**
     Sort by Buyer.
     */
    DGSortOrdersBuyer,
    /**
     Sort by creation date.
     */
    DGSortOrdersCreationDate,
    /**
     Sort by status.
     */
    DGSortOrdersStation,
    /**
     Sort by activity date.
     */
    DGSortOrdersActivityDate
};

extern NSString * DGSortOrdersAsString(DGSortOrders sort);

@class DGPrice;
@class DGProfile;

@interface DGOrderItem : DGObject

@property (nonatomic, strong, nullable) NSNumber *releaseID;

@property (nonatomic, strong, nullable) NSString *releaseDescription;

@property (nonatomic, strong, nullable) DGPrice *fee;

@end

@interface DGOrder : DGObject

@property (nonatomic, strong, nullable) NSString *messagesURL;

@property (nonatomic, strong, nullable) NSString *status;

@property (nonatomic, strong, nullable) NSArray<NSString *> *nextStatus;

@property (nonatomic, strong, nullable) DGPrice *fee;

@property (nonatomic, strong, nullable) NSDate *created;

@property (nonatomic, strong, nullable) NSArray<DGOrderItem *> *items;

@property (nonatomic, strong, nullable) DGPrice *shipping;

@property (nonatomic, strong, nullable) NSString *shippingAddress;

@property (nonatomic, strong, nullable) NSString *additionalInstructions;

@property (nonatomic, strong, nullable) DGProfile *seller;

@property (nonatomic, strong, nullable) NSDate *lastActivity;

@property (nonatomic, strong, nullable) DGProfile *buyer;

@property (nonatomic, strong, nullable) DGPrice *total;

@end

@interface DGListOrdersRequest : NSObject

@property (nonatomic, strong) DGPagination *pagination;

@property (nonatomic, strong) NSString *status;

@property (nonatomic) DGSortOrders sort;

@property (nonatomic) DGSortOrder sortOrder;

@end

@interface DGListOrdersResponse : NSObject <DGPaginated>

@property (nonatomic, strong) NSArray<DGOrder *> *orders;

@end

NS_ASSUME_NONNULL_END
