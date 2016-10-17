// Marketplace.h
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

#import "DGEndpoint.h"
#import "DGPrice.h"
#import "DGInventory.h"

NS_ASSUME_NONNULL_BEGIN

/**
 Represents discogs API marketplace endpoint.
 @see https://www.discogs.com/developers/#page:marketplace
 */
@interface DGMarketplace : DGEndpoint

/**
 Gets the list of listings in a user’s inventory. Accepts Pagination parameters.
 Basic information about each listing and the corresponding release is provided, suitable for display in a list. For detailed information about the release, make another API call to fetch the corresponding Release.
 
 If you are not authenticated as the inventory owner, only items that have a status of For Sale will be visible.
 If you are authenticated as the inventory owner you will get additional weight, format_quantity, external_id, and location keys.

 @param request The inventory request.
 @param success A block object to be executed when the search operation finishes successfully. This block has no return value and one argument: the inventory response.
 @param failure A block object to be executed when the synchronization operation finishes unsuccessfully. This block has no return value and takes one argument: The `NSError` object describing the error that occurred.
 */
- (void)getInventory:(DGInventoryRequest *)request success:(void (^)(DGInventoryResponse *response))success failure:(nullable DGFailureBlock)failure;

/**
 Gets the data associated with a listing.
 If the authorized user is the listing owner the listing will include the weight, format_quantity, external_id, and location keys.

 @param request The listing request.
 @param success A block object to be executed when the search operation finishes successfully. This block has no return value and one argument: the requested listing.
 @param failure A block object to be executed when the synchronization operation finishes unsuccessfully. This block has no return value and takes one argument: The `NSError` object describing the error that occurred.
 */
- (void)getListing:(DGListingRequest *)request success:(void (^)(DGListing *listing))success failure:(nullable DGFailureBlock)failure;

/**
 Edits the data associated with a listing.
 
 If the listing’s status is not For Sale, Draft, or Expired, it cannot be modified – only deleted. To re-list a Sold listing, a new listing must be created.
 
 Authentication as the listing owner is required.

 @param listing The listing to edit.
 @param success A block object to be executed when the search operation finishes successfully. This block has no return value and no argument.
 @param failure A block object to be executed when the synchronization operation finishes unsuccessfully. This block has no return value and takes one argument: The `NSError` object describing the error that occurred.
 */
- (void)editListing:(DGListing *)listing success:(void (^)())success failure:(nullable DGFailureBlock)failure;

/**
 Creates a Marketplace listing.
 Authentication is required; the listing will be added to the authenticated user’s Inventory.

 @param listing The listing to create.
 @param success A block object to be executed when the search operation finishes successfully. This block has no return value and one argument: the listing with ID and resource URL filled.
 @param failure A block object to be executed when the synchronization operation finishes unsuccessfully. This block has no return value and takes one argument: The `NSError` object describing the error that occurred.
 */
- (void)createListing:(DGListing *)listing success:(void (^)(DGListing *listing))success failure:(nullable DGFailureBlock)failure;

/**
 Permanently remove a listing from the Marketplace.
 Authentication as the listing owner is required.

 @param listing the listing to delete.
 @param success A block object to be executed when the search operation finishes successfully. This block has no return value and no argument.
 @param failure A block object to be executed when the synchronization operation finishes unsuccessfully. This block has no return value and takes one argument: The `NSError` object describing the error that occurred.
 */
- (void)deleteListing:(DGListing *)listing success:(void (^)())success failure:(nullable DGFailureBlock)failure;

/**
 Retrieves price suggestions for the provided Release ID. If no suggestions are available, an empty object will be returned.
 Authentication is required, and the user needs to have filled out their seller settings. Suggested prices will be denominated in the user’s selling currency.
 
 @param releaseID The release ID.
 @param success A block object to be executed when the search operation finishes successfully. This block has no return value and one argument: the price suggestion response.
 @param failure A block object to be executed when the synchronization operation finishes unsuccessfully. This block has no return value and takes one argument: The `NSError` object describing the error that occurred.
 */
- (void)getPriceSuggestions:(NSNumber *)releaseID success:(void (^)(DGPriceSuggestionsResponse *response))success failure:(nullable DGFailureBlock)failure;

@end

NS_ASSUME_NONNULL_END
