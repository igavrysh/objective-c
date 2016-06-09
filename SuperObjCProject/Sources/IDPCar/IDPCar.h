//
//  IDPCar.h
//  SuperObjCProject
//
//  Created by Student 104 on 6/1/16.
//  Copyright (c) 2016 1mlndollarsasset. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "IDPCashOwner.h"

@interface IDPCar : NSObject <IDPCashOwner>
@property (nonatomic, assign, getter = isDirty) BOOL dirty;

@end
