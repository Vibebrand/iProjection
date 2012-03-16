//
//  projectionExampleLayer.h
//  projectionExample
//
//  Created by Jesus Cagide on 07/02/12.
//  Copyright INEGI 2012. All rights reserved.
//


#import "CC3Layer.h"
#import "Mundo3D.h"

/** A sample application-specific CC3Layer subclass. */
@interface projectionExampleLayer : CC3Layer 
{
    CGFloat startX, endX, startY, endY;
    
}

#pragma mark Gestures
-(void) setupPanGestureRecognition;
-(IBAction)handlePanGesture:(UIPanGestureRecognizer*)sender;

-(void) setupPinchGestureRecognition;
-(IBAction)handlePinchGesture:(UITapGestureRecognizer*)sender;

-(void) setupTapGestureRecognition;
-(IBAction)handleTapGesture:(UITapGestureRecognizer*)sender;


@property(nonatomic, readonly) Mundo3D* world3D;


@end
