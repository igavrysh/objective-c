//
//  IDPBinaryTreeNode.m
//  SuperObjCProject
//
//  Created by Ievgen on 6/16/16.
//  Copyright © 2016 1mlndollarsasset. All rights reserved.
//

#import "IDPBinaryTreeNode.h"

#import "NSObject+IDPObject.h"

@interface IDPBinaryTreeNode ()

@end

@implementation IDPBinaryTreeNode

#pragma mark -
#pragma mark Class methods

+ (instancetype)nodeWithObject:(id<IDPComparison>)object
                         leftChild:(IDPBinaryTreeNode *)leftChild
                        rightChild:(IDPBinaryTreeNode *)rightChild {
    IDPBinaryTreeNode *node = [IDPBinaryTreeNode object];
    node.object = object;
    node.leftChild = leftChild;
    node.rightChild = rightChild;
    
    return node;
}

#pragma mark -
#pragma mark Initializations and Deallocations

#pragma mark -
#pragma mark Accessor Properties


#pragma mark -
#pragma mark Public Methods



@end
