//
//  IDPCarwasher.m
//  SuperObjCProject
//
//  Created by Ievgen on 6/2/16.
//  Copyright © 2016 1mlndollarsasset. All rights reserved.
//

#import "IDPCarwasher.h"

@implementation IDPCarwasher

- (id)init {
    self = [super init];
    if (self) {
    }
    
    return self;
}

- (void)cleanCar:(IDPCar *)car {
    car.dirty = NO;
}

@end
