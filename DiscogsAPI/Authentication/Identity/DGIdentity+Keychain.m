//
//  DGIdentity+Keychain.m
//  DiscogsAPI
//
//  Created by Maxime Epain on 12/11/2016.
//  Copyright © 2016 Maxime Epain. All rights reserved.
//

#import "DGIdentity+Keychain.h"

NSString * const kDGIdentityCurrentIdentifier = @"DGIdentityCurrentIdentifier";

@implementation DGIdentity (Keychain)

@dynamic current;
@dynamic accessToken;

#pragma mark <NSSecureCoding>

- (instancetype)initWithCoder:(NSCoder *)coder {
    self = [super init];
    if (self) {
        self.ID = [coder decodeObjectOfClass:[NSNumber class] forKey:NSStringFromSelector(@selector(ID))];
        self.resourceURL = [coder decodeObjectOfClass:[NSString class] forKey:NSStringFromSelector(@selector(resourceURL))];
        self.uri = [coder decodeObjectOfClass:[NSString class] forKey:NSStringFromSelector(@selector(uri))];
        self.consumerName = [coder decodeObjectOfClass:[NSString class] forKey:NSStringFromSelector(@selector(consumerName))];
        self.userName = [coder decodeObjectOfClass:[NSString class] forKey:NSStringFromSelector(@selector(userName))];
        
        // Backward compatibility
        NSString *token = [coder decodeObjectOfClass:[NSString class] forKey:@"token"];
        NSString *secret = [coder decodeObjectOfClass:[NSString class] forKey:@"secret"];
        if (token && secret) {
            self.accessToken = [[AFOAuth1Token alloc] initWithKey:token secret:secret session:nil expiration:nil renewable:NO];
        } else {
            self.accessToken = [coder decodeObjectOfClass:[AFOAuth1Token class] forKey:NSStringFromSelector(@selector(accessToken))];
        }
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)coder {
    [coder encodeObject:self.ID forKey:NSStringFromSelector(@selector(ID))];
    [coder encodeObject:self.resourceURL forKey:NSStringFromSelector(@selector(resourceURL))];
    [coder encodeObject:self.uri forKey:NSStringFromSelector(@selector(uri))];
    [coder encodeObject:self.consumerName forKey:NSStringFromSelector(@selector(consumerName))];
    [coder encodeObject:self.userName forKey:NSStringFromSelector(@selector(userName))];
    [coder encodeObject:self.accessToken forKey:NSStringFromSelector(@selector(accessToken))];
}

+ (BOOL)supportsSecureCoding {
    return YES;
}

#pragma mark <NSCopying>

- (id)copyWithZone:(NSZone *)zone {
    DGIdentity *copy = [[[self class] allocWithZone:zone] init];
    copy.ID             = self.ID.copy;
    copy.resourceURL    = self.resourceURL.copy;
    copy.uri            = self.uri.copy;
    copy.consumerName   = self.consumerName.copy;
    copy.userName       = self.userName.copy;
    copy.accessToken    = self.accessToken.copy;
    return copy;
}

#pragma mark Keychain

static NSString * const DGIdentityService = @"DGIdentityService";
static NSString * DGAccessGroup = nil;
static CFTypeRef DGSecurityAccessibility = NULL;

static NSMutableDictionary * DGKeychainQueryDictionaryWithIdentifier(NSString *identifier) {
    
    NSMutableDictionary *query = [NSMutableDictionary dictionary];
    query[(__bridge id)kSecClass] = (__bridge id)kSecClassGenericPassword;
    query[(__bridge id)kSecAttrService] = DGIdentityService;
    
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

+ (DGIdentity *)retrieveIdentityWithIdentifier:(NSString *)identifier {
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
    DGIdentity *identity = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    
    return identity;
}

+ (BOOL)deleteIdentityWithIdentifier:(NSString *)identifier {
    NSMutableDictionary *query = DGKeychainQueryDictionaryWithIdentifier(identifier);
    
    OSStatus status = SecItemDelete((__bridge CFDictionaryRef)query);
    
    if (status != errSecSuccess) {
        NSLog(@"Unable to delete credential with identifier \"%@\" (Error %li)", identifier, (long int)status);
    }
    
    return (status == errSecSuccess);
}

+ (BOOL)storeIdentity:(DGIdentity *)identity withIdentifier:(NSString *)identifier {
    NSMutableDictionary *query = [DGKeychainQueryDictionaryWithIdentifier(identifier) mutableCopy];
    
    if (!identity) {
        return [self deleteIdentityWithIdentifier:identifier];
    }
    
    NSMutableDictionary *update = [NSMutableDictionary dictionary];
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:identity];
    update[(__bridge id)kSecValueData] = data;
    
    OSStatus status;
    BOOL exists = !![self retrieveIdentityWithIdentifier:identifier];
    
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
