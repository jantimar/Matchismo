//
//  Card.h
//  Matchismo
//
//  Created by Jan Timar on 9/27/13.
//  Copyright (c) 2013 Jan Timar. All rights reserved.
//

#import <Foundation/Foundation.h>

// Objekt reprezentujuic kartu v hre
@interface Card : NSObject

// Obsah hracej karty
@property (nonatomic,strong) NSString *contents;

// Otocenie karty
@property (nonatomic,getter = isFaceUp) BOOL faceUp;

// Urcuju ci z kartou sa da hrat
@property (nonatomic,getter = isUnplayable) BOOL unplayable;

// Porovnanie karty z ostatnymi kartami 
-(int)match:(NSArray *)otherCards;

-(NSDictionary *)atributeContents;    // abstract

@end
