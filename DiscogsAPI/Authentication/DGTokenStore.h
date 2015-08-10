// DGTokenStore.h
//
// Copyright (c) 2015 Maxime Epain
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

/**
 Token store to save and retrieve OAuth account tokens into Apple keychain.
 */
@interface DGTokenStore : NSObject

/**
 Retrieves the OAuth credential in keychain.
 
 @param identifier The credential identifier.
 
 @return The credential if it exists. Otherwise 'nil'.
 */
+ (AFOAuth1Token *)retrieveCredentialWithIdentifier:(NSString *)identifier;

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
+ (BOOL)storeCredential:(AFOAuth1Token *)credential withIdentifier:(NSString *)identifier;

/**
 Stores the OAuth credential into keychain.
 
 @param credential            The OAuth credential.
 @param identifier            The credential identifier.
 @param securityAccessibility The security accessibility.
 
 @return 'YES' if it succeeded. Otherwise 'NO'.
 */
+ (BOOL)storeCredential:(AFOAuth1Token *)credential withIdentifier:(NSString *)identifier withAccessibility:(id)securityAccessibility;

@end
