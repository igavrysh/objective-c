//
//  IDPCreatureTest.m
//  SuperObjCProject
//
//  Created by Ievgen on 6/1/16.
//  Copyright © 2016 1mlndollarsasset. All rights reserved.
//

#import "IDPCreatureTest.h"

#import "NSArray+IDPArrayEnumerator.h"
#import "IDPCreature.h"

@interface IDPCreatureTest ()

+ (NSMutableArray *)createCreatureArrayWithCount:(UInt8) count;

@end

@implementation IDPCreatureTest

+ (NSArray *)createCreatureArrayWithCount:(UInt8) count {
    NSMutableArray *creatures = [[NSMutableArray alloc] init];
    
    for (uint64_t index = 0; index < count; index++) {
        IDPCreature *creature = [IDPCreature creatureWithRandomNameAndGender];
        [creatures addObject:creature];
    }
    
    return creatures;
}

+ (void)creaturesPerformGenderSpecificOperation {
    UInt8 count = 10;
    
    NSArray *creatures = [IDPCreatureTest createCreatureArrayWithCount: count];
    
    for (IDPCreature *creature in creatures) {
        [creature performGenderSpecificOperation];
    }
    
    [creatures release];
}

+ (void)creaturesSayHi {
    UInt8 count = 10;
    
    NSArray *creatures = [IDPCreatureTest createCreatureArrayWithCount: count];
    
    NSLog(@"--- All creatures are saying hi! ---");
    [creatures performBlockWithEachObject:^(IDPCreature *creature) {
        [creature sayHi];
    }];
    
    [creatures release];
}

+ (void)creaturesChildrendSayHi {
    NSLog(@"--- All children are saying hi! ---");
    
    UInt8 count = 10;
    
    NSArray *creatures = [IDPCreatureTest createCreatureArrayWithCount: count];
    
    for (IDPCreature *creature in creatures) {
        [creature performGenderSpecificOperation];
    }
    
    [creatures performBlockWithEachObject:^(IDPCreature *creature) {
        [creature.children performBlockWithEachObject:^(IDPCreature *childCreature) {
            [childCreature sayHi];
        }];
    }];
    
    [creatures release];
}

@end
