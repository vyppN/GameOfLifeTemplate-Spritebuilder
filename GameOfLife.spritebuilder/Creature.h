//
//  Creature.h
//  GameOfLife
//
//  Created by Chaowarit Ongkum on 3/3/2558 BE.
//  Copyright (c) 2558 Apportable. All rights reserved.
//

#import "CCSprite.h"

@interface Creature : CCSprite

@property (nonatomic, assign) BOOL isAlive;
@property (nonatomic, assign) NSInteger livingNeighbors;

-(id) initCreature;

@end
