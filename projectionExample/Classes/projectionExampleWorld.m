//
//  projectionExampleWorld.m
//  projectionExample
//
//  Created by Jesus Cagide on 07/02/12.
//  Copyright INEGI 2012. All rights reserved.
//

#import "projectionExampleWorld.h"
#import "CC3PODResourceNode.h"
#import "CC3ActionInterval.h"
#import "CC3MeshNode.h"
#import "CC3Camera.h"
#import "CC3Light.h"


#import "CC3ActionInterval.h"
#import "CC3ModelSampleFactory.h"

#import "CCLabelTTF.h"
#import "CGPointExtension.h"
#import "CCTouchDispatcher.h"
#import "CCParticleExamples.h"
#import "CC3OpenGLES11Engine.h"
#import "CC3PODNode.h"
#import "CC3BoundingVolumes.h"
#import "CC3ParametricMeshNodes.h"
#import "CC3PointParticleSamples.h"
#import "CC3VertexSkinning.h"

#import "projectionExampleLayer.h"

#import "CC3Resource.h"

@implementation projectionExampleWorld

@synthesize nodoSeleccionado;

-(void) dealloc {
    self.nodoSeleccionado = nil;
    [podRezNode release];
    [selectedNode release];
	[super dealloc];
}


-(void) drawWorld
{
    static BOOL nombre = true;
    if(nombre)
    {
        [self.activeCamera moveWithDuration:2.0 toShowAllOf:podRezNode];
        nombre=false;
    }
    
    [super drawWorld];
}


-(void) initializeWorld {

    self.shouldClearDepthBufferBefore2D = NO;
	self.shouldClearDepthBufferBefore3D = NO;
	[[CCDirector sharedDirector] setDepthTest: NO];
    
    self.drawingSequencer = [CC3BTreeNodeSequencer sequencerLocalContentOpaqueFirst];

    
    CC3Camera* cam = [CC3Camera nodeWithName: @"Camera"];
	cam.location = cc3v( 0.0, 0.0, 30.0 );
	[self addChild: cam];


	CC3Light* lamp = [CC3Light nodeWithName: @"Lamp"];
	lamp.location = cc3v( -2.0, 0.0, 0.0 );
	lamp.isDirectionalOnly = NO;
	[cam addChild: lamp];

    [self createGLBuffers];
	[self releaseRedundantData];
	
    //self.shouldDrawAllLocalContentWireframeBoxes = YES;
    
    //self.shouldDrawAllDescriptors = YES;
   // self.shouldDrawAllLocalContentWireframeBoxes = YES;
    self.shouldDrawAllWireframeBoxes = YES;
    
    [self addPOD];
    
    // Displays bounding boxes around all nodes. The bounding box for each node
	// will encompass its child nodes.
	//self.shouldDrawAllWireframeBoxes = YES;
	
	// Moves the camera so that it will display the entire scene.

		LogDebug(@"The structure of this world is: %@", [self structureDescription]);
	}


-(void)addPOD
{
    //CC3MeshNode* teapotSatellite = [[CC3ModelSampleFactory factory] makeMultiColoredTeapotNamed: @"satelite"];
    //[teapotSatellite setLocation:cc3v(0.0, 0.0, 0.0)];
    //[self addChild:teapotSatellite];
    
    podRezNode = [CC3PODResourceNode nodeWithName: @"MAPA"];
	podRezNode.resource = [CC3PODResource resourceFromResourceFile: @"mapmexico37.pod"];
    podRezNode.location = cc3v(0.0, 0.0, 0.0);
    [podRezNode addAxesDirectionMarkers];
    [podRezNode touchEnableAll];
    
    self.ambientLight = kCC3DefaultLightColorAmbientWorld;
    [self addChild: podRezNode];
    
}

-(void) updateBeforeTransform: (CC3NodeUpdatingVisitor*) visitor {}

-(void) updateAfterTransform: (CC3NodeUpdatingVisitor*) visitor {}

-(void) touchEvent: (uint) touchType at: (CGPoint) touchPoint {
    
	switch (touchType) {
		case kCCTouchBegan:
			[touchedNodePicker pickNodeFromTouchEvent: touchType at: touchPoint];
			break;
		case kCCTouchMoved:
            
			break;
		case kCCTouchEnded:
            selectedNode = nil;
			break;
		default:
			break;
	}
}


/*-(void)touchWorldAt:(CGPoint) touchPoint
{
    [touchedNodePicker pickNodeFromTouchEvent: kCCTouchBegan at: touchPoint];
}*/

-(void) nodeSelected: (CC3Node*) aNode byTouchEvent: (uint) touchType at: (CGPoint) touchPoint {
    
    CC3Node * nodo = (CC3Node*)podRezNode;

    LogInfo(@"You selected %@ at %@, or %@ in 2D.", nodo,
			NSStringFromCC3Vector( nodo.boundingBox.maximum  ),
			NSStringFromCC3Vector(   nodo.boundingBox.minimum  ));
    
    
    /*
    	CC3Camera* cam = self.activeCamera;
    	cam.shouldTrackTarget = YES;
        cam.target = aNode;
       [cam runAction: [CC3RotateToLookAt actionWithDuration: 2.0
														 targetLocation: aNode.globalLocation]];
    
    
        
    
    
    LogInfo(@"camera %@ at %@, or %@ in 2D.", cam,
			NSStringFromCC3Vector( cam.boundingBox.maximum  ),
			NSStringFromCC3Vector(   cam.boundingBox.minimum  ));*/
    
    
	selectedNode = aNode;
	//aNode.shouldDrawDescriptor = !aNode.shouldDrawDescriptor;
	aNode.shouldDrawDescriptor = false;
    
    //CCActionInterval* tintUp = [CC3TintEmissionTo actionWithDuration: 0.3f colorTo: kCCC4FCyan];
    //CCActionInterval* tintDown = [CC3TintEmissionTo actionWithDuration: 0.9f colorTo: kCCC4FBlack];
    //[aNode runAction: [CCSequence actionOne: tintUp two: tintDown]];
    
   /* CC3Vector currentVector = aNode.location;
    CC3Vector endingVector = CC3VectorAdd(currentVector, cc3v(0.0,0.0, 5));
    
    
    CCActionInterval* dropAction = [CC3MoveTo actionWithDuration: 3.0f moveTo: endingVector];
	dropAction = [CCEaseOut actionWithAction: [CCEaseIn actionWithAction: dropAction rate: 4.0f] rate: 1.6f];
    [aNode runAction:dropAction];*/
    
    [aNode setColor:ccRED];
    aNode.isOpaque = !aNode.isOpaque;
    if(!aNode.isOpaque){
        aNode.opacity =200;
        //[self.activeCamera moveWithDuration:2.0 toShowAllOf:podRezNode];
    }else
    {
        //[self.activeCamera moveWithDuration:2.0 toShowAllOf:aNode];
    }
    [self setNodoSeleccionado:[aNode name]];
   // NSLog(@"%@", aNode.opacity);
    NSLog(@"%@", self.nodoSeleccionado);
}


-(void)zoomThatThing:(CGFloat)theZoom
{
    CC3Camera *theCamera = (CC3Camera *)[self activeCamera];    
    CC3Vector currentVector = theCamera.location;
    CC3Vector endingVector = CC3VectorAdd(currentVector, cc3v(0.0, 0.0, theZoom));
    
    if ( endingVector.z  > 2 && endingVector.z < 10)
        [theCamera setLocation:endingVector];
    

}

-(void)spinThatThing:(CGFloat)x :(CGFloat)y
{
    CC3Vector current = [podRezNode rotation];
    
    CC3Vector increment = CC3VectorAdd(current, cc3v(y, x, 0.0));
    [podRezNode setRotation:increment];
}

@end



