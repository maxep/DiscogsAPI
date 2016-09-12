//
//  DGCompany+DiscogsAPI.h
//  Pods
//
//  Created by Nate Rivard on 9/12/16.
//
//

#import <Foundation/Foundation.h>

/**
 Primitive values for DGCompany.entityType
 */
typedef NS_ENUM(NSInteger, DGCompanyType) {
    DGCompanyTypeLabel = 1,
    DGCompanyTypeLicensedTo = 5,
    DGCompanyTypePhonographicCopyright = 13,
    DGCompanyTypeCopyright = 14,
    DGCompanyTypePublishedBy = 21,
    DGCompanyTypeRecordedAt = 23,
    DGCompanyTypeMixedAt = 27,
};
