//
//  DGTestCase.m
//  DiscogsAPI
//
//  Created by Maxime Epain on 21/10/2016.
//  Copyright © 2016 Maxime Epain. All rights reserved.
//

#import "DGTestCase.h"

@implementation DGTestCase

- (void)setUp {
    [super setUp];
    
    RKLogConfigureByName("RestKit/ObjectMapping", RKLogLevelDebug);
    RKLogConfigureByName("RestKit/Network", RKLogLevelTrace);
    
    NSBundle *bundle = [NSBundle bundleWithIdentifier:@"fr.maxep.DiscogsAPITests"];
    [RKTestFixture setFixtureBundle:bundle];
    
    _client = [DGHTTPClient clientWithAccessToken:@"sASrGphxujkKoCmDrucVJeeKVTBktcZxThGryyjQ"];
    
    NSString *userAgent = [NSString stringWithFormat:@"%@/%@ (%@; iOS %@)",
                           bundle.infoDictionary[(__bridge NSString *)kCFBundleExecutableKey] ?: bundle.infoDictionary[(__bridge NSString *)kCFBundleIdentifierKey],
                           (__bridge id)CFBundleGetValueForInfoDictionaryKey(CFBundleGetMainBundle(), kCFBundleVersionKey) ?: bundle.infoDictionary[(__bridge NSString *)kCFBundleVersionKey],
                           [UIDevice currentDevice].model, [UIDevice currentDevice].systemVersion];
    
    [_client setDefaultHeader:@"User-Agent" value:userAgent];
    
    _manager = [[RKObjectManager alloc] initWithHTTPClient:self.client];
    _manager.requestSerializationMIMEType = RKMIMETypeJSON;
}
    
@end
