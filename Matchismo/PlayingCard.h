//
//  PlayingCard.h
//  Matchismo
//
//  Created by Jan Timar on 9/27/13.
//  Copyright (c) 2013 Jan Timar. All rights reserved.
//

#import "Card.h"

// Objekt reprezentuje kartu hry Matchismo
@interface PlayingCard : Card

// Znak karty
@property(nonatomic,strong) NSString *suit;

// Rank karty
@property(nonatomic) NSUInteger rank;

// Pole moznych znakov kariet Matchismo
+(NSArray *)validSuits;

// Najvacsi mozny rank kariet v hre Matchismo
+(NSUInteger)maxRank;

@end
