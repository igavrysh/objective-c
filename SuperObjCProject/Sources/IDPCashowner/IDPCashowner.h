//
//  IDPCashOwner,h
//  SuperObjCProject
//
//  Created by Ievgen on 6/7/16.
//  Copyright © 2016 1mlndollarsasset. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol IDPCashOwner <NSObject>
@property (nonatomic, assign) float cash;

@optional
- (void)receiveCash:(id<IDPCashOwner>)object;

@optional
- (float)giveAllCash;

@optional
- (float)giveCash:(float)cash;

@end
