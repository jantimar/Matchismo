//
//  CardGameViewController.m
//  Matchismo
//
//  Created by Jan Timar on 9/28/13.
//  Copyright (c) 2013 Jan Timar. All rights reserved.
//

#import "CardGameViewController.h"
#import "GameResult.h"


@interface CardGameViewController () <UICollectionViewDataSource,UIAlertViewDelegate,UICollectionViewDelegate>

// Label pre zobrazenie poctu otocenia kariet
@property (weak, nonatomic) IBOutlet UILabel *flipsLabel;

// Label pre zobrazenie nahraneho skore
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;

// Pocet otoceni kariet
@property (nonatomic) int flipCount;

// Vysledok aktualnej hry
@property (nonatomic,strong) GameResult *gameResult;

@property (weak, nonatomic) IBOutlet UICollectionView *cardCollectionView;

@property (weak, nonatomic) IBOutlet UILabel *resultOfLastFlipLabel;

// Objekt kartovej hry Matchismo
@property (strong,nonatomic) CardMatchingGame *game;    // abstrack

@property (nonatomic,strong) UIAlertView *dealAlert;

@end

@implementation CardGameViewController

-(void)viewDidLoad
{
    if(NSFoundationVersionNumber > NSFoundationVersionNumber_iOS_6_1)
    {
        // ide o ios 7 inac sa nastavy pod tab bar controllerom a nevydno cele UI
        [self setEdgesForExtendedLayout:UIRectEdgeNone];
    }
}

// Getter game, ak hra nie je nastavena inicializuje ju z poctom kariet vo viewControllery a novym balickom kariet
-(CardMatchingGame *)game
{
    if(!_game) _game = [self createGame];
    return _game;
}

-(CardMatchingGame *)createGame
{
    return [[CardMatchingGame alloc] initWithCardCount:self.startingCardCount usingDeck:[self createDeck] withGameMode:self.gameMode];
}

-(Deck *)createDeck
{
    // abstract
    return nil;
}

// Reakcia na kliknutie buttonu Deal, aktualnu hru a aktualny vysledok nastavi na nil a pocet otoceni kariet na 0 co zavola nasledne updateUI
- (IBAction)deal:(id)sender {
    self.dealAlert = [[UIAlertView alloc] initWithTitle:@"Deal" message:@"Are you sure?" delegate:self cancelButtonTitle:@"No" otherButtonTitles:@"Yes", nil];
    [self.dealAlert show];
}

-(int)gameMode
{
    // abstract
    return 0;
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if([alertView isEqual:self.dealAlert]){
        if(buttonIndex == 1){    //kliknute Yes
            self.game = nil;
            self.gameResult = nil;
            self.flipCount = 0; // UpdateUI sa vola sam po nastaveni flipCount preto ho nie je potrebne volat
            self.resultOfLastFlipLabel.text = @"Result of last flip";
        }
    }
}

// Akcia po kliknuti na button reprezentujuci kartu, otoci kartu a zvacsi pocet otoceni kariet
- (IBAction)flipCard:(UITapGestureRecognizer *)gesture {
    CGPoint tapLocation = [gesture locationInView:self.cardCollectionView];
    NSIndexPath *indexPath = [self.cardCollectionView indexPathForItemAtPoint:tapLocation];
    if(indexPath){
        [self.game flipCardAtIndex:indexPath.item];
        self.flipCount++;
        self.gameResult.score = self.game.score;
        [self updateUI];
    }
}

// pridanie kariet do hry
-(void)appendCardsToGame:(int)numberOfCardsToAppend
{
    Card *newCardInGame = nil;
    for(int numberOfCard = 1; numberOfCard <= numberOfCardsToAppend; numberOfCard++)
        newCardInGame = [self.game appendCardToGameFromDeck];
    
    if(newCardInGame != nil){
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:[self.cardCollectionView numberOfItemsInSection:0]  inSection:0];
        
        [self.cardCollectionView reloadData];
        [self.cardCollectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionBottom animated:YES];
    } else {
        self.dealAlert = [[UIAlertView alloc] initWithTitle:@"Out of card" message:@"You can not add next card" delegate:self cancelButtonTitle:@"Cancle" otherButtonTitles: nil];
        [self.dealAlert show];
    }
}

// odstranenie karty z hry
-(void)removeCardFromGame:(Card *)card
{
    [self.game removeCard:card];
}

// Updatne zobrazenie buttonov a labelov v hre
-(void)updateUI
{
    if(self.game.isMatch){
        for(int itemIndex = 0; itemIndex <= [self.cardCollectionView numberOfItemsInSection:0];itemIndex++){
            Card *card = [self.game cardAtIndex:itemIndex];
            if(card.isFaceUp){
                [self updateCell:[self.cardCollectionView cellForItemAtIndexPath:[NSIndexPath indexPathForRow:itemIndex inSection:0]] usingMatchedCard:card animate:YES];
            }
        }
    }
    [self.cardCollectionView reloadData];
    
    self.scoreLabel.text = [NSString stringWithFormat:@"Score: %d",self.game.score];
    self.flipsLabel.text = [NSString stringWithFormat:@"Flips: %d",self.flipCount];
    self.resultOfLastFlipLabel.attributedText = [self.game resultOfLastFlip];
}

-(void)updateCell:(UICollectionViewCell *)cell usingMatchedCard:(Card *)card animate:(BOOL)animate
{
    // abstract
}

-(void)updateCell:(UICollectionViewCell *)cell usingCard:(Card *)card animate:(BOOL)animate
{
    // abstract
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.game.numberOfCardsInGame;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"PlayingCard" forIndexPath:indexPath];

    Card *card = [self.game cardAtIndex:indexPath.item];
    [self updateCell:cell usingCard:card animate:YES];
    
    return cell;
}

// setter pre poctu otocenia kariet, zaroven zavola update UI
-(void)setFlipCount:(int)count
{
    _flipCount = count;
    [self updateUI];
}

// getter pre vysledok hry, ak nie je inicializovany, nasledne ho inicializuje
-(GameResult *)gameResult
{
    if(!_gameResult) _gameResult = [[GameResult alloc] init];
    return _gameResult;
}


@end
