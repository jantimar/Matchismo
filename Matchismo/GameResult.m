//
//  GameResult.m
//  Matchismo
//
//  Created by Jan Timar on 9/29/13.
//  Copyright (c) 2013 Jan Timar. All rights reserved.
//

#import "GameResult.h"

@interface GameResult ()

// datum kedy hra bola dohrana
@property(readwrite,nonatomic) NSDate *end;

// datum kedy sa hra zacala hrat
@property(readwrite,nonatomic) NSDate *start;

@end

@implementation GameResult

#define ALL_RESULTS_KEY @"GameResult_All"       // kluc pre ziskanie userDefaults
#define START_KEY @"StartDate"                  // kluc pre ziskanie a ulozenie zaciatku hry
#define END_KEY @"EndDate"                      // kluc pre ziskanie a ulozenie ukoncenia hry
#define SCORE_KEY @"Score"                      // kluc pre ziskanie a ulozenie zaciatku hry

// metoda vrati pole NSDictionary vsetkych vysledkov dohranych hier
+(NSArray *)allGameResults
{
    NSMutableArray *allGameResults = [[NSMutableArray alloc] init];
    NSDictionary *userDefaults = [[NSUserDefaults standardUserDefaults] dictionaryForKey:ALL_RESULTS_KEY];
    for(id plist in userDefaults){
        GameResult *result = [[GameResult alloc] initFromPropertyList:userDefaults[plist]];
        [allGameResults addObject:result];
    }
    return allGameResults;
}

// Vytvori objekt z NSDictionary plist, ak sa nepodari vytvorit objekt GameResult, vrati nil
-(id)initFromPropertyList:(id)plist
{
    self = [self init];
    if(self){
        if([plist isKindOfClass:[NSDictionary class]]){
            NSDictionary *resultDictionary = (NSDictionary *)plist;
            _start = [resultDictionary objectForKey:START_KEY];
            _end = [resultDictionary objectForKey:END_KEY];
            _score = [[resultDictionary objectForKey:SCORE_KEY] intValue];
            if(!_start || !_end){
                self = nil;
            }
        }
    }
    return self;
}

// metoda ulozi aktualnu hru
-(void)synchronize
{
    NSMutableDictionary *mutableGameResultsFromUserDefaults = [[[NSUserDefaults standardUserDefaults] dictionaryForKey:ALL_RESULTS_KEY] mutableCopy];
    if(!mutableGameResultsFromUserDefaults) mutableGameResultsFromUserDefaults = [[NSMutableDictionary alloc] init];
    mutableGameResultsFromUserDefaults[[self.start description]] = [self asPropertyList];
    [[NSUserDefaults standardUserDefaults] setObject:mutableGameResultsFromUserDefaults forKey:ALL_RESULTS_KEY];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

// vrati NSDictionary z udajov aktualnych udajov start, end a score
-(id)asPropertyList
{
    return @{ START_KEY : self.start, END_KEY : self.end, SCORE_KEY : @(self.score) };
}

// inicializuje objekt a zaroven nastavi zaciatok a koniec hry na aktualny cas
-(id)init
{
    self = [super init];
    if(self){
        _start = [NSDate date];
        _end = _start;
    }
    return self;
}

// setter pre skore, pri nastaveni skore nastavi aj koniec hry na aktualny datum a udaje nasledne ulozi pomocou synchronize 
-(void)setScore:(int)score
{
    _score = score;
    self.end = [NSDate date];
    [self synchronize];
}

// getterpre trvanie hry ktory vrati rozdiel medzi zaciatkom a koncom hry
-(NSTimeInterval)duration
{
    return [self.end timeIntervalSinceDate:self.start];
}


@end
