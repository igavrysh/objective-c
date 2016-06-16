//
//  IDPSet.m
//  SuperObjCProject
//
//  Created by Ievgen on 6/15/16.
//  Copyright © 2016 1mlndollarsasset. All rights reserved.
//

#import "IDPSet.h"

#import "IDPLinkedListSet.h"

@implementation IDPSet

#pragma mark -
#pragma mark Class methods

+ (instancetype)setWithSet:(NSSet *)set {
    return [[[IDPLinkedListSet alloc] initWithSet:set] autorelease];
}

#pragma mark -
#pragma mark Initializations and Deallocations

- (instancetype)initWithSet:(NSSet *)set {
    [self release];
    
    return [[IDPLinkedListSet alloc] initWithSet:set];
}

#pragma mark -
#pragma mark Public Methods

- (NSUInteger)count {
    [self doesNotRecognizeSelector:_cmd];
    
    return 0;
}

- (NSString *)stringAtIndex:(NSUInteger)index {
    [self doesNotRecognizeSelector:_cmd];
    
    return nil;
}

- (NSString *)objectAtIndexedSubscript:(NSUInteger)index {
    return nil; //[self stringAtIndex:index];
}

- (NSString *)string {
    /*NSMutableString *string = [NSMutableString stringWithCapacity:[self count]];
    for (NSString *symbol in self) {
        [string appendString:symbol];
    }
    
    return [[string copy] autorelease];
     */
    return nil;
}

- (NSUInteger)countByEnumeratingWithState:(NSFastEnumerationState *)state
                                  objects:(id *)stackbuf
                                    count:(NSUInteger)resultLength
{
    [self doesNotRecognizeSelector:_cmd];
    
    return 0;
}

@end
