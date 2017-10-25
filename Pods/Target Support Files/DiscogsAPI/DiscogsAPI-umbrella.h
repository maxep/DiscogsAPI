#ifdef __OBJC__
#import <UIKit/UIKit.h>
#else
#ifndef FOUNDATION_EXPORT
#if defined(__cplusplus)
#define FOUNDATION_EXPORT extern "C"
#else
#define FOUNDATION_EXPORT extern
#endif
#endif
#endif

#import "DiscogsAPI.h"
#import "DGAuthentication.h"
#import "DGIdentity.h"
#import "DGEndpoint.h"
#import "DGObject.h"
#import "DGDatabase.h"
#import "DGRelease.h"
#import "DGArtist.h"
#import "DGArtistRelease.h"
#import "DGMember.h"
#import "DGCompany.h"
#import "DGLabel.h"
#import "DGLabelRelease.h"
#import "DGMaster.h"
#import "DGMasterVersion.h"
#import "DGSearch.h"
#import "DGCommunity.h"
#import "DGFormat.h"
#import "DGIdentifier.h"
#import "DGImage.h"
#import "DGTrack.h"
#import "DGVideo.h"
#import "DGMarketplace.h"
#import "DGPrice.h"
#import "DGInventory.h"
#import "DGListing.h"
#import "DGOrder.h"
#import "DGPagination.h"
#import "DGResource.h"
#import "DGUser.h"
#import "DGProfile.h"
#import "DGCollection.h"
#import "DGCollectionField.h"
#import "DGCollectionFieldInstance.h"
#import "DGCollectionFolder.h"
#import "DGReleaseInstance.h"
#import "DGWantlist.h"

FOUNDATION_EXPORT double DiscogsAPIVersionNumber;
FOUNDATION_EXPORT const unsigned char DiscogsAPIVersionString[];

