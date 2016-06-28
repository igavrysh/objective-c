//
//  IDPReference.m
//  Test
//
//  Created by Ievgen on 6/24/16.
//  Copyright © 2016 1mlndollarsasset. All rights reserved.
//

#import "IDPReference.h"

@interface IDPReference ()
@property (nonatomic, assign) id target;

@end

@implementation IDPReference

@dynamic target;

#pragma mark -
#pragma mark Class methods

+ (instancetype)referenceWithTarget:(id)target {
    return [[[self alloc] initWithTarget:target] autorelease];
}

#pragma mark -
#pragma mark Initializations and Deallocations

- (void)dealloc {
    self.target = nil;
    
    [super dealloc];
}

- (instancetype)initWithTarget:(id)target {
    self = [super init];
    if (self) {
        self.target = target;
    }
    
    return self;
}

#pragma mark - 
#pragma mark Public Methods

- (NSUInteger)hash {
    return (NSUInteger)self.target ^ (NSUInteger)[self class];
}

- (BOOL)isEqual:(id)object {
    if (self == object) {
        return  YES;
    }
    
    if (!object || ![object isMemberOfClass:[self class]]) {
        return NO;
    }
    
    return [self isEqualToRefence:object];
}

- (BOOL)isEqualToRefence:(IDPReference *)reference {
    return reference.target == self.target;
}

#pragma mark -
#pragma mark NSCopying

- (id)copyWithZone:(NSZone *)zone {
    return [[[self class] alloc] initWithTarget:self.target];
}

@end
