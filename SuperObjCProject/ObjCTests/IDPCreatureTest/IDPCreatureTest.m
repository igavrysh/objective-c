//
//  IDPCreatureTest.m
//  SuperObjCProject
//
//  Created by Ievgen on 6/1/16.
//  Copyright © 2016 1mlndollarsasset. All rights reserved.
//

#import "IDPCreatureTest.h"

#import "IDPCreature.h"

#import "NSArray+IDPArrayEnumerator.h"
#import "NSObject+IDPObject.h"

@interface IDPCreatureTest ()

+ (NSMutableArray *)creaturesWithCount:(NSUInteger) count;

- (void)creaturesPerformGenderSpecificOperation;

- (void)creaturesSayHi;

- (void)creaturesChildrendSayHi;

@end

@implementation IDPCreatureTest

#pragma mark -
#pragma mark Public Methods

- (void)execute {
    [self creaturesPerformGenderSpecificOperation];
    
    [self creaturesSayHi];
    
    [self creaturesChildrendSayHi];
}

#pragma mark -
#pragma mark Private Methods

+ (NSArray *)creaturesWithCount:(NSUInteger)count {
    return [NSArray objectsWithCount:count block:^id{
        return [IDPCreature creature];
    }]; 
}

- (void)creaturesPerformGenderSpecificOperation {
    NSUInteger count = 10;
    
    NSArray *creatures = [IDPCreatureTest creaturesWithCount: count];
    
    for (IDPCreature *creature in creatures) {
        [creature performGenderSpecificOperation];
    }
}

- (void)creaturesSayHi {
    NSLog(@"--- All creatures are saying hi! ---");
    NSUInteger count = 10;
    
    NSArray *creatures = [IDPCreatureTest creaturesWithCount: count];
    
    [creatures performBlockWithEachObject:^(IDPCreature *creature) {
        [creature sayHi];
    }];
}

- (void)creaturesChildrendSayHi {
    NSLog(@"--- All children are saying hi! ---");
    
    NSUInteger count = 10;
    
    NSArray *creatures = [IDPCreatureTest creaturesWithCount: count];
    
    for (IDPCreature *creature in creatures) {
        [creature performGenderSpecificOperation];
    }
    
    [creatures performBlockWithEachObject:^(IDPCreature *creature) {
        [creature.children performBlockWithEachObject:^(IDPCreature *childCreature) {
            [childCreature sayHi];
        }];
    }];
}

@end
