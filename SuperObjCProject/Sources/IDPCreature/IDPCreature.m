//
//  IDPCreature.m
//  SuperCProject
//
//  Created by Ievgen on 5/29/16.
//  Copyright © 2016 Ievgen Gavrysh. All rights reserved.
//

#import "IDPCreature.h"

#import "IDPRandom.h"
#import "NSString+IDPName.h"

@interface IDPCreature ()

@property (nonatomic, retain) NSMutableArray *mutableChildren;

@end

@implementation IDPCreature

@dynamic children;

#pragma mark -
#pragma mark Class Methods

+ (id)creature {
    return [[[self alloc] init] autorelease];
}

@class IDPMaleCreature;
@class IDPFemaleCreature;

+ (id)creatureWithRandomNameAndGender {
    Class creatureClass  = [IDPRandom uint8LimitedTo:2] ? [IDPMaleCreature class] : [IDPFemaleCreature class];
    
    IDPCreature *creature = [[[creatureClass alloc] init] autorelease];
    
    creature.name = [NSString randomName];
    
    return creature;
}

#pragma mark -
#pragma mark Initializtions and Deallocations

- (void)dealloc {
    self.name  = nil;
    self.mutableChildren = nil;
    
    [super dealloc];
}

- (id)init {
    return [self initWithName:nil weight:0 age:0];
}

- (id)initWithRandomAttributes {
    return [self initWithName:[NSString randomName]
                       weight:[IDPRandom positiveFloatFrom:0.1 to:200]
                          age:[IDPRandom uint8LimitedTo:122]];
}

- (id)initWithName:(NSString *)name weight:(float)weight age:(UInt8)age
{
    self = [super init];
    if (self) {
        self.name = name;
        self.weight = weight;
        self.age = age;
        self.mutableChildren = [[[NSMutableArray alloc] init] autorelease];
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

- (void)performGenderSpecificOperation {
}

- (void)addChild:(IDPCreature *)child {
    [self.mutableChildren addObject:child];
}

- (void)removeChild:(IDPCreature *)child {
    [self.mutableChildren removeObject:child];
}

#pragma mark -
#pragma mark Private Methods

- (void)printMessage:(NSString *)message {
    NSLog(@"Creature %@(%@) says - %@!", self.name, self, message);
}

@end
