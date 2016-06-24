//
//  IDPObservableObject.m
//  Test
//
//  Created by Ievgen on 6/22/16.
//  Copyright © 2016 1mlndollarsasset. All rights reserved.
//

#import "IDPObservableObject.h"

@interface IDPObservableObject ()
@property (nonatomic, retain) NSMutableSet *mutableObserverSet;

@end

@implementation IDPObservableObject

@dynamic observerSet;

#pragma mark - 
#pragma mark Initializations and Deallocations

- (void)dealloc {
    self.mutableObserverSet = nil;
    
    [super dealloc];
}

- (instancetype)init {
    self = [super init];
    if (self) {
        self.mutableObserverSet = [NSMutableSet set];
    }
    
    return self;
}

#pragma mark -
#pragma mark Accessors

- (NSSet *)observerSet {
    return [[self.mutableObserverSet copy] autorelease];
}

- (void)setState:(NSUInteger)state {
    if (state != _state) {
        _state = state;
        
        [self notifyOfStateChangewithSelector:[self selectorForState:state]];
    }
}

#pragma mark - 
#pragma mark Public

- (void)addObserver:(id)observer {
    [self.mutableObserverSet addObject:observer];
}

- (void)removeObserver:(id)observer {
    [self.mutableObserverSet removeObject:observer];
}

- (BOOL)isObservedByObject:(id)observer {
    return [self.mutableObserverSet containsObject:observer];
}

#pragma mark -
#pragma mark Private

- (SEL)selectorForState:(NSUInteger)state {
    [self doesNotRecognizeSelector:_cmd];
    
    return NULL;
}

- (void)notifyOfStateChangewithSelector:(SEL)selector {
    NSMutableSet *observerSet = self.mutableObserverSet;
    for (id observer in observerSet) {
        if ([observer respondsToSelector:selector]) {
            [observer performSelector:selector withObject:self];
        }
    }
}

@end
