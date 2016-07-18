//
//  IDPGCDObject.h
//  Test
//
//  Created by Oleksa Korin on 6/3/15.
//  Copyright (c) 2015 Oleksa Korin. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef  void (^IDPGCDQueueBlock)(void);

@interface IDPGCDQueue : NSObject

- (instancetype)initSerialWithName:(NSString *)name;
- (instancetype)initComcurrentWithName:(NSString *)name;
- (instancetype)initWithName:(NSString *)name attribute:(dispatch_queue_attr_t)attribute;

- (void)executeWithBlock:(IDPGCDQueueBlock)block;
- (void)executeWithBlock:(IDPGCDQueueBlock)block
             finishBlock:(IDPGCDQueueBlock)finishBlock;

@end
