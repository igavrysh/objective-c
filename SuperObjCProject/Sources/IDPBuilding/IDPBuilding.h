//
//  IDPBuilding.h
//  SuperObjCProject
//
//  Created by Ievgen on 6/1/16.
//  Copyright © 2016 1mlndollarsasset. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "IDPAccountant.h"
#import "IDPDirector.h"
#import "IDPRoom.h"

@interface IDPBuilding : NSObject

- (void)addRoom:(IDPRoom *)room;
- (void)removeRoom:(IDPRoom *)room;

- (IDPAccountant *)findAccountant;
- (IDPDirector *)findDirector;

@end
