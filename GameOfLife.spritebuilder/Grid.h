//
//  Grid.h
//  GameOfLife
//
//  Created by Chaowarit Ongkum on 3/2/2558 BE.
//  Copyright (c) 2558 Apportable. All rights reserved.
//

#import "CCSprite.h"

@interface Grid : CCSprite

@property (nonatomic,assign) BOOL isAlive;
@property (nonatomic,assign) NSInteger livingNeighbors;

@property (nonatomic,assign) int totalAlive;
@property (nonatomic,assign) int generation;

-(id)initCreature;

@end
