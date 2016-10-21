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
    
    NSBundle *bundle = [NSBundle bundleWithIdentifier:@"fr.maxep.DiscogsAPITests"];
    [RKTestFixture setFixtureBundle:bundle];
    
    _client = [DGHTTPClient clientWithAccessToken:@"sASrGphxujkKoCmDrucVJeeKVTBktcZxThGryyjQ"];
    _manager = [[RKObjectManager alloc] initWithHTTPClient:self.client];
}
    
@end
