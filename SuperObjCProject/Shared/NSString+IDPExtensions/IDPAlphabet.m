//
//  IDPAlphabet.m
//  Test
//
//  Created by Ievgen on 6/9/16.
//  Copyright © 2016 1mlndollarsasset. All rights reserved.
//

#import "IDPAlphabet.h"

#import <math.h>

#import "IDPRangeAlphabet.h"
#import "IDPClusterAlphabet.h"
#import "IDPStringsAlphabet.h"

#import "NSString+IDPExtensions.h"

NSRange IDPMakeAlphabetRange(unichar value1, unichar value2) {
    unichar minValue = MIN(value1, value2);
    unichar maxValue = MAX(value1, value2);
    
    return NSMakeRange(minValue, maxValue - minValue + 1);
}

@implementation IDPAlphabet

#pragma mark -
#pragma mark Class methods

+ (instancetype)alphabetWithRange:(NSRange)range {
    return [[[IDPRangeAlphabet alloc] initWithRange:range] autorelease];
}

+ (instancetype)alphabetWithStrings:(NSArray *)strings {
    return [[[IDPStringsAlphabet alloc] initWithStrings:strings] autorelease];
}

+ (instancetype)alphabetWithAlphabets:(NSArray *)alphabets {
    return [[[IDPClusterAlphabet alloc] initWithAlphabets:alphabets] autorelease];
}

+ (instancetype)alphabetWithSymbols:(NSString *)string {
    return [self alphabetWithStrings:[string symbols]];
}

+ (instancetype)alphanumericAlphabet {
    return [IDPAlphabet alphabetWithAlphabets:@[[IDPAlphabet letterAlphabet], [IDPAlphabet numericAlphabet]]];
}

+ (instancetype)numericAlphabet {
    return [IDPAlphabet alphabetWithRange:NSMakeRange('0', '9' - '0' + 1)];
}

+ (instancetype)lowercaseLetterAlphabet {
    return [IDPAlphabet alphabetWithRange:NSMakeRange('a', 'z' - 'a' + 1)];
}

+ (instancetype)capitalizedLetterAlphabet {
    return [IDPAlphabet alphabetWithRange:NSMakeRange('A', 'Z' - 'A' + 1)];
}

+ (instancetype)letterAlphabet {
    return [IDPAlphabet alphabetWithAlphabets:@[[IDPAlphabet lowercaseLetterAlphabet], [IDPAlphabet capitalizedLetterAlphabet]]];
}

+ (instancetype)alphabetWithUnicodeRange:(NSRange)range {
    return [IDPAlphabet alphabetWithRange:range];
}

#pragma mark
#pragma mark Initializations and Deallocations

- (instancetype)initWithRange:(NSRange)range {
    [self release];
    
    return [[IDPRangeAlphabet alloc] initWithRange:range];
}

- (instancetype)initWithAlphabets:(NSArray *)alphabets {
    [self release];
    
    return [[IDPClusterAlphabet alloc] initWithAlphabets:alphabets];
}

- (instancetype)initWithStrings:(NSArray *)strings {
    [self release];
    
    return [[IDPStringsAlphabet alloc] initWithStrings:strings];
}

- (instancetype)initWithSymbols:(NSString *)string {
    return [self initWithStrings:[string symbols]];
}

#pragma mark -
#pragma mark Public

- (NSUInteger)count {
    [self doesNotRecognizeSelector:_cmd];
    
    return 0;
}

- (NSString *)stringAtIndex:(NSUInteger)index {
    [self doesNotRecognizeSelector:_cmd];
    
    return nil;     
}

- (NSString *)objectAtIndexedSubscript:(NSUInteger)index {
    return [self stringAtIndex:index];
}

- (NSString *)string {
    NSMutableString *string = [NSMutableString stringWithCapacity:[self count]];
    for (NSString *symbol in self) {
        [string appendString:symbol];
    }
    
    return [[string copy] autorelease];
}

#pragma mark -
#pragma mark NSFastEnumeration
//
//- (void)a {
//    for (NSString *symbol in self) {
//        
//    }
//    
//    {
//        NSFastEnumerationState state;
//        memset(&state, 0, sizeof(state));
//        
//        NSUInteger bufferCount = 16;
//        id objects[bufferCount];
//        memset(objects, 0, sizeof(objects));
//        
//        NSUInteger count = 0;
//        NSUInteger index = 0;
//        
//        NSString *symbol = nil;
//        
//        BOOL firstRun = YES;
//        unsigned long mutations = 0;
//        
//        while ((count = [self countByEnumeratingWithState:&state
//                                                  objects:objects
//                                                    count:bufferCount]))
//        {
//            if (firstRun) {
//                mutations = *state.mutationsPtr;
//                firstRun = NO;
//            }
//            
//            NSAssert(mutations != *state.mutationsPtr, NSGenericException);
//            
//            for (index = 0; index < count; index++) {
//                if (state.itemsPtr) {
//                    symbol = state.itemsPtr[index];
//                } else {
//                    symbol = objects[index];
//                }
//            }
//        }
//    }
//}

- (NSUInteger)countByEnumeratingWithState:(NSFastEnumerationState *)state objects:(id *)stackbuf count:(NSUInteger)resultLength
{
    state->mutationsPtr = (unsigned long *)self;
    
    NSUInteger length = MIN(state->state + resultLength, [self count]);
    resultLength = length - state->state;
    
    if (0 != resultLength) {
        for (NSUInteger index = 0; index < resultLength; index++) {
            stackbuf[index] = self[index + state->state];
        }
    }
    
    state->itemsPtr = stackbuf;
    
    state->state += resultLength;
    
    return resultLength;
}

@end
