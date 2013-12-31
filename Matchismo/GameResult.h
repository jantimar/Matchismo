//
//  GameResult.h
//  Matchismo
//
//  Created by Jan Timar on 9/29/13.
//  Copyright (c) 2013 Jan Timar. All rights reserved.
//

#import <Foundation/Foundation.h>

// Objekt reprezentujuci skore aktualnej hry
@interface GameResult : NSObject

// datum kedy hra bola dohrana
@property(readonly,nonatomic) NSDate *end;

// datum kedy sa hra zacala hrat
@property(readonly,nonatomic) NSDate *start;

// dlzka trvania hry
@property(readonly,nonatomic) NSTimeInterval duration;

// skore nahrane pri hre
@property(nonatomic) int score;

// metoda vrati pole NSDictionary vsetkych vysledkov dohranych hier
+(NSArray *)allGameResults;

@end
