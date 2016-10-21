//
//  DGTestCase.h
//  DiscogsAPI
//
//  Created by Maxime Epain on 21/10/2016.
//  Copyright © 2016 Maxime Epain. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <RestKit/RestKit.h>
#import <RestKit/Testing.h>

#import <DiscogsAPI/DiscogsAPI.h>
#import <DiscogsAPI/DGOperation.h>
#import <DiscogsAPI/DGHTTPClient.h>
#import <DiscogsAPI/DGEndpoint+Configuration.h>

@interface DGTestCase<__covariant EndpointType : DGEndpoint *> : XCTestCase

@property (nonatomic, readonly) DGHTTPClient *client;

@property (nonatomic, readonly) RKObjectManager *manager;

@property (nonatomic, strong) EndpointType endpoint;

@end
