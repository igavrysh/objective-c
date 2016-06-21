//
//  IDPAlphabet.h
//  Test
//
//  Created by Ievgen on 6/9/16.
//  Copyright © 2016 1mlndollarsasset. All rights reserved.
//

#import <Foundation/Foundation.h>

extern
NSRange IDPMakeAlphabetRange(unichar value1, unichar value2);

@interface IDPAlphabet : NSObject <NSFastEnumeration>

+ (instancetype)alphabetWithRange:(NSRange)range;
+ (instancetype)alphabetWithStrings:(NSArray *)strings;
+ (instancetype)alphabetWithAlphabets:(NSArray *)alphabets;
+ (instancetype)alphabetWithSymbols:(NSString *)string;

- (instancetype)initWithRange:(NSRange)range;
- (instancetype)initWithAlphabets:(NSArray *)alphabets;
- (instancetype)initWithStrings:(NSArray *)strings;
- (instancetype)initWithSymbols:(NSString *)string;

// the method should be overriden
- (NSUInteger)count;

// the method should be overriden
- (NSString *)stringAtIndex:(NSUInteger)index;

- (NSString *)objectAtIndexedSubscript:(NSUInteger)index;

- (NSString *)string;

@end
