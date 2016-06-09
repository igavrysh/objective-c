//
//  IDPRoom.h
//  SuperObjCProject
//
//  Created by Student 104 on 6/1/16.
//  Copyright (c) 2016 1mlndollarsasset. All rights reserved.
//

#import <Foundation/Foundation.h>

@class IDPWorker;
@class IDPBuilding;

@interface IDPRoom : NSObject
@property (nonatomic, copy, readonly)   NSArray         *workers;
@property (nonatomic, readonly)         NSUInteger      workersCount;
@property (nonatomic, assign)           IDPBuilding     *building;
@property (nonatomic, readonly, getter=isFull) BOOL full;

+ (id)room;
+ (id)roomWithCapacity:(NSUInteger)capacity;

- (id)initWithCapacity:(NSUInteger)capacity;

- (BOOL)addWorker:(IDPWorker *)worker;
- (void)removeWorker:(IDPWorker *)worker;

@end
