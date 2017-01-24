// DGTokenStore.m
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

#import "DGTokenStore.h"

@implementation DGTokenStore

static NSString * const DGOAuth1CredentialServiceName = @"DGOAuthCredentialService";
static NSString * DGAccessGroup = nil;
static CFTypeRef DGSecurityAccessibility = NULL;

static NSMutableDictionary * DGKeychainQueryDictionaryWithIdentifier(NSString *identifier) {
    
    NSMutableDictionary *query = [NSMutableDictionary dictionary];
    query[(__bridge id)kSecClass] = (__bridge id)kSecClassGenericPassword;
    query[(__bridge id)kSecAttrService] = DGOAuth1CredentialServiceName;
    
    if (identifier) {
        query[(__bridge id)kSecAttrAccount] = identifier;
    }
    
    if (DGAccessGroup) {
        query[(__bridge id)kSecAttrAccessGroup] = DGAccessGroup;
    }
    
    if (DGSecurityAccessibility) {
        query[(__bridge id)kSecAttrAccessible] = (__bridge id)DGSecurityAccessibility;
    }
    
    return query;
}

+ (void)load {
    DGSecurityAccessibility = kSecAttrAccessibleWhenUnlocked;
}

+ (void)setAccessibilityType:(CFTypeRef)accessibilityType {
    if (DGSecurityAccessibility) {
        CFRelease(DGSecurityAccessibility);
    }
    CFRetain(accessibilityType);
    DGSecurityAccessibility = accessibilityType;
}

+ (void)setAccessGroup:(NSString *)accessGroup {
    DGAccessGroup = accessGroup;
}

+ (AFOAuth1Token *)retrieveCredentialWithIdentifier:(NSString *)identifier {
    NSMutableDictionary *query = DGKeychainQueryDictionaryWithIdentifier(identifier);
    query[(__bridge id)kSecReturnData] = (__bridge id)kCFBooleanTrue;
    query[(__bridge id)kSecMatchLimit] = (__bridge id)kSecMatchLimitOne;
    
    CFDataRef result = nil;
    OSStatus status = SecItemCopyMatching((__bridge CFDictionaryRef)query, (CFTypeRef *)&result);
    
    if (status != errSecSuccess) {
        NSLog(@"Unable to fetch credential with identifier \"%@\" (Error %li)", identifier, (long int)status);
        return nil;
    }
    
    NSData *data = (__bridge_transfer NSData *)result;
    AFOAuth1Token *credential = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    
    return credential;
}

+ (BOOL)deleteCredentialWithIdentifier:(NSString *)identifier {
    NSMutableDictionary *query = DGKeychainQueryDictionaryWithIdentifier(identifier);
    
    OSStatus status = SecItemDelete((__bridge CFDictionaryRef)query);
    
    if (status != errSecSuccess) {
        NSLog(@"Unable to delete credential with identifier \"%@\" (Error %li)", identifier, (long int)status);
    }
    
    return (status == errSecSuccess);
}

+ (BOOL)storeCredential:(AFOAuth1Token *)credential
         withIdentifier:(NSString *)identifier {
    NSMutableDictionary *query = [DGKeychainQueryDictionaryWithIdentifier(identifier) mutableCopy];
    
    if (!credential) {
        return [self deleteCredentialWithIdentifier:identifier];
    }
    
    NSMutableDictionary *update = [NSMutableDictionary dictionary];
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:credential];
    update[(__bridge id)kSecValueData] = data;
    
    OSStatus status;
    BOOL exists = !![self retrieveCredentialWithIdentifier:identifier];
    
    if (exists) {
        status = SecItemUpdate((__bridge CFDictionaryRef)query, (__bridge CFDictionaryRef)update);
    } else {
        [query addEntriesFromDictionary:update];
        status = SecItemAdd((__bridge CFDictionaryRef)query, NULL);
    }
    
    if (status != errSecSuccess) {
        NSLog(@"Unable to %@ token with identifier \"%@\" (Error %li)", exists ? @"update" : @"add", identifier, (long int)status);
    }
    
    return (status == errSecSuccess);
}

@end
