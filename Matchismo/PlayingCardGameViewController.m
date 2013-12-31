//
//  PlayingCardGameViewController.m
//  Matchismo
//
//  Created by Jan Timar on 10/1/13.
//  Copyright (c) 2013 Jan Timar. All rights reserved.
//

#import "PlayingCardGameViewController.h"
#import "PlayingCardDeck.h"
#import "PlayingCard.h"
#import "PlayingCardCollectionViewCell.h"


@implementation PlayingCardGameViewController

-(Deck *)createDeck
{
    return [[PlayingCardDeck alloc] init];
}

-(NSUInteger) startingCardCount
{
    return 12;
}

-(void)updateCell:(UICollectionViewCell *)cell usingCard:(Card *)card animate:(BOOL)animate
{
    if([cell isKindOfClass:[PlayingCardCollectionViewCell class]]){
        PlayingCardView *playingCardView = ((PlayingCardCollectionViewCell *)cell).playingCardView;
        if([card isKindOfClass:[PlayingCard class]]){
            PlayingCard *playingCard = (PlayingCard *)card;
            if(animate && (playingCardView.isFaceUp != playingCard.isFaceUp)){
                [UIView transitionWithView:playingCardView
                                  duration:0.5
                                   options:UIViewAnimationOptionTransitionFlipFromLeft
                                animations:^{
                                    [self updatePlayingCardView:playingCardView usingPlayingCard:playingCard];
                                }
                                completion:NULL];
            } else {
                [self updatePlayingCardView:playingCardView usingPlayingCard:playingCard];
            }
        }
    }
}

-(int)gameMode
{
    return 2;
}

-(void)updatePlayingCardView:(PlayingCardView *)playingCardView usingPlayingCard:(PlayingCard *)playingCard
{
    playingCardView.suit = playingCard.suit;
    playingCardView.rank = playingCard.rank;
    playingCardView.faceUp = playingCard.isFaceUp;
    playingCardView.alpha = playingCard.isUnplayable ? 0.3 : 1.0;
}

@end
