// DGTokenStore.h
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

#import <Foundation/Foundation.h>
#import <AFOAuth1Client/AFOAuth1Client.h>

NS_ASSUME_NONNULL_BEGIN

/**
 Token store to save and retrieve OAuth account tokens into Apple keychain.
 */
@interface DGTokenStore : NSObject

/**
 Sets the accessibility type for all future credentials saved to the Keychain.
 The default accessibility type is `kSecAttrAccessibleWhenUnlocked`.
 
 @param accessibilityType One of the "Keychain Item Accessibility Constants" used for determining when a keychain item should be readable.
 */
+ (void)setAccessibilityType:(CFTypeRef)accessibilityType;

/**
 Sets the access group type for all future tokens saved to the Keychain.
 
 @param accessGroup The access group.
 */
+ (void)setAccessGroup:(nullable NSString *)accessGroup;

/**
 Retrieves the OAuth credential in keychain.
 
 @param identifier The credential identifier.
 
 @return The credential if it exists. Otherwise 'nil'.
 */
+ (nullable AFOAuth1Token *)retrieveCredentialWithIdentifier:(NSString *)identifier;

/**
 Deletes the OAuth credential from keychain.
 
 @param identifier The credential identifier.
 
 @return 'YES' if it succeeded. Otherwise 'NO'.
 */
+ (BOOL)deleteCredentialWithIdentifier:(NSString *)identifier;

/**
 Stores the OAuth credential into keychain.
 
 @param credential The OAuth credential.
 @param identifier The credential identifier.
 
 @return 'YES' if it succeeded. Otherwise 'NO'.
 */
+ (BOOL)storeCredential:(nullable AFOAuth1Token *)credential withIdentifier:(NSString *)identifier;

@end

NS_ASSUME_NONNULL_END
