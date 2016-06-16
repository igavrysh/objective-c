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


#pragma mark -
#pragma mark Accessor Properties

- (BOOL)isFull {
    return self.data.count == kIDPBinaryTreeNodeDataCapacity;
}

#pragma mark -
#pragma mark Public Methods
- (void)addObject:(IDPComparisonId)object {
    assert(kIDPBinaryTreeNodeDataCapacity - 1 > self.data.count);
    
    [self.data addObject:object];
}

@end
