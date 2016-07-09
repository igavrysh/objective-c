//
//  IDPFemaleCreature.m
//  SuperCProject
//
//  Created by Ievgen on 5/31/16.
//  Copyright © 2016 Ievgen Gavrysh. All rights reserved.
//
#import "IDPFemaleCreature.h"

#import "IDPRandom.h"

#import "NSString+IDPExtensions.h"
#import "NSString+IDPRandomName.h"

@interface IDPFemaleCreature ()

- (IDPCreature *)giveBirthToChildWithRandomName;

- (IDPCreature *)giveBirthToChildWithName:(NSString *)name;

@end

@implementation IDPFemaleCreature

#pragma mark -
#pragma mark Public Methods

- (void)performGenderSpecificOperation {
    [self giveBirthAndAddToChildren];
}

- (void)giveBirthAndAddToChildren {
    [self addChild:[self giveBirthToChildWithRandomName]];
}

#pragma mark -
#pragma mark Private Methods

- (IDPCreature *)giveBirthToChildWithRandomName {
    return [self giveBirthToChildWithName:[NSString randomName]];
}

- (IDPCreature *)giveBirthToChildWithName:(NSString *)name {
    IDPCreature *creature = [IDPCreature creature];
    
    creature.weight = IDPRandomFloatWithMinAndMaxValue(0.1, 4);
    creature.age = 0;
    creature.name = name;
    
    [self printMessage:[NSString stringWithFormat:@"I gave a birth to %@!!!", creature.name]];
    
    return creature;
}

@end
