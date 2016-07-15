//
//  IDPCarwashDispatcher.h
//  SuperObjCProject
//
//  Created by Ievgen on 7/13/16.
//  Copyright © 2016 1mlndollarsasset. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IDPCarwashDispatcher : NSObject
@property (nonatomic, readonly, getter=isRunning)   BOOL    running;

- (void)start;
- (void)stop;

@end
