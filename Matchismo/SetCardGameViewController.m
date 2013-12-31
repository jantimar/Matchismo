//
//  SetCardGameViewController.m
//  Matchismo
//
//  Created by Jan Timar on 10/2/13.
//  Copyright (c) 2013 Jan Timar. All rights reserved.
//

#import "SetCardGameViewController.h"
#import "SetCard.h"
#import "SetCardDeck.h"
#import "SetCardView.h"
#import "SetCardCollectionViewCell.h"

@interface SetCardGameViewController ()

//@property(nonatomic,strong) SetCardMatchingGame *setGame;

@end

@implementation SetCardGameViewController


-(Deck *)createDeck
{
    return [[SetCardDeck alloc] init];
}

-(NSUInteger)startingCardCount
{
    return 22;
}

-(void)updateCell:(UICollectionViewCell *)cell usingCard:(Card *)card animate:(BOOL)animate
{
    if([cell isKindOfClass:[SetCardCollectionViewCell class]]){
        SetCardView *setCardView = ((SetCardCollectionViewCell *)cell).setCardView;
        if([card isKindOfClass:[SetCard class]]){
            SetCard *setCard = (SetCard *)card;
            if(animate && (setCardView.isFaceUp != setCard.isFaceUp)){
                [UIView transitionWithView:setCardView
                                  duration:0.5
                                   options:UIViewAnimationOptionCurveEaseIn
                                animations:^{
                                    [self updateSetCardView:setCardView usingSetCard:setCard];
                                }
                                completion:NULL];
            } else {
                [self updateSetCardView:setCardView usingSetCard:setCard];
            }
        }
        
    }
}

-(void)updateCell:(UICollectionViewCell *)cell usingMatchedCard:(Card *)card animate:(BOOL)animate
{
    [self removeCardFromGame:card];
}

- (IBAction)appendThreeCard:(id)sender
{
    [self appendCardsToGame:3];
}


-(int)gameMode
{
    return 3;
}

-(void)updateSetCardView:(SetCardView *)setCardView usingSetCard:(SetCard *)setCard
{
    setCardView.suit = setCard.suit;
    setCardView.rank = setCard.rank;
    setCardView.color = setCard.color;
    
    setCardView.hasFill = setCard.hasFill;
    
    setCardView.faceUp = setCard.isFaceUp;
    //setCardView.contentAttributes = setCard.atributeContents;
    setCardView.alpha = setCard.isUnplayable ? 0.3 : 1.0;
}

@end
