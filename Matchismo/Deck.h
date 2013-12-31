//
//  Deck.h
//  Matchismo
//
//  Created by Jan Timar on 9/27/13.
//  Copyright (c) 2013 Jan Timar. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Card.h"

// Objekt reprezentujuci balicek kariet
@interface Deck : NSObject

// Prida kartu do balicka podla nastaveneho atTop na vrch alebo na spodok
-(void)addCard:(Card *)card atTop:(BOOL)atTop;

// Vrati nahodne vybranu kartu z balicka 
-(Card *)drawRandomCard;

@end
