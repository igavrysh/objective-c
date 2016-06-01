//
//  IDPFemaleCreature.m
//  SuperCProject
//
//  Created by Ievgen on 5/31/16.
//  Copyright © 2016 Ievgen Gavrysh. All rights reserved.
//
#import "IDPFemaleCreature.h"

#import "IDPRandom.h"
#import "NSString+IDPCreature.h"

@interface IDPFemaleCreature ()

- (IDPCreature *)giveBithToChildWithRandomName;

- (IDPCreature *)giveBithToChildWithName:(NSString *)name;

@end

@implementation IDPFemaleCreature

#pragma mark -
#pragma mark Public Methods

- (void)performGenderSpecificOperation {
    [self giveBirthAndAddToChildren];
}

- (void)giveBirthAndAddToChildren {
    [self addChild:[self giveBithToChildWithRandomName]];
}

#pragma mark -
#pragma mark Private Methods

- (IDPCreature *)giveBithToChildWithRandomName {
    return [self giveBithToChildWithName:[NSString randomName]];
}

- (IDPCreature *)giveBithToChildWithName:(NSString *)name {
    IDPCreature *creature = [IDPCreature creatureWithRandomNameAndGender];
    
    creature.weight = [IDPRandom positiveFloatFrom:0.1 to:4];
    creature.age = 0;
    creature.name = name;
    
    [self printMessage:[NSString stringWithFormat:@"I gave a birth to %@!!!", creature.name]];
    
    return creature;
}



@end
