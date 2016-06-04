//
//  IDPCarwasher.h
//  SuperObjCProject
//
//  Created by Ievgen on 6/2/16.
//  Copyright © 2016 1mlndollarsasset. All rights reserved.
//

#import "IDPWorker.h"

#import "IDPCar.h"

@interface IDPCarwasher : IDPWorker
@property (nonatomic, assign) float cash;

- (id)init;

- (void)cleanCar:(IDPCar *)car forPrice:(float) price;

@end