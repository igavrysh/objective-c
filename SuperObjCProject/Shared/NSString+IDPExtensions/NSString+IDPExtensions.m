//
//  NSString+IDPExtensions.h
//  SuperObjCProject
//
//  Created by Ievgen on 6/1/16.
//  Copyright © 2016 1mlndollarsasset. All rights reserved.
//

#import "NSString+IDPExtensions.h"

static NSUInteger const KNSStringDefaultRandomStringLength = 30;

@interface NSString (NSStringPrivate)

+ (NSArray *)lastNames;
+ (NSArray *)firstNames;

@end

@implementation NSString (NSStringPrivate)

+ (NSArray *)lastNames {
    static id result = nil;
    
    if (!result) {
        result = @[@"Farrah", @"Laviolette", @"Heal", @"Sechrest", @"Roots",
                   @"Homan", @"Starns", @"Oldham", @"Yocum", @"Mancia",
                   @"Prill", @"Lush", @"Piedra", @"Castenada", @"Warnock",
                   @"Vanderlinden", @"Simms", @"Gilroy", @"Brann", @"Bodden",
                   @"Lenz", @"Gildersleeve", @"Wimbish", @"Bello", @"Beachy",
                   @"Jurado", @"William", @"Beaupre", @"Dyal", @"Doiron",
                   @"Plourde", @"Bator", @"Krause", @"Odriscoll", @"Corby",
                   @"Waltman", @"Michaud", @"Kobayashi", @"Sherrick", @"Woolfolk",
                   @"Holladay", @"Hornback", @"Moler", @"Bowles", @"Libbey",
                   @"Spano", @"Folson", @"Arguelles", @"Burke", @"Rook"];
        
        [result retain];
    }
    
    return result;
}

+ (NSArray *)firstNames {
    static id result = nil;
    
    if (!result) {
        result = @[@"Tran", @"Lenore", @"Bud", @"Fredda", @"Katrice",
                   @"Clyde", @"Hildegard", @"Vernell", @"Nellie", @"Rupert",
                   @"Billie", @"Tamica", @"Crystle", @"Kandi", @"Caridad",
                   @"Vanetta", @"Taylor", @"Pinkie", @"Ben", @"Rosanna",
                   @"Eufemia", @"Britteny", @"Ramon", @"Jacque", @"Telma",
                   @"Colton", @"Monte", @"Pam", @"Tracy", @"Tresa",
                   @"Willard", @"Mireille", @"Roma", @"Elise", @"Trang",
                   @"Ty", @"Pierre", @"Floyd", @"Savanna", @"Arvilla",
                   @"Whitney", @"Denver", @"Norbert", @"Meghan", @"Tandra",
                   @"Jenise", @"Brent", @"Elenor", @"Sha", @"Jessie"];
        
        [result retain];
    }
    
    return result;
}

@end

@implementation NSString (IDPExtensions)

+ (NSString *)randomName {
    return [NSString stringWithFormat:@"%@ %@",
            [[NSString firstNames] objectAtIndex:arc4random_uniform((UInt32)[[NSString firstNames] count])],
            [[NSString lastNames] objectAtIndex:arc4random_uniform((UInt32)[[NSString lastNames] count])]];
}

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
