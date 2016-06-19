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

describe(@"IDPLinkedListSet", ^{
    registerMatchers(@"IDP");
    
    context(@"when added objects in range 1-5 should iterate through these numbers", ^{
        __block NSUInteger kIDPListNumbersCount = 5;
        
        let(numbersSet, ^id{
            return [[[NSSet alloc] initWithArray:@[@1, @2, @3, @4, @5]] autorelease];
        });
        
        let(linkedListSet, ^id{
            return [IDPSet setWithSet:numbersSet];
        });
        
        it(@"should be of count kIDPListNumbersCount", ^{
            [[linkedListSet should] haveCountOf:kIDPListNumbersCount];
        });
        
        it(@"should contain integers in range 1-5", ^{
            for (NSNumber *number in linkedListSet) {
                [[theValue([numbersSet containsObject:number]) should] equal:theValue(YES)];
            }
        });
        
    });

});

SPEC_END