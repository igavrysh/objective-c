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

+ (id)randomString {
    return [self randomStringWithLength:arc4random_uniform(KNSStringDefaultRandomStringLength)];
}

+ (id)randomStringWithLength:(NSUInteger)length {
    return [self randomStringWithLength:length alphabet:[IDPAlphabet alphanumericAlphabet]];
}

+ (id)randomStringWithLength:(NSUInteger)length alphabet:(IDPAlphabet *)alphabet {
    NSMutableString *result = [NSMutableString stringWithCapacity:length];
    NSUInteger alphabetLength = [alphabet count];
    for (NSUInteger index = 0; index < length; index++) {
        [result appendFormat:@"%@", alphabet[arc4random_uniform((u_int32_t)alphabetLength)]];
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
