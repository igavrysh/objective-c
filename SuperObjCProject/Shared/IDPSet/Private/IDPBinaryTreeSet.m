//
//  IDPBinaryTreeSet.m
//  SuperObjCProject
//
//  Created by Ievgen on 6/15/16.
//  Copyright © 2016 1mlndollarsasset. All rights reserved.
//

#import "IDPBinaryTreeSet.h"

#import "IDPBinaryTreeNode.h"

#import "NSObject+IDPObject.h"

@interface IDPBinaryTreeSet ()
@property (nonatomic, retain) IDPBinaryTreeNode *root;

- (void)addObject:(id<IDPComparison>)object;

- (IDPBinaryTreeNode *)nodeWithObject:(id<IDPComparison>)object inNode:(IDPBinaryTreeNode *)node;

@end

@implementation IDPBinaryTreeSet

#pragma mark -
#pragma mark Initializations and Deallocations

- (instancetype)init
{
    self = [super init];
    self.root = [IDPBinaryTreeNode object];
    
    return self;
}

#pragma mark -
#pragma mark Public Methods

- (void)addObject:(id<IDPComparison>)object {
    self.root = [self nodeWithObject:object inNode:self.root];
}


- (IDPBinaryTreeNode *)nodeWithObject:(id<IDPComparison>)object inNode:(IDPBinaryTreeNode *)node {
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
- (IDPBinaryTreeNode *)addObject:(id<IDPComparison>)object {
    
    
}

#pragma mark -
#pragma mark Private Methods


@end
