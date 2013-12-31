//
//  PlayingCardCollectionViewCell.h
//  Matchismo
//
//  Created by Jan Timar on 10/1/13.
//  Copyright (c) 2013 Jan Timar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PlayingCardView.h"

@interface PlayingCardCollectionViewCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet PlayingCardView *playingCardView;

@end
