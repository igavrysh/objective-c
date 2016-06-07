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
@property (nonatomic, assign, readonly, getter=isFilled) BOOL filled;
@property (nonatomic, assign)           IDPBuilding     *building;

+ (id)room;
+ (id)roomWithCapacity:(NSUInteger)capacity;

- (id)init;
- (id)initWithCapacity:(NSUInteger)capacity;

- (BOOL)addWorker:(IDPWorker *)worker;
- (void)removeWorker:(IDPWorker *)worker;

@end
