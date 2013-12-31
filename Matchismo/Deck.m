//
//  Deck.m
//  Matchismo
//
//  Created by Jan Timar on 9/27/13.
//  Copyright (c) 2013 Jan Timar. All rights reserved.
//

#import "Deck.h"

@interface Deck()

// Meniace sa pole obsahujuce vsetky karty v balicku
@property (nonatomic,strong) NSMutableArray *cards; // of Card

@end

@implementation Deck

// Getter cards, ak cards nebol nastaveny inicializuje ho
-(NSMutableArray *)cards
{
    if(!_cards) _cards = [[NSMutableArray alloc] init];
    return _cards;
}

// Prida kartu do balicka podla nastaveneho atTop na vrch alebo na spodok
-(void)addCard:(Card *)card atTop:(BOOL)atTop
{
    if(atTop) {
        [self.cards insertObject:card atIndex:0];
    } else {
        [self.cards addObject:card];
    }
}

// Vrati nahodne vybranu kartu z balicka
-(Card *)drawRandomCard
{
    Card *randomCard = nil;
    // nastavi index podla zvisku delenia nahodneho cisla a poctu kariet v balicku
    unsigned index = arc4random() % self.cards.count;
    if(index < [self.cards count]){
        randomCard = [self.cards objectAtIndex:index];
        // vybranu kartu  balicka nasledne odstrani
        [self.cards removeObjectAtIndex:index];
    }
    return randomCard;
}

@end
