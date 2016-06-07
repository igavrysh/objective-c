//
//  IDPCashOperating.h
//  SuperObjCProject
//
//  Created by Ievgen on 6/7/16.
//  Copyright © 2016 1mlndollarsasset. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol IDPCashOperating <NSObject>
@property (nonatomic, assign) float cash;

- (void)receiveCashFromCashOperatingObject:(id<IDPCashOperating>)object;
- (float)giveAllCash;

@end
