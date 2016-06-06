//
//  NSString+IDPName.h
//  SuperObjCProject
//
//  Created by Ievgen on 6/1/16.
//  Copyright © 2016 1mlndollarsasset. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (IDPName)

+ (NSString *)randomName;

+ (id)arabicNumbers;

+ (NSString *)alphabetWithUnicodeRange:(NSRange)range;

+ (NSString *)randomStringWithLength:(NSUInteger)length alphabet:(NSString *)alphabet;

@end
