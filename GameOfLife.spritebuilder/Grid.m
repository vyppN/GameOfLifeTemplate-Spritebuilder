//
//  Grid.m
//  GameOfLife
//
//  Created by Chaowarit Ongkum on 3/2/2558 BE.
//  Copyright (c) 2558 Apportable. All rights reserved.
//

#import "Grid.h"

@implementation Grid

-(instancetype) initCreature{
    self = [super initWithImageNamed:@"GameOfLifeAssets/Assets/bubble.png"];
    if (self) {
        self.isAlive = NO;
    }
    return self;
}

-(void)setIsAlive:(BOOL)newState{
    _isAlive = newState;
    
    self.visible = _isAlive;
}

@end
