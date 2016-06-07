//
//  NSString+IDPExtensions.h
//  SuperObjCProject
//
//  Created by Ievgen on 6/1/16.
//  Copyright © 2016 1mlndollarsasset. All rights reserved.
//

#import "NSString+IDPExtensions.h"

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

@end


