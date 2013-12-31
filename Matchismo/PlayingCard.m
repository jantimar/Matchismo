//
//  PlayingCard.m
//  Matchismo
//
//  Created by Jan Timar on 9/27/13.
//  Copyright (c) 2013 Jan Timar. All rights reserved.
//

#import "PlayingCard.h"

@implementation PlayingCard

// Nastavenie suit koly implementovanie gettera aj settera
@synthesize suit = _suit;

enum CardMatchResult : NSUInteger {
    nomatch = 0,
    rankmatch = 1,
    suitmatch = 2
};

// Porovnanie karty z ostatnymi kartami
-(int)match:(NSArray *)otherCards
{
    int score = 0;
    
    enum CardMatchResult cardMatchResult;
    if([otherCards count] > 0){
        Card *lastCard = [otherCards lastObject];
        cardMatchResult = [self matchWithCard:lastCard];
        
        switch (cardMatchResult) {          // porovnava sa rank kariet
            case rankmatch:
                if([self checkIfCard:otherCards hasSameMatch:rankmatch])  score = 9;
                else score = 0;
                break;
            case suitmatch:                 // porovnavaju sa suit kariet
                if([self checkIfCard:otherCards hasSameMatch:suitmatch]) score = 3;
                else score = 0;
                break;
            default:                        // nepodporovana vetva alebo nomatch
                break;
        }
    }
    
    return score;
}

-(BOOL)checkIfCard:(NSArray *)otherCards hasSameMatch:(enum CardMatchResult)sameMatch
{
    BOOL result = YES;
    for(Card *otherCard in otherCards){
        if([self matchWithCard:otherCard] != sameMatch){
            result = NO;
            break;
        }
    }
    return result;
}

-(enum CardMatchResult)matchWithCard:(Card *)card
{
    if([card isKindOfClass:[PlayingCard class]]){
        PlayingCard *playingCard = (PlayingCard *)card;
        if(self.rank == playingCard.rank) {
            return rankmatch;
        } else if ([self.suit isEqualToString:playingCard.suit]) {
            return suitmatch;
        }
    }
    return nomatch;
}

// Obsah hracej karty
-(NSString *)contents
{
    return [[PlayingCard rankString][self.rank] stringByAppendingString:self.suit];
}

// Pole moznych znakov kariet Matchismo
+(NSArray *)validSuits
{
    return @[@"♣",@"♥",@"♦",@"♠"];
}

// Pole moznych rankov kariet Matchismo
+(NSArray *)rankString
{
    return @[@"?",@"A",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"J",@"Q",@"K"];
    //return @[@"?",@"A",@"2",@"3",...,@"10",@"J",@"Q",@"K"];
}

+(NSUInteger)maxRank
{
    return [PlayingCard rankString].count-1;
}

// Nastavenie noveho suit po overeni ci novy suit je mozny v hre matchismo
-(void)setSuit:(NSString *)suit
{
    if([[PlayingCard validSuits] containsObject:suit])
        _suit = suit;
}

// Getter pre suit. Ak suit este nie je nastaveny vrati znak ?
-(NSString *)suit
{
    return _suit ? _suit : @"?";
}

// Nastavi novy rank po overeni ci novy rank je mozny v hre Matchismo
-(void)setRank:(NSUInteger)rank
{
    if(rank <= [PlayingCard maxRank])
        _rank = rank;
}


@end
