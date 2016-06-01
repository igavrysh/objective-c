//
//  IDPCreature.h
//  SuperCProject
//
//  Created by Ievgen on 5/29/16.
//  Copyright © 2016 Ievgen Gavrysh. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IDPCreature : NSObject
@property (nonatomic, copy)             NSString    *name;
@property (nonatomic, assign)           float       weight;
@property (nonatomic, assign)           UInt8       age;
@property (nonatomic, copy, readonly)   NSArray *children;

+ (id)creature;

- (id)init;
- (id)initWithRandomAttributes;
- (id)initWithName:(NSString *)name weight:(float)weight age:(uint8_t)age;

- (void)sayHi;
- (void)printMessage:(NSString *)message;

- (void)performGenderSpecificOperation;

- (void)addChild:(IDPCreature *)child;
- (void)removeChild:(IDPCreature *)child;

@end
