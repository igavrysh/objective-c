//
//  IDPBinaryTreeNode.h
//  SuperObjCProject
//
//  Created by Ievgen on 6/16/16.
//  Copyright © 2016 1mlndollarsasset. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "IDPLinkedListSet.h"
#import "IDPComparison.h"

extern
const NSUInteger kIDPBinaryTreeNodeDataCapacity;

@interface IDPBinaryTreeNode : NSObject
@property (nonatomic, retain, readonly) IDPLinkedListSet    *data;
@property (nonatomic, retain, readonly) IDPBinaryTreeNode   *leftChild;
@property (nonatomic, retain, readonly) IDPBinaryTreeNode   *rightChild;
@property (nonatomic, readonly, getter=isFull) BOOL full;

- (void)addObject:(IDPComparisonId)object;

@end
