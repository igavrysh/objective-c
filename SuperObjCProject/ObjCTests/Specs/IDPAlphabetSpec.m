//
//  IDPAlphabetSpec.m
//  Test
//
//  Created by Ievgen on 6/12/16.
//  Copyright © 2016 1mlndollarsasset. All rights reserved.
//

#import "Kiwi.h"
#import "IDPClusterAlphabet.h"
#import "IDPRangeAlphabet.h"
#import "IDPStringsAlphabet.h"

SPEC_BEGIN(IDPAlphabetSpec);

describe(@"IDPAlphabet", ^{
    __block IDPAlphabet *alphabet = nil;
//    + (instancetype)alphabetWithRange:(NSRange)range;
//    + (instancetype)alphabetWithStrings:(NSArray *)strings;
//    + (instancetype)alphabetWithAlphabets:(NSArray *)alphabets;
//    + (instancetype)alphabetWithSymbols:(NSString *)string;
//    
//    - (instancetype)initWithRange:(NSRange)range;
//    - (instancetype)initWithAlphabets:(NSArray *)alphabets;
//    - (instancetype)initWithStrings:(NSArray *)strings;
//    - (instancetype)initWithSymbols:(NSString *)string;
//    
//    - (NSUInteger)count;
//    - (id)stringAtIndex:(NSUInteger)index;
//    
//    - (NSString *)objectAtIndexedSubscript:(NSUInteger)index;
    
    afterAll(^{
        alphabet = nil;
    });
    
    registerMatchers(@"BG"); // Registers BGTangentMatcher, BGConvexMatcher, etc.
    
    context(@"when initialized with + alphabetWithRange: with range 'A'-'B'", ^{
        
        /*let(variable, ^{ // Occurs before each enclosed "it"
            //return [MyClass instance];
            return nil;
        });*/
        
        beforeAll(^{ // Occurs once
            alphabet = [IDPAlphabet alphabetWithRange:IDPMakeAlphabetRange('A', 'B')];
        });
        
        beforeEach(^{ // Occurs before each enclosed "it"
        });
        
        afterEach(^{ // Occurs after each enclosed "it"
        });
        
        it(@"should be of class IDPRangeAlphabet", ^{            
            [[alphabet should] beKindOfClass:[IDPRangeAlphabet class]];
        });
        
        it(@"should be of count 2", ^{
            //[[theValue([alphabet count]) should] equal:@(2)];
            [[alphabet should] haveCountOf:2];
        });
        
        it(@"should contain @\"A\" at index = 0", ^{
            [[[alphabet stringAtIndex:0] should] equal:@"A"];
        });
        
        it(@"should contain @\"B\" at index = 1", ^{
            [[[alphabet stringAtIndex:1] should] equal:@"B"];
        });
        
        it(@"should throw, when requesting object at index 3", ^{
            [[theBlock(^{
                id a = alphabet[3];
                [a description];
            }) should] raise];
            
            [[theBlock(^{
                [alphabet stringAtIndex:3];
            }) should] raise];
        });
        
        it(@"should return @\"AB\" from - string", ^{
            [[[alphabet string] should] equal:@"AB"];
        });
    });
    
    context(@"when initialized with - initWithRange: with range 'A'-'B'", ^{
        beforeAll(^{
            alphabet = [[IDPAlphabet alloc] initWithRange:IDPMakeAlphabetRange('A', 'B')];
        });
        
        it(@"should be of class IDPRangeAlphabet", ^{
            [[alphabet should] beKindOfClass:[IDPRangeAlphabet class]];
        });
    });
    
    context(@"when initialized with +alphabetWithRange with range 'A' - 'z' when enumerated", ^{
        NSRange range = IDPMakeAlphabetRange('A', 'z');
        
        beforeAll(^{
            alphabet = [[IDPAlphabet alloc] initWithRange:range];
        });
        
        it(@"shouldn't raise", ^{
            [[theBlock(^{
                for (id symbol in alphabet) {
                    [symbol description];
                }
            }) shouldNot] raise];
        });
        
        it(@"should return count of symbols equal to 'A'-'z' range", ^{
            NSUInteger count = 0;
            for (NSString *symbol in alphabet) {
                [symbol description];
                count++;
            }
            
            [[theValue(count) should] equal:theValue(range.length)];
        });
        
        it(@"should return symbols in range 'A'-'z'", ^{
            unichar character = range.location;
            for (NSString *symbol in alphabet) {
                [[symbol should] equal:[NSString stringWithFormat:@"%c", character]];
                character++;
            }
        });
    });
    
    context(@"when initialized with +alphabetWithStrings: with @[@\"a\", @\"b\", @\"c\"]", ^{
        beforeAll(^{
            alphabet = [IDPAlphabet alphabetWithStrings:@[@"a", @"b", @"c"]];
        });
        
        it(@"should be of class IDPStringsAlphabet", ^{
            [[alphabet should] beKindOfClass:[IDPStringsAlphabet class]];
        });
        
        it(@"should be of count 3", ^{
            [[alphabet should] haveCountOf:3];
        });
        
        it(@"should contain @\"a\" at index = 0", ^{
            [[[alphabet stringAtIndex:0] should] equal:@"a"];
        });
        
        it(@"should contains @\"b\" at index = 1", ^{
            [[[alphabet stringAtIndex:1] should] equal:@"b"];
        });
        
        it(@"should contains @\"b\" at index = 2", ^{
            [[[alphabet stringAtIndex:2] should] equal:@"c"];
        });
        
        it(@"should raise, when requesting object at index 3", ^{
            [[theBlock(^{
                [alphabet stringAtIndex:3];
            }) should] raise];
            
            [[theBlock(^{
                id a = alphabet[3];
                [a description];
            }) should] raise];
        });
        
        it(@"should return @\"ab\" from - string", ^{
            [[[alphabet string] should] equal:@"abc"];
        });
    });
    
    
    context(@"when initializes with -initWithStrings: with @[@\"a\", @\"b\"]", ^{
        beforeAll(^{
            alphabet = [[IDPAlphabet alloc] initWithStrings:@[@"a", @"b"]];
        });
        
        it(@"should be of class IDPStringsAlphabet", ^{
            [[alphabet should] beKindOfClass:[IDPStringsAlphabet class]];
        });
    });
    
    
    context(@"when initialized with +initWithStrings with array containing 'A' - 'z' when enumerated", ^{
        NSRange range = IDPMakeAlphabetRange('A', 'z');
        NSMutableArray *strings = [NSMutableArray new];
        
        beforeAll(^{
            for (unichar symbol = range.location; symbol < NSMaxRange(range); symbol++) {
                [strings addObject:[NSString stringWithFormat:@"%c", symbol]];
            }
            
            alphabet = [[IDPAlphabet alloc] initWithStrings:strings];
        });
        
        it(@"shouldn't raise", ^{
            [[theBlock(^{
                for (id symbol in alphabet) {
                    [symbol description];
                }
            }) shouldNot] raise];
        });
        
        it(@"should return count of symbols equal to 'A'-'z' range", ^{
            NSUInteger count = 0;
            for (NSString *symbol in alphabet) {
                [symbol description];
                count++;
            }
            
            [[theValue(count) should] equal:theValue(range.length)];
        });
        
        it(@"should return symbols in range 'A'-'z'", ^{
            unichar character = range.location;
            for (NSString *symbol in alphabet) {
                [[symbol should] equal:[NSString stringWithFormat:@"%c", character]];
                character++;
            }
        });
    });
    
#pragma mark -
#pragma mark Cluster
    context(@"when initialized with +alphabetWithAlphabets: with alphabets in range 'A'-'Z', 'a'-'z'", ^{
        IDPAlphabet *capitalizedAlphabet = [IDPAlphabet alphabetWithRange:IDPMakeAlphabetRange('A', 'Z')];
        IDPAlphabet *lowercaseAlphabet = [IDPAlphabet alphabetWithRange:IDPMakeAlphabetRange('a', 'z')];
        
        beforeAll(^{
            alphabet = [IDPAlphabet alphabetWithAlphabets:@[capitalizedAlphabet, lowercaseAlphabet]];
        });
        
        it(@"should be of class IDPClusterAlphabet", ^{
            [[alphabet should] beKindOfClass:[IDPClusterAlphabet class]];
        });
        
        it(@"should be of count 52", ^{
            [[alphabet should] haveCountOf:52];
        });
        
        it(@"should raise, when requesting object at index 53", ^{
            [[theBlock(^{
                [alphabet stringAtIndex:53];
            }) should] raise];
            
            [[theBlock(^{
                id a = alphabet[53];
                [a description];
            }) should] raise];
        });
        
        it(@"should return @\"A-Za-z\" from - string", ^{
            NSString *string = [NSString stringWithFormat:@"%@%@", [capitalizedAlphabet string], [lowercaseAlphabet string]];
            [[[alphabet string] should] equal:string];
        });
    });
    
    context(@"when initializes with -initWithAlphabets: with alphabets in range 'A'-'Z', 'a'-'z'", ^{
        IDPAlphabet *capitalizedAlphabet = [IDPAlphabet alphabetWithRange:IDPMakeAlphabetRange('A', 'Z')];
        IDPAlphabet *lowercaseAlphabet = [IDPAlphabet alphabetWithRange:IDPMakeAlphabetRange('a', 'z')];
        
        beforeAll(^{
            alphabet = [[IDPAlphabet alloc] initWithAlphabets:@[capitalizedAlphabet, lowercaseAlphabet]];
        });
        
        it(@"should be of class IDPStringsAlphabet", ^{
            [[alphabet should] beKindOfClass:[IDPClusterAlphabet class]];
        });
    });
    
    context(@"when initialized with +initWithStrings with array containing 'A' - 'z' when enumerated", ^{
        NSRange capitalizedRange = IDPMakeAlphabetRange('A', 'Z');
        NSRange lowercaseRange = IDPMakeAlphabetRange('a', 'z');
        
        
        IDPAlphabet *capitalizedAlphabet = [IDPAlphabet alphabetWithRange:capitalizedRange];
        IDPAlphabet *lowercaseAlphabet = [IDPAlphabet alphabetWithRange:lowercaseRange];
        
        beforeAll(^{
            alphabet = [[IDPAlphabet alloc] initWithAlphabets:@[capitalizedAlphabet, lowercaseAlphabet]];
        });
        
        it(@"shouldn't raise", ^{
            [[theBlock(^{
                for (id symbol in alphabet) {
                    [symbol description];
                }
            }) shouldNot] raise];
        });
        
        it(@"should return count of symbols equal to 'A'-'Z' + 'a'-'z' range", ^{
            NSUInteger count = 0;
            for (NSString *symbol in alphabet) {
                [symbol description];
                count++;
            }
            
            [[theValue(count) should] equal:theValue([capitalizedAlphabet count] + [lowercaseAlphabet count])];
        });
        
        it(@"should return symbols in range 'A'-'Z' + 'a'-'z'", ^{
            NSMutableString *string = [NSMutableString stringWithString:[capitalizedAlphabet string]];
            [string appendString:[lowercaseAlphabet string]];
            
            NSUInteger index = 0;
            for (NSString *symbol in alphabet) {
                [[symbol should] equal:[NSString stringWithFormat:@"%c", [string characterAtIndex:index]]];
                index++;
            }
        });
    });
    
});

SPEC_END

