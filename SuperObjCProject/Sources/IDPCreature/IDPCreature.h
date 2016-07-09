//
//  IDPCreature.h
//  SuperCProject
//
//  Created by Ievgen on 5/29/16.
//  Copyright © 2016 Ievgen Gavrysh. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef uint8_t IDPAge;

@interface IDPCreature : NSObject
@property (nonatomic, copy)             NSString    *name;
@property (nonatomic, assign)           float       weight;
@property (nonatomic, assign)           IDPAge      age;
@property (nonatomic, copy, readonly)   NSArray     *children;

+ (id)creature;

- (id)initWithName:(NSString *)name weight:(float)weight age:(IDPAge)age;

- (void)sayHi;
- (void)printMessage:(NSString *)message;

- (void)performGenderSpecificOperation;

- (void)addChild:(IDPCreature *)child;
- (void)removeChild:(IDPCreature *)child;

@end
