//
//  PlayingCardDeck.m
//  Matchismo
//
//  Created by Jan Timar on 9/27/13.
//  Copyright (c) 2013 Jan Timar. All rights reserved.
//

#import "PlayingCardDeck.h"
#import "PlayingCard.h"

@implementation PlayingCardDeck


// inicializovanie balicku kariet, do balicku vlozi kazdu moznu kartu v hre Matchismo 
-(id)init
{
    self = [super init];
    
    if(self){
        for(NSString *suit in [PlayingCard validSuits]){
            for (NSUInteger rank = 1; rank <= [PlayingCard maxRank];rank++) {
                PlayingCard *playingCard = [[PlayingCard alloc]init];
                playingCard.rank = rank;
                playingCard.suit = suit;
                [self addCard:playingCard atTop:YES];
            }
        
        }
    }
    
    return self;
}

@end
