//
//  IDPGCDObject.m
//  Test
//
//  Created by Oleksa Korin on 6/3/15.
//  Copyright (c) 2015 Oleksa Korin. All rights reserved.
//

#import "IDPGCDQueue.h"

@interface IDPGCDQueue ()
@property (nonatomic, retain)   dispatch_queue_t    queue;

@end

@implementation IDPGCDQueue

#pragma mark - 
#pragma mark Public Methods

+ (instancetype)gcdSerialQueueWithName:(NSString *)name {
    return [[self alloc] initSerialWithName:name];
}

+ (instancetype)gcdConcurrentQueueWithName:(NSString *)name {
    return [[self alloc] initComcurrentWithName:name];
}

#pragma mark -
#pragma mark Initializations and Deallocations

- (void)dealloc {
    self.queue = NULL;
    
    [super dealloc];
}

- (instancetype)initSerialWithName:(NSString *)name {
    return [self initWithName:name attribute:DISPATCH_QUEUE_SERIAL];
}

- (instancetype)initComcurrentWithName:(NSString *)name {
    return [self initWithName:name attribute:DISPATCH_QUEUE_CONCURRENT];
}

- (instancetype)initWithName:(NSString *)name attribute:(dispatch_queue_attr_t)attribute {
    self = [super init];
    
    self.queue = dispatch_queue_create([name cStringUsingEncoding:NSUTF8StringEncoding],
                                       attribute);
    
    return self;
}


#pragma mark -
#pragma mark Public Methods

- (void)executeWithBlock:(IDPGCDQueueBlock)block {
    [self executeWithBlock:block finishBlock:nil];
}

- (void)executeWithBlock:(IDPGCDQueueBlock)block
             finishBlock:(IDPGCDQueueBlock)finishBlock
{
    dispatch_async(self.queue, ^{
        if (block) {
            block();
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            if (finishBlock) {
                finishBlock();
            }
        });
    });
}

@end
