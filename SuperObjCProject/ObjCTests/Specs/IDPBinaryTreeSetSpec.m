//
//  IDPBinaryTreeSetSpec.m
//  SuperObjCProject
//
//  Created by Ievgen on 6/19/16.
//  Copyright © 2016 1mlndollarsasset. All rights reserved.
//

#import "Kiwi.h"

#import "IDPSet.h"
#import "IDPBinaryTreeSet.h"

#import "NSObject+IDPObject.h"

SPEC_BEGIN(IDPBinaryTreeSpec);

describe(@"IDPBinaryTreeSpec", ^{
    registerMatchers(@"IDP");

    context(@"when added objects in range 1-7, binary tree should iterate through these numbers", ^{
        let(numbersSet, ^id{
            return [[NSSet alloc] initWithArray:@[@1, @2, @3, @4, @5, @6, @7]];
        });
        
        let(binaryTreeSet, ^id{
            IDPSet *tree = [IDPSet binaryTreeSetWithSet:numbersSet];
            return tree;
        });
        
        it(@"should be of count kIDPListNumbersCount", ^{
            [[binaryTreeSet should] haveCountOf:[numbersSet count]];
        });
        
        it(@"should iterate through all numbers in range", ^{
            for (NSNumber *number in binaryTreeSet) {
                [[theValue([numbersSet containsObject:number]) should] equal:theValue(YES)];
            }
        });
        
        it(@"should contain integers in range", ^{
            for (NSNumber *number in numbersSet) {
                [[theValue([binaryTreeSet containsObject:number]) should] equal:theValue(YES)];
            }
        });
        
        
    });
});


SPEC_END
