//
//  IDPLinkedListNode.h
//  SuperObjCProject
//
//  Created by Ievgen on 6/15/16.
//  Copyright © 2016 1mlndollarsasset. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol IDPComparison;

@interface IDPLinkedListNode : NSObject
@property (nonatomic, retain) IDPLinkedListNode     *nextNode;
@property (nonatomic, assign) IDPLinkedListNode     *previousNode;
@property (nonatomic, retain) id<IDPComparison>     object;

+ (instancetype)nodeWithObject:(id<IDPComparison>)object
                      nextNode:(IDPLinkedListNode *)nextNode
                  previousNode:(IDPLinkedListNode *)previousNode;

@end
