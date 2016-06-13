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
            }) shouldNot] raise];;
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
            unichar character = 'A';
            for (NSString *symbol in alphabet) {
                [[symbol should] equal:[NSString stringWithFormat:@"%c", character]];
                character++;
            }
        });
    });
});

SPEC_END

