//
//  IDPDynamicSet.m
//  SuperObjCProject
//
//  Created by Ievgen on 6/20/16.
//  Copyright © 2016 1mlndollarsasset. All rights reserved.
//

#import "IDPDynamicSet.h"

@implementation IDPDynamicSet

#pragma mark - 
#pragma mark Class Methods

+ (id)linkedListSetWithSet:(NSSet *)set {
    return [IDPSet linkedListSetWithSet:set];
}

+ (id)binaryTreeSetWithSet:(NSSet *)set {
    return [IDPSet binaryTreeSetWithSet:set];
}

#pragma mark -
#pragma mark Public Methods

- (instancetype)initLinkedListSetWithSet:(NSSet *)set {
    return [super initLinkedListSetWithSet:set];
}

- (instancetype)initBinrayTreeSetWithSet:(NSSet *)set {
    return [super initBinrayTreeSetWithSet:set];
}

- (id)objectAtIndexedSubscript:(NSUInteger)index {
    NSUInteger squeredIndex = (NSUInteger)pow(index, 2.0);
    
    if ([self count] <= squeredIndex) {
        return nil;
    }
    
    return [super objectAtIndex:squeredIndex];
}

@end
