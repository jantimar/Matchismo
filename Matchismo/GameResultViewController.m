//
//  GameResultViewController.m
//  Matchismo
//
//  Created by Jan Timar on 9/28/13.
//  Copyright (c) 2013 Jan Timar. All rights reserved.
//

#import "GameResultViewController.h"
#import "GameResult.h"

@interface GameResultViewController ()

// TextView pre zobrazenie skore hracov
@property (weak, nonatomic) IBOutlet UITextView *display;

@end

@implementation GameResultViewController

// Obnovenie obsahu textView display obsahujuci vysledky hier
-(void)updateUIWithGameResults:(NSArray *)gameResults
{
    NSString *displayText = @"Score\t\tDuration\t\tDate\n";
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"MM:EEEE HH:mm"];
    
    for(GameResult *result in gameResults){
        displayText = [displayText stringByAppendingFormat:@"Score: %d \t\t%0g \t%@\n",result.score,round(result.duration),[formatter stringFromDate:result.end]];
    }
    
    self.display.text = displayText;
}

- (IBAction)sortByScore:(UIButton *)sender
{
    id sortByScore = ^(GameResult *firstObject, GameResult *secondObject){
        return (firstObject.score < secondObject.score) ? 1 : 0;
    };
    
    NSArray *gameResultsSortedByScore = [[GameResult allGameResults] sortedArrayUsingComparator:sortByScore];
    [self updateUIWithGameResults:gameResultsSortedByScore];
}

- (IBAction)sortByDuration:(UIButton *)sender
{
    id sortByDuration = ^(GameResult *firstObject, GameResult *secondObject){
        return (firstObject.duration < secondObject.duration) ? 1 : 0;
    };
    
    NSArray *gameResultsSortedByDuration = [[GameResult allGameResults] sortedArrayUsingComparator:sortByDuration];
    [self updateUIWithGameResults:gameResultsSortedByDuration];
}

- (IBAction)sortByDate:(UIButton *)sender
{
    id sortByDate = ^(GameResult *firstObject, GameResult *secondObject){
        return (firstObject.end < secondObject.end) ? 1 : 0;
    };
    
    NSArray *gameResultsSortedByDate = [[GameResult allGameResults] sortedArrayUsingComparator:sortByDate];
    [self updateUIWithGameResults:gameResultsSortedByDate];
}

// Vykona sa po zobrazeni obsahu viewControlelra,  animated premenna urcuje ci sa ma zobrazit z animaciami alebo hned zjavi
// Zavola updateUI obsahu displaja obsahujuci skore
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self updateUIWithGameResults:[GameResult allGameResults]];
}


@end
