//
//  PlayingCardView.h
//  Matchismo
//
//  Created by Jan Timar on 9/30/13.
//  Copyright (c) 2013 Jan Timar. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PlayingCardView : UIView

@property(nonatomic) NSUInteger rank;

@property(nonatomic,strong) NSString *suit;

@property(nonatomic,getter = isFaceUp) BOOL faceUp;

-(void)pinch:(UIPinchGestureRecognizer *)gesture;

@end
