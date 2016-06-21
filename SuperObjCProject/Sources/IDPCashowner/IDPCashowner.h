//
//  IDPCashOwner,h
//  SuperObjCProject
//
//  Created by Ievgen on 6/7/16.
//  Copyright © 2016 1mlndollarsasset. All rights reserved.
//

#import <Foundation/Foundation.h>


@class IDPCashGiver;

@protocol IDPCashTaker <NSObject>

- (void)cashGiver:(IDPCashGiver*)cashGiver didReceivedCash:(float)cash;

@optional
- (BOOL)cashGiverShouldReceiveCash:(IDPCashGiver *)cashGiver;

@end

@interface IDPCashGiver : NSObject
@property (nonatomic, assign) float cash;

@property (nonatomic, assign) id<IDPCashTaker> cashTaker;

@end



/*
@protocol IDPCashOwner <NSObject>

@property (nonatomic, readonly) float cash;

@optional
- (void)receiveCashFromCashOwner:(id<IDPCashOwner>)object;

- (void)receiveCash:(float)cash;

- (float)giveAllCash;

- (float)giveCash:(float)cash;

@end
 */



