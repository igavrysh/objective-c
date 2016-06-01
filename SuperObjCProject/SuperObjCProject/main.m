//
//  main.m
//  SuperObjCProject
//
//  Created by Ievgen on 6/1/16.
//  Copyright © 2016 1mlndollarsasset. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "IDPCreature.h"
#import "IDPFemaleCreature.h"
#import "IDPMaleCreature.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        
        uint64_t count = 10;
        
        NSMutableArray *creatures = [[NSMutableArray alloc] init];
        
        for (uint64_t index = 0; index < count; index++) {
            IDPCreature *creature = [IDPCreature creatureWithRandomNameAndGender];
            [creatures addObject:creature];
        }
        
        for (IDPCreature *creature in creatures) {
            [creature performGenderSpecificOperation];
        }
        
        NSLog(@"--- All creatures are saying hi! ---");
        [creatures enumerateObjectsUsingBlock:^(IDPCreature *creature, NSUInteger idx, BOOL *stop) {
            [creature sayHi];
        }];
        
        NSLog(@"--- All children are saying hi! ---");
        [creatures enumerateObjectsUsingBlock:^(IDPCreature *creature, NSUInteger idx, BOOL *stop) {
            [creature.children enumerateObjectsUsingBlock:^(IDPCreature *creature, NSUInteger idx, BOOL *stop) {
                [creature sayHi];
            }];
        }];
        
        [creatures release];
    }
    return 0;
}
