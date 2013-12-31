//
//  SetCard.h
//  Matchismo
//
//  Created by Jan Timar on 10/2/13.
//  Copyright (c) 2013 Jan Timar. All rights reserved.
//

#import "Card.h"

@interface SetCard : Card

// Znak karty
@property(nonatomic,strong) NSString *suit;

// Rank karty
@property(nonatomic) NSUInteger rank;

@property(nonatomic) UIColor *color;

@property(nonatomic) BOOL hasFill;

// Pole moznych znakov kariet Matchismo
+(NSArray *)validSuits;

// Najvacsi mozny rank kariet v hre Matchismo
+(NSUInteger)maxRank;

+(NSArray *)validColors;

+(NSArray *)validFills;

@end
