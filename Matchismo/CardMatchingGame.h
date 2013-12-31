//
//  CardMatchingGame.h
//  Matchismo
//
//  Created by Jan Timar on 9/28/13.
//  Copyright (c) 2013 Jan Timar. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Deck.h"
#import "Card.h"

// Objekt reprezentujuci hru Matchismo
@interface CardMatchingGame : NSObject

// Skore hry, ktore je mozne iba citat
@property (nonatomic,readonly) int score;

@property (nonatomic,readonly) NSAttributedString *resultOfLastFlip;

// inicializovanie hry z maximalnym poctom kariet count z balicka deck
-(id)initWithCardCount:(int)count usingDeck:(Deck *)deck;

-(id)initWithCardCount:(int)count usingDeck:(Deck *)deck withGameMode:(int)gameMode;

// vrati kartu z hry na pozicii index
-(Card *)cardAtIndex:(int)index;

// otoci kartu z hry na pozicii index
-(void)flipCardAtIndex:(int)index;

@property(nonatomic,readonly) BOOL isMatch;

@property(nonatomic,readonly) NSInteger numberOfCardsInGame;

-(Card *)appendCardToGameFromDeck;

-(void)removeCard:(Card *)card;

@end
