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
#import "NSNumber+IDPNumber.h"

SPEC_BEGIN(IDPLinkedListSpec);

describe(@"IDPLinkedListSet", ^{
    registerMatchers(@"IDP");
    
    context(@"when added objects in range 1-7, linked list should iterate through these numbers", ^{
        let(numbersSet, ^id{
            return [[NSSet alloc] initWithArray:@[@1, @2, @3, @4, @5, @6, @7]];
        });
        
        let(linkedListSet, ^id{
            return [IDPSet setWithSet:numbersSet];
        });
        
        it(@"should be of count kIDPListNumbersCount", ^{
            [[linkedListSet should] haveCountOf:[numbersSet count]];
        });
        
        it(@"should contain integers in range 1-5", ^{
            for (NSNumber *number in linkedListSet) {
                [[theValue([numbersSet containsObject:number]) should] equal:theValue(YES)];
            }
        });
        
    });

});

SPEC_END