//
//  IDPCarwashRoom.h
//  SuperObjCProject
//
//  Created by Ievgen on 6/3/16.
//  Copyright © 2016 1mlndollarsasset. All rights reserved.
//

#import "IDPRoom.h"

#import "IDPCar.h"

@interface IDPCarwashRoom : IDPRoom
@property (nonatomic, copy, readonly) NSArray *cars;

- (id)init;

- (void)addCar:(IDPCar *)car;
- (void)removeCar:(IDPCar *)car;

@end
