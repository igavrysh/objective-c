//
//  IDPCreature.m
//  SuperCProject
//
//  Created by Ievgen on 5/29/16.
//  Copyright © 2016 Ievgen Gavrysh. All rights reserved.
//

#import "IDPCreature.h"
#import "IDPFemaleCreature.h"
#import "IDPMaleCreature.h"
#import "IDPRandom.h"
#import "NSString+IDPName.h"
#import "NSObject+IDPObject.h"

@interface IDPCreature ()
@property (nonatomic, retain) NSMutableArray *mutableChildren;

@end

@implementation IDPCreature

@dynamic children;

#pragma mark -
#pragma mark Class Methods

+ (id)creature {
    Class creatureClass  = IDPRandomUIntWithMaxValue(1) ? [IDPMaleCreature class] : [IDPFemaleCreature class];
    
    IDPCreature *creature = [creatureClass object];
    
    creature.name = [NSString randomName];
    
    return creature;
}

#pragma mark -
#pragma mark Initializtions and Deallocations

- (void)dealloc {
    self.name = nil;
    self.mutableChildren = nil;
    
    [super dealloc];
}

- (id)init {
    return [self initWithName:nil weight:0 age:0];
}

- (id)initWithRandomAttributes {
    return [self initWithName:[NSString randomName]
                       weight:IDPRandomFloatWithMinAndMaxValue(0.1, 200)
                          age:IDPRandomUIntWithMaxValue(122)];
}

- (id)initWithName:(NSString *)name weight:(float)weight age:(UInt8)age {
    self = [super init];
    if (self) {
        self.name = name;
        self.weight = weight;
        self.age = age;
        self.mutableChildren = [NSMutableArray object];
    }
    
    return self;
}

#pragma mark -
#pragma mark Accessors Methods

- (NSArray *)children {
    return [[self.mutableChildren copy] autorelease];
}

#pragma mark -
#pragma mark Public Methods

- (void)sayHi {
    [self printMessage:@"Hi"];
    
    [self.mutableChildren enumerateObjectsUsingBlock:^(IDPCreature *creature, NSUInteger idx, BOOL *stop) {
        [creature sayHi];
    }];
}

- (void)printMessage:(NSString *)message {
    NSLog(@"Creature %@(%@) says - %@!", self.name, self, message);
}

- (void)performGenderSpecificOperation {
}

- (void)addChild:(IDPCreature *)child {
    NSMutableArray *children = self.mutableChildren;
    if (![children containsObject:child]) {
        [children addObject:child];
    }
}

- (void)removeChild:(IDPCreature *)child {
    [self.mutableChildren removeObject:child];
}

@end
