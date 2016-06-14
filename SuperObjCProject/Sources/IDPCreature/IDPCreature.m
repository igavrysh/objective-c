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

#import "NSString+IDPExtensions.h"
#import "NSString+IDPRandomName.h"
#import "NSObject+IDPObject.h"
#import "NSArray+IDPArrayEnumerator.h"

@interface IDPCreature ()
@property (nonatomic, retain) NSMutableArray *mutableChildren;

@end

@implementation IDPCreature

@dynamic children;

#pragma mark -
#pragma mark Class Methods

+ (id)creature {    
    return IDPRandomBool() ? [IDPMaleCreature object] : [IDPFemaleCreature object];
}

#pragma mark -
#pragma mark Initializtions and Deallocations

- (void)dealloc {
    self.name = nil;
    self.mutableChildren = nil;
    
    [super dealloc];
}

- (id)init {
    return [self initWithName:[NSString randomName]
                       weight:IDPRandomFloatWithMinAndMaxValue(0.1, 200)
                          age:IDPRandomUIntWithMaxValue(122)];
}

- (id)initWithName:(NSString *)name weight:(float)weight age:(IDPAge)age {
    self = [super init];
    
    self.name = name;
    self.weight = weight;
    self.age = age;
    self.mutableChildren = [NSMutableArray object];
    
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
    
    [self.mutableChildren performBlockWithEachObject:^(IDPCreature *creature) {
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
