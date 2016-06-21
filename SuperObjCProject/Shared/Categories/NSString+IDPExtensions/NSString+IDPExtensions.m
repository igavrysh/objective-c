//
//  NSString+IDPExtensions.h
//  SuperObjCProject
//
//  Created by Ievgen on 6/1/16.
//  Copyright © 2016 1mlndollarsasset. All rights reserved.
//

#import "NSString+IDPExtensions.h"

static NSUInteger const KNSStringDefaultRandomStringLength = 30;

@implementation NSString (IDPExtensions)

+ (id)alphanumericAlphabet {
    NSMutableString *result = [NSMutableString stringWithString:[self letterAlphabet]];
    [result appendString:[self numericAlphabet]];
    
    return [self stringWithString:result];
}

+ (id)numericAlphabet {
    return [self alphabetWithUnicodeRange:NSMakeRange('0', '9' - '0' + 1)];
}

+ (id)lowercaseLetterAlphabet {
    return [self alphabetWithUnicodeRange:NSMakeRange('a', 'z' - 'a' + 1)];
}

+ (id)capitalizedLetterAlphabet {
    return [self alphabetWithUnicodeRange:NSMakeRange('A', 'Z' - 'A' + 1)];
}

+ (id)letterAlphabet {
    NSMutableString *result = [NSMutableString stringWithString:[self lowercaseLetterAlphabet]];
    [result appendString:[self capitalizedLetterAlphabet]];
    
    return [self stringWithString:result];
}

+ (id)alphabetWithUnicodeRange:(NSRange)range {
    NSMutableString *result = [NSMutableString string];
    for (unichar character = range.location; character < NSMaxRange(range); character++) {
        [result appendFormat:@"%c", character ];
    }
    
    return [self stringWithString:result];
}

+ (id)randomString {
    return [self randomStringWithLength:arc4random_uniform(KNSStringDefaultRandomStringLength)];
}

+ (id)randomStringWithLength:(NSUInteger)length {
    return [self randomStringWithLength:length alphabet:[self alphanumericAlphabet]];
}

+ (id)randomStringWithLength:(NSUInteger)length alphabet:(NSString *)alphabet {
    NSMutableString *result = [NSMutableString stringWithCapacity:length];
    NSUInteger alphabetLength = [alphabet length];
    
    for (NSUInteger index = 0; index < length; index++) {
        unichar resultChar = [alphabet characterAtIndex:arc4random_uniform((u_int32_t)alphabetLength)];
        [result appendFormat:@"%c", resultChar];
    }
    
    return [self stringWithString:result];
}

- (NSArray *)symbols  {
    NSMutableArray *result = [NSMutableArray arrayWithCapacity:[self length]];
    NSUInteger length = [self length];
    
    for (NSUInteger index = 0; index < length; index++) {
        unichar resultChar = [self characterAtIndex:index];
        [result addObject:[NSString stringWithFormat:@"%c", resultChar]];
    }
    
    return [[result copy] autorelease];
}

@end
