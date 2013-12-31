//
//  Card.m
//  Matchismo
//
//  Created by Jan Timar on 9/27/13.
//  Copyright (c) 2013 Jan Timar. All rights reserved.
//

#import "Card.h"

@implementation Card

// Ak sa obsah kariet zhoduje vrati 1, ak nie vrati 0
-(int)match:(NSArray *)otherCards
{
    int score = 0;
    
    for(Card *otherCard in otherCards){
        if([self.contents isEqualToString:otherCard.contents])
            score = 1;
    }
    
    return score;
}

-(NSDictionary *)atributeContents
{
    return nil;
}

@end
