//
//  IDPWorker.h
//  SuperObjCProject
//
//  Created by Student 104 on 6/1/16.
//  Copyright (c) 2016 1mlndollarsasset. All rights reserved.
//

#import "IDPCreature.h"

#import "IDPCashOperating.h"

@interface IDPWorker : IDPCreature <IDPCashOperating>
@property (nonatomic, assign) float salary;
@property (nonatomic, assign) float capital;
@property (nonatomic, assign) NSUInteger experience;

- (id)init;
- (id)initWithSalaray:(float)salary capital:(float)capital experience:(NSUInteger)experience;

- (void)doJob;
- (void)processObject:(id<IDPCashOperating>) object;

@end
