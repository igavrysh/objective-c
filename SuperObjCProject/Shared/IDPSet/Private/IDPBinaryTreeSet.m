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

@end

@implementation IDPBinaryTreeSet

- (instancetype)init
{
    self = [super init];
    self.root = [IDPBinaryTreeNode object];
    
    return self;
}

#pragma mark -
#pragma mark Public Methods

- (void)addObject:(id<IDPComparison>)object {
  [self.root addObject:object];
}

#pragma mark -
#pragma mark Private Methods


@end
