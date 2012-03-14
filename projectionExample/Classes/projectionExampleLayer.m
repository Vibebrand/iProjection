//
//  projectionExampleLayer.m
//  projectionExample
//
//  Created by Jesus Cagide on 07/02/12.
//  Copyright INEGI 2012. All rights reserved.
//

#import "projectionExampleLayer.h"
#import "Mundo3D.h"


@interface CC3Layer (TemplateMethods)
-(BOOL) handleTouch: (UITouch*) touch ofType: (uint) touchType;
@end

@implementation projectionExampleLayer

@synthesize world3D;

-(Mundo3D*) world3D {
	return (Mundo3D*) self.cc3World;
}

- (void)dealloc {
    [super dealloc];
}

-(void) initializeControls 
{
    self.isTouchEnabled = YES;
    [self setupPanGestureRecognition];
    [self setupPinchGestureRecognition];
    //[self setupTapGestureRecognition];
}

/*-(void) setupTapGestureRecognition
{
    UITapGestureRecognizer* tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapGesture:)];
    
    [tapGesture setNumberOfTapsRequired:1];
    [tapGesture setNumberOfTouchesRequired:1];

    [[[CCDirector sharedDirector] openGLView] addGestureRecognizer:tapGesture];
	[tapGesture release];
    
}
-(IBAction)handleTapGesture:(UITapGestureRecognizer*)sender
{
     CCDirector *director = [CCDirector sharedDirector]; 
     CGPoint touch =  [(UIPanGestureRecognizer*)sender locationOfTouch:0 inView:[director openGLView]];
    [[self world3D] touchWorldAt:touch];
}*/


-(void) setupPanGestureRecognition
{
    UIPanGestureRecognizer* panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePanGesture:)];
    
    [panGesture setMinimumNumberOfTouches:1];
	[panGesture setMaximumNumberOfTouches:1];
    
	[[[CCDirector sharedDirector] openGLView] addGestureRecognizer:panGesture];
	[panGesture release];
    
    
}
-(IBAction)handlePanGesture:(UIPanGestureRecognizer*)sender
{
 
    CCDirector *director = [CCDirector sharedDirector]; 
    
    if([(UIPanGestureRecognizer*)sender state] == UIGestureRecognizerStateChanged) {
        
        CGPoint tp = [(UIPanGestureRecognizer*)sender locationOfTouch:0 inView:[director openGLView]];
        CGFloat delX =  tp.x - startX;
        CGFloat delY = - tp.y + startY;
        startX = tp.x; startY = tp.y;
        
        delY = delY* - 0.5;
        delX = delX*0.5;
        
        [[self world3D] spinThatThing:delX :delY];
    }
    
    if([(UIPanGestureRecognizer*)sender state] == UIGestureRecognizerStateBegan) {
        CGPoint tp =  [(UIPanGestureRecognizer*)sender locationOfTouch:0 inView:[director openGLView]];
        startX = tp.x;
        startY = tp.y;
    }
}

-(void) setupPinchGestureRecognition
{
    
    UIPinchGestureRecognizer* pinchGesture = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(handlePinchGesture:)];
    
	[[[CCDirector sharedDirector] openGLView] addGestureRecognizer:pinchGesture];
	[pinchGesture release];
}


-(IBAction)handlePinchGesture:(UIPinchGestureRecognizer*)sender
{
    CGFloat currentScale = [(UIPinchGestureRecognizer*)sender scale];
    CGFloat display = (1-currentScale);
    [[self world3D ] zoomThatThing:display];

}

-(void) ccTouchMoved: (UITouch *)touch withEvent: (UIEvent *)event {
	[self handleTouch: touch ofType: kCCTouchMoved];
}





@end
