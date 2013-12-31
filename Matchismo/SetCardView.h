//
//  SetCardView.h
//  Matchismo
//
//  Created by Jan Timar on 10/2/13.
//  Copyright (c) 2013 Jan Timar. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SetCardView : UIView

@property(nonatomic) NSUInteger rank;

@property(nonatomic,strong) NSString *suit;

@property(nonatomic,getter = isFaceUp) BOOL faceUp;

@property(nonatomic,strong) UIColor *color;

-(void)pinch:(UIPinchGestureRecognizer *)gesture;

@property(nonatomic,strong) NSDictionary *contentAttributes;

@property(nonatomic) BOOL hasFill;

@end
