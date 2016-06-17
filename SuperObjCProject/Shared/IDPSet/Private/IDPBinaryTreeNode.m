//
//  IDPBinaryTreeNode.m
//  SuperObjCProject
//
//  Created by Ievgen on 6/16/16.
//  Copyright © 2016 1mlndollarsasset. All rights reserved.
//

#import "IDPBinaryTreeNode.h"

const NSUInteger kIDPBinaryTreeNodeDataCapacity = 5;

@interface IDPBinaryTreeNode ()
@property (nonatomic, retain) IDPLinkedListSet  *data;
@property (nonatomic, retain) IDPBinaryTreeNode *leftChild;
@property (nonatomic, retain) IDPBinaryTreeNode *rightChild;

@end

@implementation IDPBinaryTreeNode

@dynamic full;

#pragma mark - Initializations and Deallocations
#pragma mark

- (instancetype)initWithObject:(id<IDPComparison>)object
{
    self = [super init];
    if (self) {
        [self addObject:object];
    }
    return self;
}

#pragma mark -
#pragma mark Accessor Properties

- (BOOL)isFull {
    return self.data.count == kIDPBinaryTreeNodeDataCapacity;
}

#pragma mark -
#pragma mark Public Methods
- (void)populateDataWithObject:(id<IDPComparison>)object {
    assert(kIDPBinaryTreeNodeDataCapacity - 1 > self.data.count);
    
    [self addObject:object];
}

- (IDPBinaryTreeNode *)addObject:(id<IDPComparison>)object {
   
    /*
    if (!self.isFull) {
        [self populateDataWithObject:object];
    } else if () {
        return nil;
    }
    
    if (!*node) {
        *node = [[[IDPBinaryTreeNode alloc] initWithObject:object] autorelease];
    } else if (![*node isFull]) {
        [*node addObject:object];
    } else if (![*node.leftChild isFull]) {
        [self addObject: object node:&node.leftChild];
    } else {
        [self addObject: object node:&node.rightChild];
    }
     */
    
    return nil;
}

@end
