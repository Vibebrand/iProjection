//
//  projectionExampleWorld.h
//  projectionExample
//
//  Created by Jesus Cagide on 07/02/12.
//  Copyright INEGI 2012. All rights reserved.
//



#import "CC3World.h"
#import "CC3MeshNode.h"

#import "CC3PODResourceNode.h"
#import "CC3PODLight.h"
#import "CC3PointParticles.h"

/** A sample application-specific CC3World subclass.*/
@interface projectionExampleWorld : CC3World 
{
    CC3PODResourceNode *podRezNode;
    CC3Node *selectedNode;
}

-(void)zoomThatThing:(CGFloat)theZoom;

-(void)spinThatThing:(CGFloat)x :(CGFloat)y;

//-(void)touchWorldAt:(CGPoint) touchPoint;  


@property(nonatomic, retain)NSString* nodoSeleccionado;

-(void)addPOD;
@end
