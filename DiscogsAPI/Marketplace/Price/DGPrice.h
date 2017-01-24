// DGPrice.h
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

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/**
 Currency descriptor.

 - DGCurrencyNone: None.
 - DGCurrencyUSD: Dollar US.
 - DGCurrencyGBP: Pound.
 - DGCurrencyEUR: Euro.
 - DGCurrencyCAD: Dollar Canadian.
 - DGCurrencyAUD: Dollar Australian.
 - DGCurrencyJPY: Japanese Yen.
 - DGCurrencyCHF: Swiss Franc.
 - DGCurrencyMXN: Mexican Peso.
 - DGCurrencyBRL: Brezilian Real.
 - DGCurrencyNZD: Dollar New Zealand.
 - DGCurrencySEK: Swedish crown.
 - DGCurrencyZAR: South African Rand.
 */
typedef NS_ENUM(NSInteger, DGCurrency){
    DGCurrencyNone = 0,
    DGCurrencyUSD,
    DGCurrencyGBP,
    DGCurrencyEUR,
    DGCurrencyCAD,
    DGCurrencyAUD,
    DGCurrencyJPY,
    DGCurrencyCHF,
    DGCurrencyMXN,
    DGCurrencyBRL,
    DGCurrencyNZD,
    DGCurrencySEK,
    DGCurrencyZAR
};

/**
 Returns currency as string.

 @param current Currency descriptor.
 @return Currency as string.
 */
extern NSString *DGCurrencyAsString(DGCurrency current);

/**
 Price representation.
 */
@interface DGPrice : NSObject

/// Currency.
@property (nonatomic, strong, nullable) NSString *currency;

/// Price value.
@property (nonatomic, strong, nullable) NSNumber *value;

@end

/**
 Price suggestions request.
 */
@interface DGPriceSuggestionsRequest : NSObject

/// Requested release ID.
@property (nonatomic, strong) NSNumber *releaseID;

@end

/**
 Price suggestions response.
 */
@interface DGPriceSuggestionsResponse : NSObject

/// Price for mint item.
@property (nonatomic, strong, nullable) DGPrice *mint;

/// Price for near mint item.
@property (nonatomic, strong, nullable) DGPrice *nearMint;

/// Price for very good plus item.
@property (nonatomic, strong, nullable) DGPrice *veryGoodPlus;

/// Price for very good item.
@property (nonatomic, strong, nullable) DGPrice *veryGood;

/// Price for good plus item.
@property (nonatomic, strong, nullable) DGPrice *goodPlus;

/// Price for good item.
@property (nonatomic, strong, nullable) DGPrice *good;

/// Price for fair item.
@property (nonatomic, strong, nullable) DGPrice *fair;

/// Price for poor item.
@property (nonatomic, strong, nullable) DGPrice *poor;

@end

NS_ASSUME_NONNULL_END
