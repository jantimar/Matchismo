//
//  SetCardDeck.m
//  Matchismo
//
//  Created by Jan Timar on 10/2/13.
//  Copyright (c) 2013 Jan Timar. All rights reserved.
//

#import "SetCardDeck.h"
#import "SetCard.h"

@implementation SetCardDeck

// inicializovanie balicku kariet, do balicku vlozi kazdu moznu kartu v hre Matchismo
-(id)init
{
    self = [super init];
    
    if(self){
        for(NSString *suit in [SetCard validSuits]){
            for(UIColor *color in [SetCard validColors]){
                for (NSUInteger rank = 1; rank <= [SetCard maxRank];rank++) {
                    for(NSNumber *fill in [SetCard validFills]){
                    SetCard *setCard = [[SetCard alloc]init];
                    setCard.rank = rank;
                    setCard.suit = suit;
                    setCard.color = color;
                    setCard.hasFill = [fill boolValue];
                    [self addCard:setCard atTop:YES];}
                }
            }
        }
    }
    
    return self;
}

@end
