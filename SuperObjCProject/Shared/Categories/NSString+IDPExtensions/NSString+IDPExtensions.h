//
//  NSString+IDPExtensions.h
//  SuperObjCProject
//
//  Created by Ievgen on 6/1/16.
//  Copyright © 2016 1mlndollarsasset. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "IDPAlphabet.h"

@interface NSString (IDPExtensions)

// returns random string with English alphanumeric characters of random length of up to 30 symbols with the class of receiver
+ (instancetype)randomString;

// returns random string with English alphanumeric characters of length with the class of receiver
+ (instancetype)randomStringWithLength:(NSUInteger)length;

// returns string with characters from alphabet of length with the class of receiver
+ (instancetype)randomStringWithLength:(NSUInteger)length alphabet:(IDPAlphabet *)alphabet;

- (NSArray *)symbols;

@end
