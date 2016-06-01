//
//  IDPCarwash.h
//  SuperObjCProject
//
//  Created by Ievgen on 6/2/16.
//  Copyright © 2016 1mlndollarsasset. All rights reserved.
//

#import <Foundation/Foundation.h>

#include "IDPBuilding.h"

@interface IDPCarwash : NSObject
@property (nonatomic, nonatomic) IDPBuilding *productionBuilding;
@property (nonatomic, nonatomic) IDPBuilding *administrativeBuilding;

@property (nonatomic, retain) NSMutableArray *carsQueue;

- (NSArray *)operate;

- (void)addCarToQueue;

@end
