//
//  IDPLinkedListSetSpec.m
//  SuperObjCProject
//
//  Created by Ievgen on 6/16/16.
//  Copyright © 2016 1mlndollarsasset. All rights reserved.
//

#import "Kiwi.h"

#import "IDPLinkedListSet.h"

#import "NSObject+IDPObject.h"

SPEC_BEGIN(IDPLinkedListSpec);

describe(@"IDPAlphabet", ^{
    __block IDPLinkedListSet *linkedList = nil;
    __block NSUInteger kIDPListNumbersCount = 10;
    
    afterAll(^{
        linkedList = nil;
    });
    
    registerMatchers(@"IDP");
    
    context(@"when initialized with + alphabetWithRange: with range 'A'-'B' ", ^{
        
        beforeAll(^{ // Occurs once
            linkedList = [IDPLinkedListSet object];
            
            for (NSUInteger index = 0; index < kIDPListNumbersCount; index++){
                [linkedList addObject:[NSNumber numberWithUnsignedLong:index + 1]];
            }
        });
        
        it(@"should be of count kIDPListNumbersCount", ^{
            [[linkedList should] haveCountOf:kIDPListNumbersCount];
        });
        
        it(@"should return integers in range 1-10", ^{
            NSUInteger counter = 10;
            for (NSNumber *number in linkedList) {
                NSComparisonResult result = [number compare:[NSNumber numberWithUnsignedLong:counter]];
                
                [[theValue(NSOrderedSame == result) should] beYes];
        
                counter--;
            }
        });
        
    });

});

SPEC_END