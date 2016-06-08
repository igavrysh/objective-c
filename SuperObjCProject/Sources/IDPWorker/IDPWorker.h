//
//  IDPWorker.h
//  SuperObjCProject
//
//  Created by Student 104 on 6/1/16.
//  Copyright (c) 2016 1mlndollarsasset. All rights reserved.
//

#import "IDPCreature.h"

#import "IDPCashowner.h"

@interface IDPWorker : IDPCreature <IDPCashowner>
@property (nonatomic, assign) float salary;
@property (nonatomic, assign) float capital;
@property (nonatomic, assign) NSUInteger experience;

- (id)init;

- (void)processObject:(id<IDPCashowner>) object;

@end
