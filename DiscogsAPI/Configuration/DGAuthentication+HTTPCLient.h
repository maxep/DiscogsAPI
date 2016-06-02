//
//  DGAuthentication+HTTPCLient.h
//  DiscogsAPI
//
//  Created by Maxime Epain on 02/06/16.
//  Copyright © 2016 Maxime Epain. All rights reserved.
//

#import "DGAuthentication.h"
#import "DGHTTPClient.h"

@interface DGAuthentication (HTTPCLient)

/**
 The HTTP client with authorized header.
 */
@property (nonatomic, readonly) DGHTTPClient *HTTPClient;

@end
