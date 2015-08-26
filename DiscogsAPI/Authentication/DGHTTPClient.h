// DGHTTPClient.m
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

#import <AFOAuth1Client/AFOAuth1Client.h>

/**
 Discogs Media Type.
 */
typedef NS_ENUM(NSInteger, DGMediaType){
    /**
     Discogs Media Type.
     */
    DGDiscogsMediaType,
    /**
     HTML media type.
     */
    DGHTMLMediaType,
    /**
     Plain text media type.
     */
    DGPlainTextMediaType
};

/**
 `DGHTTPClient` encapsulates common patterns to authenticate against the Discogs API server.
 
 @see The Discogs Auth Protocol: http://www.discogs.com/developers/#page:authentication,header:authentication-discogs-auth-flow
 @see RFC 5849 The OAuth 1.0 Protocol: https://tools.ietf.org/html/rfc5849
 */
@interface DGHTTPClient : AFOAuth1Client

@property (nonatomic,readwrite) DGMediaType mediaType;

/**
 Initializes an `DGHTTPClient` object with the specified consumer key and secret.
 
 @param key The consumer key.
 @param secret The consumer secret.
 */
- (id)initWithBaseURL:(NSURL *)url key:(NSString *)key secret:(NSString *)secret;

/**
 Initializes an `DGHTTPClient` object with the specified access token.
 
 @param token The personal access token.
 */
- (id)initWithBaseURL:(NSURL *)url accessToken:(NSString *)token;

@end
