//
//  CardMatchingGame.m
//  Matchismo
//
//  Created by Jan Timar on 9/28/13.
//  Copyright (c) 2013 Jan Timar. All rights reserved.
//

#import "CardMatchingGame.h"

@interface CardMatchingGame ()

// Skore hry, ktore je mozne citat aj nastavovat
@property (nonatomic,readwrite) int score;

// karty v hre
@property (nonatomic,strong) NSMutableArray *cards;

@property (nonatomic,readwrite) NSAttributedString *resultOfLastFlip;

@property(nonatomic,readwrite) BOOL isMatch;

@property(nonatomic) int mode;

@property (nonatomic,strong) Deck *deck;

@end

@implementation CardMatchingGame

#define MATCH_BONUS 4       // bonus pri zhode kariet
#define FLIP_COST -1        // cena za otocenie karty
#define MISTAKE_PENALTY 2   // cena z aotocenie dvoch kariet ktore sa nezhoduju

// inicializovanie hry z maximalnym poctom kariet count z balicka deck
-(id)initWithCardCount:(int)count usingDeck:(Deck *)deck
{
    self = [super init];
    
    if(self) {
        _deck = deck;
        // vyberie pocet kariet count z balicka a vlozi ich do hry
        for (int cardNumber = 0; cardNumber < count; cardNumber++){
            if(![self appendCardToGameFromDeck])
            {
                self = nil;
                return self;
            }
        }
    }
    
    return self;
}

-(Card *)appendCardToGameFromDeck
{
    Card *card = [self.deck drawRandomCard];
    if(card){
        self.cards[[self.cards count]] = card;
        return card;
    } else {
        NSLog(@"Nepodarilo sa pridat kartu");
        return nil;
    }
}

-(void)removeCard:(Card *)card
{
    if([self.cards containsObject:card]){
        [self.cards removeObject:card];
    }
}

-(NSInteger)numberOfCardsInGame
{
    return [self.cards count];
}

-(id)initWithCardCount:(int)count usingDeck:(Deck *)deck withGameMode:(int)gameMode
{
    self = [self initWithCardCount:count usingDeck:deck];
    if(self) {
        _mode = gameMode;
    }
    
    return self;
}

// otoci kartu z hry na pozicii index
-(void)flipCardAtIndex:(int)index
{
    self.isMatch = NO;
    Card *card = [self.cards objectAtIndex:index];
    
    NSMutableArray *otherPlayableFlipedUpCards = [[NSMutableArray alloc] init];
    if(card && !card.isUnplayable){
        
        [self setResultOfLastFlipWithCard:card];
        //self.resultOfLastFlip = [NSString stringWithFormat:@"Fliped up %@",card.contents];
        
        for(Card *otherCard in self.cards){
            if(![otherCard isEqual:card] && otherCard.isFaceUp && !otherCard.isUnplayable){
                [otherPlayableFlipedUpCards addObject:otherCard];
            }
        }
        
        NSMutableArray *allFaceUpPlayableCards = [[NSMutableArray alloc] initWithArray:otherPlayableFlipedUpCards];
        [allFaceUpPlayableCards addObject:card];
        
        if([otherPlayableFlipedUpCards count] +1 == self.mode){
            int matchScore = [card match:otherPlayableFlipedUpCards];
            
            if(matchScore){
                for(Card *otherCard in otherPlayableFlipedUpCards){
                    otherCard.unplayable = YES;
                }
                card.unplayable = YES;
                int scoreChange = MATCH_BONUS * matchScore;
                self.score += scoreChange;
                self.isMatch = YES;
                
                
                
                [self setResultOfLastFlipWithCards:allFaceUpPlayableCards andChangeScore:scoreChange];
            } else {
                for(Card *otherCard in otherPlayableFlipedUpCards){
                    otherCard.faceUp = NO;
                }
                self.score -= MISTAKE_PENALTY;
                
                [self setResultOfLastFlipWithCards:allFaceUpPlayableCards andChangeScore:-MISTAKE_PENALTY];
            }
        }
        card.faceUp = !card.faceUp;
        self.score += FLIP_COST;
    }
}

-(void)setResultOfLastFlipWithCard:(Card *)card
{
    NSMutableAttributedString *flipedCardAttributedString = [[NSMutableAttributedString alloc] initWithString:@"Fliped up " attributes:nil];
    [flipedCardAttributedString appendAttributedString:[[NSAttributedString alloc] initWithString:card.contents attributes:card.atributeContents]];
    self.resultOfLastFlip = flipedCardAttributedString;
}

-(void)setResultOfLastFlipWithCards:(NSArray *)cards andChangeScore:(int)changeScore
{
    NSMutableString *cardsString = [[NSMutableString alloc]init];
    for(Card *card in cards){
        [cardsString appendString:card.contents];
        if(![card isEqual:[cards lastObject]]) [cardsString appendString:@" & "];
    }
    
    NSString *resultString;
    NSMutableAttributedString *resultMutableString;
    
    int rangeStart;
    
    if (changeScore > 0) {
        resultString = [NSString stringWithFormat:@"Matched %@ for %d points",cardsString,changeScore];
        resultMutableString = [[NSMutableAttributedString alloc] initWithString:resultString];
        rangeStart = 8;
    } else if (changeScore < 0) {
        resultString = [NSString stringWithFormat:@"%@ don't match %d point penalty!",cardsString,changeScore];
        resultMutableString = [[NSMutableAttributedString alloc] initWithString:resultString];
        rangeStart = 0;
    }
    
    for(Card *card in cards){
        //NSRange range = [resultString rangeOfString:card.contents];
        NSRange range = NSMakeRange(rangeStart,card.contents.length);
        if (range.location != NSNotFound) {
            if(card.atributeContents != nil){
            [resultMutableString addAttributes:card.atributeContents
                                         range:range];
            }
        }
        rangeStart += (card.contents.length + 3);
    }
    
    self.resultOfLastFlip = resultMutableString;
}

// vrati kartu z hry na pozicii index
-(Card *)cardAtIndex:(int)index
{
    Card *card = nil;
    if(index < self.cards.count)
        card = [self.cards objectAtIndex:index];
    return card;
}

// setter cards, ak karty v hre nie su inicializovane, nasledne ich inicializuje
-(NSMutableArray *)cards
{
    if(!_cards) _cards = [[NSMutableArray alloc] init];
    return _cards;
}
@end
