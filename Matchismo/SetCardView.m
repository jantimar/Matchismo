//
//  SetCardView.m
//  Matchismo
//
//  Created by Jan Timar on 10/2/13.
//  Copyright (c) 2013 Jan Timar. All rights reserved.
//

#import "SetCardView.h"

@interface SetCardView ()

@property (nonatomic) CGFloat faceCardScaleFactor;

@end

@implementation SetCardView

#define CORNER_RADIUS 12.0
#define FONT_SIZE_SCALE 0.20
#define DEFAULT_FACE_CARD_SCALE_FACTOR 0.90

@synthesize faceCardScaleFactor = _faceCardScaleFactor;

- (void)drawRect:(CGRect)rect
{
    UIBezierPath *roundedRect = [UIBezierPath bezierPathWithRoundedRect:self.bounds cornerRadius:CORNER_RADIUS];
    
    [roundedRect addClip];
    
    [[UIColor whiteColor] setFill];
    UIRectFill(self.bounds);
    
    [[UIColor blackColor] setStroke];
    
    [roundedRect stroke];
    
    [self drawElements];
    
    if (self.faceUp) {
        self.alpha = 1.0f;
    } else {
        self.alpha = 0.5f;
        //[[UIImage imageNamed:@"cardback.png"] drawInRect:self.bounds];
    }
}

-(void)drawElements
{
    CGRect bounds;
    
    bounds.size = CGSizeMake(self.bounds.size.height/7.0-2, self.bounds.size.height/7.0-2);
    
    [self.color setStroke];
    
    if(self.hasFill)
        [self.color setFill];
    else
        [self.backgroundColor setFill];
    
    float widthPosition;
    switch (self.rank) {
        case 1:
            widthPosition = self.bounds.size.width/2.0 - bounds.size.width/2.0;
            break;
            
        case 2:
            widthPosition = self.bounds.size.width/2.0 - bounds.size.width - 1;
            break;
            
        case 3:
            widthPosition = self.bounds.size.width/2.0 - bounds.size.width*1.5 - 3;
            break;
            
        default:
            break;
    }
    
    for (int elementInRow = 1; elementInRow <= self.rank; elementInRow++) {
        
        bounds.origin = CGPointMake(widthPosition, self.bounds.size.height/2.0 - bounds.size.height/2.0);
        widthPosition += bounds.size.width + 2;
        
        if([self.suit isEqualToString:@"●"]){
            [self drawCirclesInBound:bounds];
        }
        else if([self.suit isEqualToString:@"▲"]){
            [self drawTrianglesInBound:bounds];
        }
        else if([self.suit isEqualToString:@"■"]){
            [self drawSquaresInBound:bounds];
        }
    }
}

-(void)drawSquaresInBound:(CGRect)bounds
{
    UIBezierPath *ballBezierPath = [UIBezierPath bezierPathWithRect:bounds];
    
    
    [ballBezierPath stroke];
    [ballBezierPath fill];
}

-(void)drawTrianglesInBound:(CGRect)bounds
{
    CGPoint startPoint,endPoint,thirdPoint;
    startPoint = CGPointMake(bounds.origin.x + bounds.size.width/2.0, bounds.origin.y);
    endPoint = CGPointMake(bounds.origin.x, bounds.origin.y + bounds.size.height);
    thirdPoint = CGPointMake(bounds.origin.x + bounds.size.width, bounds.origin.y + bounds.size.height);
    
    UIBezierPath *triangle = [UIBezierPath bezierPath];
    [triangle moveToPoint:startPoint];
    [triangle addLineToPoint:endPoint];
    [triangle addLineToPoint:thirdPoint];
    [triangle closePath];
    
    [triangle stroke];
    [triangle fill];
    [triangle closePath];
}

-(void)drawCirclesInBound:(CGRect)bounds
{
    UIBezierPath *ballBezierPath = [UIBezierPath bezierPathWithOvalInRect:bounds];
    
    [ballBezierPath stroke];
    [ballBezierPath fill];
}

-(NSString *)cardContent
{
    NSMutableString *content = [[NSMutableString alloc] init];
    for(int suitNumber = 1; suitNumber <= self.rank; suitNumber++)
        [content appendString:self.suit];
    return content;
}

- (void)pinch:(UIPinchGestureRecognizer *)gesture
{
    if ((gesture.state == UIGestureRecognizerStateChanged) ||
        (gesture.state == UIGestureRecognizerStateEnded)) {
        self.faceCardScaleFactor *= gesture.scale;
        gesture.scale = 1;
    }
}

-(void)setFaceUp:(BOOL)faceUp
{
    _faceUp = faceUp;
    [self setNeedsDisplay];
}


-(CGFloat)faceCardScaleFactor
{
    if (!_faceCardScaleFactor) _faceCardScaleFactor = DEFAULT_FACE_CARD_SCALE_FACTOR;
    return _faceCardScaleFactor;
}

-(void)setFaceCardScaleFactor:(CGFloat)faceCardScaleFactor
{
    _faceCardScaleFactor = faceCardScaleFactor;
    [self setNeedsDisplay];
}

-(NSString *)rankAsString
{
    return @[@"?",@"1",@"2",@"3"][self.rank];
}


-(void)setRank:(NSUInteger)rank
{
    _rank = rank;
    [self setNeedsDisplay];
}

-(void)setSuit:(NSString *)suit
{
    _suit = suit;
    [self setNeedsDisplay];
}

-(void)setColor:(UIColor *)color
{
    _color = color;
    [self setNeedsDisplay];
}

@end
