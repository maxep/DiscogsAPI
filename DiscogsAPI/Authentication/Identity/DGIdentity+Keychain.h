//
//  DGIdentity+Keychain.h
//  DiscogsAPI
//
//  Created by Maxime Epain on 12/11/2016.
//  Copyright © 2016 Maxime Epain. All rights reserved.
//

#import "DGIdentity.h"
#import "AFOAuth1Client.h"

NS_ASSUME_NONNULL_BEGIN

/**
 The keychain identifier for the current user identity.
 */
extern NSString * const kDGIdentityCurrentIdentifier;

/**
 DGIdentity protocol to store identity into keychain.
 */
@interface DGIdentity (Keychain) <NSSecureCoding, NSCopying>

/**
 Sets the accessibility type for all future identities saved to the Keychain.
 The default accessibility type is `kSecAttrAccessibleWhenUnlocked`.
 
 @param accessibilityType One of the "Keychain Item Accessibility Constants" used for determining when a keychain item should be readable.
 */
+ (void)setAccessibilityType:(CFTypeRef)accessibilityType;

/**
 Sets the access group type for all future identity saved to the Keychain.
 
 @param accessGroup The access group.
 */
+ (void)setAccessGroup:(nullable NSString *)accessGroup;

/**
 Retrieves the identity in keychain.
 
 @param identifier The identity identifier.
 
 @return The identity if it exists. Otherwise 'nil'.
 */
+ (nullable DGIdentity *)retrieveIdentityWithIdentifier:(NSString *)identifier;

/**
 Deletes the identity from keychain.
 
 @param identifier The identity identifier.
 
 @return 'YES' if it succeeded. Otherwise 'NO'.
 */
+ (BOOL)deleteIdentityWithIdentifier:(NSString *)identifier;

/**
 Stores the identity into keychain.
 
 @param identity   The identity.
 @param identifier The identity identifier.
 
 @return 'YES' if it succeeded. Otherwise 'NO'.
 */
+ (BOOL)storeIdentity:(nullable DGIdentity *)identity withIdentifier:(NSString *)identifier;

/**
 The currently authenticated user identity.
 */
@property (class, nullable) DGIdentity *current;

/**
 The user access token.
 */
@property (nonatomic, strong) AFOAuth1Token *accessToken;

@end

NS_ASSUME_NONNULL_END
