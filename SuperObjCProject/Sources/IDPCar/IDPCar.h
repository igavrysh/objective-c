//
//  IDPCar.h
//  SuperObjCProject
//
//  Created by Student 104 on 6/1/16.
//  Copyright (c) 2016 1mlndollarsasset. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IDPCar : NSObject
@property (nonatomic, assign)                   float   cash;
@property (nonatomic, assign, getter = isDirty) BOOL    dirty;

- (id)init;

- (float)payForServiceWithPrice:(float)price;

@end
