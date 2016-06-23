//
//  IDPCashOwner,h
//  SuperObjCProject
//
//  Created by Ievgen on 6/7/16.
//  Copyright © 2016 1mlndollarsasset. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol IDPCashOwner;

@protocol IDPWorkerDelegate <NSObject>

- (void)didFinishProcessingObject:(id<IDPCashOwner>)cashOwner;

@optional
- (BOOL)cashOwnerShouldProcessObject:(id<IDPCashOwner>)cashOwner;

@end

@protocol IDPCashOwner <NSObject>
@property (nonatomic, readonly) float cash;
@property (nonatomic, assign) id<IDPWorkerDelegate> workerDelegate;

@optional
- (void)receiveCashFromCashOwner:(id<IDPCashOwner>)object;

- (void)receiveCash:(float)cash;

- (float)giveAllCash;

- (float)giveCash:(float)cash;

@end
