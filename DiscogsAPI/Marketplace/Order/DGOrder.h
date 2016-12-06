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

/**
 Return order sort descriptor as string.

 @param sort The sort descriptor.
 @return A sort descriptor string.
 */
extern NSString * DGSortOrdersAsString(DGSortOrders sort);

@class DGPrice;
@class DGProfile;

/**
 Order item representation.
 */
@interface DGOrderItem : DGObject

/// The order release ID.
@property (nonatomic, strong, nullable) NSNumber *releaseID;

/// Ordered release description.
@property (nonatomic, strong, nullable) NSString *releaseDescription;

/// Order fee.
@property (nonatomic, strong, nullable) DGPrice *fee;

@end

/**
 An order representation.
 */
@interface DGOrder : DGObject

/// Order message URL.
@property (nonatomic, strong, nullable) NSString *messagesURL;

/// Order status.
@property (nonatomic, strong, nullable) NSString *status;

/// Order next status.
@property (nonatomic, strong, nullable) NSArray<NSString *> *nextStatus;

/// Order fee.
@property (nonatomic, strong, nullable) DGPrice *fee;

/// Order creation date.
@property (nonatomic, strong, nullable) NSDate *created;

/// Order items.
@property (nonatomic, strong, nullable) NSArray<DGOrderItem *> *items;

/// Order shipping price.
@property (nonatomic, strong, nullable) DGPrice *shipping;

/// Order shipping address.
@property (nonatomic, strong, nullable) NSString *shippingAddress;

/// Order additional instructions.
@property (nonatomic, strong, nullable) NSString *additionalInstructions;

/// Seller profile.
@property (nonatomic, strong, nullable) DGProfile *seller;

/// Last activity date.
@property (nonatomic, strong, nullable) NSDate *lastActivity;

/// Buyer profile.
@property (nonatomic, strong, nullable) DGProfile *buyer;

/// Order total price.
@property (nonatomic, strong, nullable) DGPrice *total;

@end

/**
 Orders list request.
 */
@interface DGListOrdersRequest : NSObject

/// Request pagination.
@property (nonatomic, strong) DGPagination *pagination;

/// Orders requested status.
@property (nonatomic, strong) NSString *status;

/// Request sort description.
@property (nonatomic) DGSortOrders sort;

/// Request sort order.
@property (nonatomic) DGSortOrder sortOrder;

@end

/**
 Orders list paginated response.
 */
@interface DGListOrdersResponse : NSObject <DGPaginated>

/// Orders list.
@property (nonatomic, strong) NSArray<DGOrder *> *orders;

@end

NS_ASSUME_NONNULL_END
