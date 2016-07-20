//
//  NSTimer+IDPExtensions.m
//  SuperObjCProject
//
//  Created by Ievgen on 7/19/16.
//  Copyright © 2016 1mlndollarsasset. All rights reserved.
//

// Although NSTimer retains its target, still I am using associated objects
// functionality to test class extension with categories, storing internal variables
// for cases when there is no such class usage, which retains target

#import <objc/runtime.h>

#import "NSTimer+IDPExtensions.h"

NSString * const kIDPTimerHelper = @"kIDPTimerHelper";

typedef void(^IDPDeallocMethod)(id object, SEL selector);

@interface NSTimer (IDPPrivateExtensions)
@property (nonatomic, retain) IDPTimerHelper *helper;

@end

@implementation NSTimer (IDPPrivateExtensions)

#pragma mark -
#pragma mark Class methods

+ (void)load {
    SEL selector = @selector(dealloc);
    
    IMP deallocImp = [self methodForSelector:selector];
    
    id blockImp = imp_implementationWithBlock(^(NSTimer *timer) {
        timer.helper = nil;
        
        deallocImp(timer, selector);
    } );
    
    class_replaceMethod(self,
                        selector,
                        blockImp,
                        method_getTypeEncoding(class_getInstanceMethod([NSTimer class], @selector(dealloc))));
}

+ (instancetype)scheduledTimerWithTimeInterval:(NSTimeInterval)delay
                                         block:(IDPTimerExecutionBlock)block
{
    IDPTimerHelper *helper = [[[IDPTimerHelper alloc] initWithBlock:block] autorelease];
    
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:delay
                                            target:helper
                                          selector:@selector(onTimer:)
                                          userInfo:nil
                                           repeats:YES];
    
    timer.helper = helper;
    
    return timer;
}

#pragma mark -
#pragma mark Accessors

- (void)setHelper:(IDPTimerHelper *)helper {
    objc_setAssociatedObject(self, kIDPTimerHelper, helper, OBJC_ASSOCIATION_RETAIN);
}

- (IDPTimerHelper *)helper {
    return objc_getAssociatedObject(self, kIDPTimerHelper);
}

@end
