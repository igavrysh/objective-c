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
@property (nonatomic, retain) id<IDPComparison> object;
@property (nonatomic, assign) NSUInteger        key;
@property (nonatomic, retain) IDPBinaryTreeNode *leftChild;
@property (nonatomic, retain) IDPBinaryTreeNode *rightChild;

@end

@implementation IDPBinaryTreeNode

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


#pragma mark -
#pragma mark Public Methods
- (void)populateDataWithObject:(id<IDPComparison>)object {
    assert(kIDPBinaryTreeNodeDataCapacity - 1 > self.data.count);
    
    [self addObject:object];
}


@end
