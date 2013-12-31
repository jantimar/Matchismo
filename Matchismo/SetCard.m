//
//  SetCard.m
//  Matchismo
//
//  Created by Jan Timar on 10/2/13.
//  Copyright (c) 2013 Jan Timar. All rights reserved.
//

#import "SetCard.h"

@implementation SetCard

// Nastavenie suit koly implementovanie gettera aj settera
@synthesize suit = _suit;

enum CardMatchResult : NSUInteger {
    nomatch = 0,
    rankmatch = 1,
    suitmatch = 2,
    colormatch = 3,
    rankdifferent = 4,
    suitdifferent = 5,
    colordifferent = 6,
    outletsmatch = 7,
    outletsdifferent = 8
};

// Porovnanie karty z ostatnymi kartami
-(int)match:(NSArray *)otherCards
{
    int score = 0;
    
    if([otherCards count] > 0){
        
        if(([self checkIfCards:otherCards hasSameMatch:rankmatch] || [self checkIfCards:otherCards hasSameMatch:rankdifferent])
           && ([self checkIfCards:otherCards hasSameMatch:suitmatch] || [self checkIfCards:otherCards hasSameMatch:suitdifferent])
           && ([self checkIfCards:otherCards hasSameMatch:colormatch] || [self checkIfCards:otherCards hasSameMatch:colordifferent])
           && ([self checkIfCards:otherCards hasSameMatch:outletsmatch] || [self checkIfCards:otherCards hasSameMatch:outletsdifferent] )){
            score = 10;
        }
    }
    
    return score;
}

-(BOOL)checkIfCards:(NSArray *)otherCards hasSameMatch:(enum CardMatchResult)sameMatch
{
    BOOL result = YES;
    
    NSMutableArray *allCard = [[NSMutableArray alloc] initWithArray:otherCards];
    [allCard addObject:self];
    for(SetCard *firstCard in allCard){
        for(SetCard *secondCard in allCard){
            if(![firstCard isEqual:secondCard]){
                switch (sameMatch) {
                    case rankmatch:
                        if(firstCard.rank != secondCard.rank)
                            return NO;
                        break;
                    case rankdifferent:
                        if(firstCard.rank == secondCard.rank)
                            return NO;
                        break;
                    case  colormatch:
                        if([firstCard.color isEqual:secondCard.color])
                            return NO;
                        break;
                    case colordifferent:
                        if(![firstCard.color isEqual:secondCard.color])
                            return NO;
                        break;
                    case suitmatch:
                        if([firstCard.suit isEqual:secondCard.suit])
                            return NO;
                        break;
                    case suitdifferent:
                        if(![firstCard.suit isEqual:secondCard.suit])
                            return NO;
                        break;
                    case outletsmatch:
                        if(firstCard.hasFill == secondCard.hasFill)
                            return NO;
                        break;
                    case outletsdifferent:
                        if(firstCard.hasFill != secondCard.hasFill)
                            return NO;
                        break;
                    case nomatch:
                        NSLog(@"No match");
                }
            }
        }
    }
    
    return result;
}

// Obsah hracej karty
-(NSString *)contents
{
    NSMutableString *content = [[NSMutableString alloc] init];
    if(self.hasFill){
    for(int suitNumber = 1; suitNumber <= self.rank; suitNumber++)
        [content appendString:self.suit];
    } else {
        for(int suitNumber = 1; suitNumber <= self.rank; suitNumber++) {
            if([self.suit isEqualToString:@"●"])
                [content appendString:@"◯"];
            else if ([self.suit isEqualToString:@"■"])
                [content appendString:@"▢"];
            else if ([self.suit isEqualToString:@"▲"])
                [content appendString:@"△"];
        }
    }
    return content;
}

-(NSDictionary *)atributeContents
{
    //return @{ NSForegroundColorAttributeName : self.color, NSStrokeWidthAttributeName : self.outletes };
    return @{ NSForegroundColorAttributeName : self.color };
}

// Pole moznych znakov kariet Matchismo
+(NSArray *)validSuits
{
    return @[@"●",@"■",@"▲"];
}

// Pole moznych rankov kariet Matchismo
+(NSArray *)rankString
{
    return @[@"?",@"1",@"2",@"3"];
}

+(NSArray *)validColors
{
    return @[[UIColor redColor],[UIColor greenColor],[UIColor purpleColor]];
}

+(NSUInteger)maxRank
{
    return [SetCard rankString].count-1;
}

+(NSArray *)validFills
{
    return @[@0,@1];
}

// Nastavenie noveho suit po overeni ci novy suit je mozny v hre matchismo
-(void)setSuit:(NSString *)suit
{
    if([[SetCard validSuits] containsObject:suit])
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
    if(rank <= [SetCard maxRank])
        _rank = rank;
}

-(void)setColor:(UIColor *)color
{
    if([[SetCard validColors] containsObject:color]){
        _color = color;
    }
}

@end
