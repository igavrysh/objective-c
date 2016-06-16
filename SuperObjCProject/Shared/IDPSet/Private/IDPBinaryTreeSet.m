//
//  IDPBinaryTreeSet.m
//  SuperObjCProject
//
//  Created by Ievgen on 6/15/16.
//  Copyright © 2016 1mlndollarsasset. All rights reserved.
//

#import "IDPBinaryTreeSet.h"

#import "IDPBinaryTreeNode.h"

@interface IDPBinaryTreeSet ()
@property (nonatomic, retain) IDPBinaryTreeNode *root;

- (void)addObject:(IDPComparisonId)object;
- (void)addObject:(IDPComparisonId)object;
@end

@implementation IDPBinaryTreeSet

#pragma mark -
#pragma mark Public Methods

- (void)addObject:(IDPComparisonId)object {
  [self addObject:object node:&self.root];
}

#pragma mark -
#pragma mark Private Methods

- (void)addObject:(IDPComparisonId)object node:(IDPBinaryTreeNode **)node {
  if (!*node) {
    *node = [[[IDPBinaryTreeNode alloc] initWithObject:object] autorelease];
  } else if (![*node isFull]){
    [*node addObject:object];
  } else if (![*node.leftChild isFull]) {
    [self addObject: object node:&node.leftChild];
  } else {
    [self addObject: object node:&node.rightChild];
  }
}


@end
