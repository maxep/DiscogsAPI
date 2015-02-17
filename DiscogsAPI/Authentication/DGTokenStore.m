// DGTokenStore.m
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

#import "DGTokenStore.h"

NSString * const kDGOAuth1CredentialServiceName = @"DGOAuthCredentialService";

static NSDictionary * DGKeychainQueryDictionaryWithIdentifier(NSString *identifier) {
    return @{(__bridge id)kSecClass: (__bridge id)kSecClassGenericPassword,
             (__bridge id)kSecAttrAccount: identifier,
             (__bridge id)kSecAttrService: kDGOAuth1CredentialServiceName
             };
}

@implementation DGTokenStore

+ (AFOAuth1Token *)retrieveCredentialWithIdentifier:(NSString *)identifier {
    NSMutableDictionary *mutableQueryDictionary = [DGKeychainQueryDictionaryWithIdentifier(identifier) mutableCopy];
    mutableQueryDictionary[(__bridge id)kSecReturnData] = (__bridge id)kCFBooleanTrue;
    mutableQueryDictionary[(__bridge id)kSecMatchLimit] = (__bridge id)kSecMatchLimitOne;
    
    CFDataRef result = nil;
    OSStatus status = SecItemCopyMatching((__bridge CFDictionaryRef)mutableQueryDictionary, (CFTypeRef *)&result);
    
    if (status != errSecSuccess) {
        NSLog(@"Unable to fetch credential with identifier \"%@\" (Error %li)", identifier, (long int)status);
        return nil;
    }
    
    NSData *data = (__bridge_transfer NSData *)result;
    AFOAuth1Token *credential = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    
    return credential;
}

+ (BOOL)deleteCredentialWithIdentifier:(NSString *)identifier {
    NSMutableDictionary *mutableQueryDictionary = [DGKeychainQueryDictionaryWithIdentifier(identifier) mutableCopy];
    
    OSStatus status = SecItemDelete((__bridge CFDictionaryRef)mutableQueryDictionary);
    
    if (status != errSecSuccess) {
        NSLog(@"Unable to delete credential with identifier \"%@\" (Error %li)", identifier, (long int)status);
    }
    
    return (status == errSecSuccess);
}

+ (BOOL)storeCredential:(AFOAuth1Token *)credential
         withIdentifier:(NSString *)identifier
{
    id securityAccessibility = nil;
#if (defined(__IPHONE_OS_VERSION_MAX_ALLOWED) && __IPHONE_OS_VERSION_MAX_ALLOWED >= 43000) || (defined(__MAC_OS_X_VERSION_MAX_ALLOWED) && __MAC_OS_X_VERSION_MAX_ALLOWED >= 1090)
    securityAccessibility = (__bridge id)kSecAttrAccessibleWhenUnlocked;
#endif
    
    return [[self class] storeCredential:credential withIdentifier:identifier withAccessibility:securityAccessibility];
}

+ (BOOL)storeCredential:(AFOAuth1Token *)credential
         withIdentifier:(NSString *)identifier
      withAccessibility:(id)securityAccessibility
{
    NSMutableDictionary *mutableQueryDictionary = [DGKeychainQueryDictionaryWithIdentifier(identifier) mutableCopy];
    
    if (!credential) {
        return [self deleteCredentialWithIdentifier:identifier];
    }
    
    NSMutableDictionary *mutableUpdateDictionary = [NSMutableDictionary dictionary];
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:credential];
    mutableUpdateDictionary[(__bridge id)kSecValueData] = data;
    if (securityAccessibility) {
        [mutableUpdateDictionary setObject:securityAccessibility forKey:(__bridge id)kSecAttrAccessible];
    }
    
    OSStatus status;
    BOOL exists = !![self retrieveCredentialWithIdentifier:identifier];
    
    if (exists) {
        status = SecItemUpdate((__bridge CFDictionaryRef)mutableQueryDictionary, (__bridge CFDictionaryRef)mutableUpdateDictionary);
    } else {
        [mutableQueryDictionary addEntriesFromDictionary:mutableUpdateDictionary];
        status = SecItemAdd((__bridge CFDictionaryRef)mutableQueryDictionary, NULL);
    }
    
    if (status != errSecSuccess) {
        NSLog(@"Unable to %@ credential with identifier \"%@\" (Error %li)", exists ? @"update" : @"add", identifier, (long int)status);
    }
    
    return (status == errSecSuccess);
}

@end
