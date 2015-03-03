//
//  Grid.m
//  GameOfLife
//
//  Created by Chaowarit Ongkum on 3/3/2558 BE.
//  Copyright (c) 2558 Apportable. All rights reserved.
//

#import "Grid.h"
#import "Creature.h"

static const int GRID_ROWS = 8;
static const int GRID_COLS = 10;

@implementation Grid{
    NSMutableArray *_gridArray;
    float _cellWidth;
    float _cellHeight;
}

-(void)onEnter{
    [super onEnter];
    [self setupGrid];
    
    self.userInteractionEnabled = YES;
}

-(void)setupGrid{
    _cellWidth = self.contentSize.width / GRID_COLS;
    _cellHeight = self.contentSize.height/GRID_ROWS;
    
    float x = 0;
    float y = 0;
    
    _gridArray = [NSMutableArray array];
    
    for (int i = 0; i < GRID_ROWS; i++) {
        _gridArray[i] = [NSMutableArray array];
        x = 0;
        for (int j = 0; j<GRID_COLS; j++) {
            Creature *creature = [[Creature alloc] initCreature];
            creature.anchorPoint = ccp(0,0);
            creature.position = ccp(x,y);
            [self addChild:creature];
            
            _gridArray[i][j] = creature;
            
            x+=_cellWidth;
        }
        y+=_cellHeight;
    }
}

-(void)touchBegan:(CCTouch *)touch withEvent:(CCTouchEvent *)event{
    CGPoint touchLocation = [touch locationInNode:self];
    
    Creature *creature = [self creatureForTouchPosition:touchLocation];
    
    creature.isAlive = !creature.isAlive;
}

-(Creature*)creatureForTouchPosition:(CGPoint)touchPosition{
    int row = touchPosition.y/_cellHeight;
    int col = touchPosition.x/_cellWidth;
    return _gridArray[row][col];
}

-(void)evolveStep{
    [self countNeighbors];
    [self updateCreatures];
    
    _generation++;
}

-(void)countNeighbors{
    for (int i=0; i <[_gridArray count]; i++) {
        for (int j=0; j<[_gridArray[i] count]; j++) {
            Creature *currentCreture = _gridArray[i][j];
            currentCreture.livingNeighbors = 0;
            
            for (int x = (i-1); x<=(i+1); x++) {
                for (int y = (j-1); y <= (j+1); y++) {
                    BOOL isIndexValid;
                    isIndexValid = [self isIndexValidForX:x andY:y];
                    
                    if (!((x==i) && (y==j)) && isIndexValid) {
                        Creature *neighbor = _gridArray[x][y];
                        if (neighbor.isAlive) {
                            currentCreture.livingNeighbors +=1;
                        }
                    }
                }
            }
        }
    }
}

-(void)updateCreatures{
    int numAlive = 0;
    for (int i=0; i <[_gridArray count]; i++) {
        for (int j=0; j<[_gridArray[i] count]; j++) {
            Creature *currentCreature = _gridArray[i][j];
            if (currentCreature.livingNeighbors == 3) {
                currentCreature.isAlive = TRUE;
                numAlive++;
            }
            if(currentCreature.livingNeighbors <=1 || currentCreature.livingNeighbors >=4)
            {
                currentCreature.isAlive = FALSE;
            }
        }
    }
    _totalAlive = numAlive;
}

-(BOOL)isIndexValidForX:(int)x andY:(int)y{
    BOOL isIndexValid = YES;
    if (x<0||y<0||x>=GRID_ROWS||y>=GRID_COLS) {
        isIndexValid = NO;
    }
    return isIndexValid;
}

@end
