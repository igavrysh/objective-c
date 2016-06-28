//
//  IDPCashOwner,h
//  SuperObjCProject
//
//  Created by Ievgen on 6/7/16.
//  Copyright © 2016 1mlndollarsasset. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol IDPCashOwner <NSObject>
@property (nonatomic, readonly) float cash;

@optional
- (void)receiveCashFromCashOwner:(id<IDPCashOwner>)object;
- (void)receiveCash:(float)cash;
- (float)giveAllCash;
- (float)giveCash:(float)cash;

@end
