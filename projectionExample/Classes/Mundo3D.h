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
#import "CC3PODMeshNode.h"
#import "CC3PODLight.h"
#import "CC3PointParticles.h"
#import "Mundo3D.h"
#import "Modelo3D.h"
#import "iDelegadoNavegacion.h"
#import "iDelegadoRepresentacionNavegacion.h"

@interface Mundo3D : CC3World<iDelegadoNavegacion>
{
    Modelo3D *_modelo3DActivo;
    CC3PODMeshNode  *nodoSeleccionado;
}

-(void)agregarModelo3D:(NSString*)nombreModelo3D;
-(void)cargarModeloSeleccionado;
-(void)zoomThatThing:(CGFloat)theZoom;

-(void)spinThatThing:(CGFloat)x :(CGFloat)y;

//-(void)touchWorldAt:(CGPoint) touchPoint;  


@property(nonatomic, assign)id<iDelegadoRepresentacionNavegacion> delegadoReresentacionNavegacion;
@property(nonatomic, retain)NSString* nombreNodoSeleccionado;


@property(nonatomic, retain)NSDictionary* modelos3D;//modelo3D
@property(nonatomic, retain)NSMutableArray * modelos3DActivos;//Strings
@property(nonatomic, retain)NSMutableArray* representacionModelos3D;//imagenes

#pragma mark iDelegadoNavegacion

-(void)mostrarModelo3DenPosicion:(int)posicion;

@end
