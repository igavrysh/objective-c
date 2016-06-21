//
//  IDPDynamicIndexSetSpec.m
//  SuperObjCProject
//
//  Created by Ievgen on 6/20/16.
//  Copyright © 2016 1mlndollarsasset. All rights reserved.
//

#import "Kiwi.h"

#import "IDPDynamicIndexSet.h"

#import "NSNumber+IDPComparison.h"

SPEC_BEGIN(IDPDynamicIndexSetSpec);

describe(@"IDPDynamicIndexSetSpec", ^{
    registerMatchers(@"IDP");

    let(numbersSet, ^id{
        return [[NSSet alloc] initWithArray:@[@1, @2, @3, @4, @5, @6, @7]];
    });
    
    let(linkedListSet, ^id{
        return [IDPSet setWithSet:numbersSet];
    });
    
    let(dynamicIndexSet, ^id{
        return [IDPSet dynamicIndexSetWithObjectsCount:[linkedListSet count]];
    });
    
    it(@"should be of count kIDPListNumbersCount", ^{
        [[dynamicIndexSet should] haveCountOf:2];
    });
    
    it(@"should contain integers in range 1-7", ^{
        [[theBlock(^{
            NSUInteger index = 0;
            for (NSNumber *number in dynamicIndexSet) {
                [linkedListSet[[number unsignedIntegerValue]]  description];
                [number description];
                index++;
            }
        }) shouldNot] raise];
    });

});

SPEC_END
