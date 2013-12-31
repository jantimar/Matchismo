//
//  CardGameViewController.h
//  Matchismo
//
//  Created by Jan Timar on 9/28/13.
//  Copyright (c) 2013 Jan Timar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Deck.h"
#import "CardMatchingGame.h"

// ViewController hracej obrazovky
@interface CardGameViewController : UIViewController

-(Deck *)createDeck;  // abstract

@property (nonatomic) NSUInteger startingCardCount;     // abstract

-(void)updateCell:(UICollectionViewCell *)cell usingCard:(Card *)card animate:(BOOL)animate; // abstract

-(void)updateCell:(UICollectionViewCell *)cell usingMatchedCard:(Card *)card animate:(BOOL)animate; //abstract

-(int)gameMode;     // abstract

-(void)appendCardsToGame:(int)numberOfCardsToAppend;

-(void)removeCardFromGame:(Card *)card;

@end
