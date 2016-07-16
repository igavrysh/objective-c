//
//  IDPObservableObject.h
//  Test
//
//  Created by Ievgen on 6/22/16.
//  Copyright © 2016 1mlndollarsasset. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IDPObservableObject : NSObject
@property (nonatomic, assign)   NSUInteger      state;
@property (nonatomic, readonly) NSSet           *observerSet;

- (void)addObservers:(NSArray *)observers;
- (void)addObserver:(id)observer;

- (void)removeAllObservers;
- (void)removeObservers:(NSArray *)observers;
- (void)removeObserver:(id)observer;

- (BOOL)isObservedByObject:(id)observer;

// This method is itended for subclassing
- (SEL)selectorForState:(NSUInteger)state;

@end
