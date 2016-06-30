//
//  IDPQueue.m
//  SuperObjCProject
//
//  Created by Ievgen on 6/9/16.
//  Copyright © 2016 1mlndollarsasset. All rights reserved.
//

#import "IDPQueue.h"

#import "NSObject+IDPObject.h"

@interface IDPQueue ()
@property (nonatomic, retain) NSMutableArray  *objects;

- (void)dequeueAll;

@end

@implementation IDPQueue

@dynamic count;

#pragma mark -
#pragma mark Initializtions and Deallocations

- (void)dealloc {
    [self dequeueAll];
    self.objects = nil;
    
    [super dealloc];
}

- (id)init {
    self = [super init];
    self.objects = [NSMutableArray object];
    
    return self;
}

#pragma mark -
#pragma mark Accessors Methods

- (NSUInteger)count {
    return [self.objects count];
}

#pragma mark -
#pragma mark Public Methods

- (void)enqueue:(id)object {
    if (!object) {
        return;
    }
    
    [self.objects addObject:object];
}

- (id)dequeue {
    if (self.count == 0) {
        return nil;
    }
    
    id object = [[self.objects[0] retain] autorelease];
    [self.objects removeObjectAtIndex:0];
    
    return object;
}

- (void)dequeueAll {
    while ([self count]) {
        [self dequeue];
    }
}

@end
