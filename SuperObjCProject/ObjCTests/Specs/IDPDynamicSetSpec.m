//
//  IDPDynamicSetSpec.m
//  SuperObjCProject
//
//  Created by Ievgen on 6/20/16.
//  Copyright © 2016 1mlndollarsasset. All rights reserved.
//

#import "Kiwi.h"

#import "IDPDynamicSet.h"

SPEC_BEGIN(IDPDynamicSetSpec);

describe(@"IDPBinaryTreeSpec", ^{
    registerMatchers(@"IDP");

    let(numbersArray, ^id{
        return @[@1, @2, @3, @4, @5, @6, @7, @8, @9, @10];
    });
    
    let(numbersSet, ^id{
        return [[NSSet alloc] initWithArray:numbersArray];
    });
    
    let(binaryTreeSet, ^id{
        IDPDynamicSet *dynamicSet = [IDPDynamicSet binaryTreeSetWithSet:numbersSet];
        return dynamicSet;
    });

    let(linkedListSet, ^id{
        IDPDynamicSet *dynamicSet = [IDPDynamicSet linkedListSetWithSet:numbersSet];
        return dynamicSet;
    });
    
    it(@"object at index 2 should be equal to object at index 4", ^{
        [[theValue(binaryTreeSet[2]) should] equal:theValue(numbersArray[4])];
    });
    
    it(@"object at index 3 should be equal to object at index 9", ^{
        [[theValue(linkedListSet[3]) should] equal:theValue(numbersArray[9])];
    });
    
    it(@"object at index 1 should be equal to object at index 1", ^{
        [[theValue(binaryTreeSet[1]) should] equal:theValue(numbersArray[1])];
    });
    
    it(@"object at index 0 should be equal to object at index 0", ^{
        [[theValue(linkedListSet[0]) should] equal:theValue(numbersArray[0])];
    });

});

SPEC_END
