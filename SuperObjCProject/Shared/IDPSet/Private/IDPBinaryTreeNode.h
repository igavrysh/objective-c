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

@interface IDPBinaryTreeNode : NSObject
@property (nonatomic, retain) id<IDPComparison> object;
@property (nonatomic, retain) IDPBinaryTreeNode *leftChild;
@property (nonatomic, retain) IDPBinaryTreeNode *rightChild;

+ (instancetype)nodeWithObject:(id<IDPComparison>)object
                         leftChild:(IDPBinaryTreeNode *)leftChild
                        rightChild:(IDPBinaryTreeNode *)rightChild;

@end
