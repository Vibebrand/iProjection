//
//  projectionExampleWorld.m
//  projectionExample
//

#import "Mundo3D.h"
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

#import "ServicioGestorModelos3D.h"


@implementation Mundo3D

@synthesize nombreNodoSeleccionado;

@synthesize delegadoReresentacionNavegacion;

@synthesize modelos3D;
@synthesize modelos3DActivos;
@synthesize representacionModelos3D;

-(void) dealloc {
    
    self.modelos3D = nil;
    self.modelos3DActivos = nil;
    self.representacionModelos3D = nil;
    
    self.nombreNodoSeleccionado = nil;
    self.delegadoReresentacionNavegacion = nil;
    
    [_modelo3DActivo release];
    [nodoSeleccionado release];
	[super dealloc];
    
}


-(void) drawWorld
{
    static BOOL nombre = true;
    if(nombre)
    {
        [self.activeCamera moveWithDuration:2.0 toShowAllOf:[_modelo3DActivo obtenerArchivoPOD]];
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
	
    self.shouldDrawAllWireframeBoxes = YES;
    
    
    ServicioGestorModelos3D* servicio = [ServicioGestorModelos3D new];
    [self setModelos3D: [servicio obtenerModelos3D]];
    
    [self agregarModelo3D:@"CHOC_Towe01"];
    [servicio release];
    
    
    [self setRepresentacionModelos3D:[NSMutableArray array]];
    [self setModelos3DActivos:[NSMutableArray array]];
    
    LogDebug(@"The structure of this world is: %@", [self structureDescription]);
	}

//TODO agregar comportamiento de la lista asi como su refrescado de objetos
-(void)agregarModelo3D:(NSString*)nombreModelo3D;
{
    if(self.modelos3D)
    {
        int rangoInicio =[self.modelos3DActivos indexOfObject:nombreModelo3D];
        int numeroDeElementos = [self.modelos3DActivos count];
        
        
        
        if(_modelo3DActivo && rangoInicio>0)
        {
            [[self modelos3DActivos] addObject: _modelo3DActivo.nombre   ];
            [[self representacionModelos3D] addObject: _modelo3DActivo.icono]; 
    
            //TODO agregar navegacion de imagenes
            if(numeroDeElementos>1){
                NSRange rango = NSMakeRange ((rangoInicio-1), (numeroDeElementos-rangoInicio));
                [ self.modelos3DActivos removeObjectsInRange:rango];
                [self.representacionModelos3D removeObjectsInRange:rango];
            }
            
        }else
        {
            [self.modelos3DActivos removeAllObjects];
            [self.representacionModelos3D removeAllObjects];
        }
        
        if(_modelo3DActivo){
            [self removeChild:[_modelo3DActivo obtenerArchivoPOD]];
            [[self delegadoReresentacionNavegacion] actualizarBarraNevegacion:[self representacionModelos3D]];
        }
        _modelo3DActivo = [[self modelos3D] objectForKey:nombreModelo3D];
       
        self.ambientLight = kCC3DefaultLightColorAmbientWorld;
        CC3Node* nodo = [_modelo3DActivo obtenerArchivoPOD];
        [self addChild:nodo];
    }
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
    
    if(aNode)
    {
        nodoSeleccionado =(CC3PODMeshNode*)aNode ; 
        CC3Material * materialNuevo = [[[nodoSeleccionado material] copy] autorelease];
        [nodoSeleccionado setMaterial: materialNuevo];
        
         [self setNombreNodoSeleccionado:[nodoSeleccionado name]];
        
        CCActionInterval* tintUp = [CC3TintEmissionTo actionWithDuration: 0.3f colorTo: kCCC4FCyan];
        CCActionInterval* tintDown = [CC3TintEmissionTo actionWithDuration: 0.9f colorTo: kCCC4FBlack];
        CCActionInterval* callFuncion = [CCCallFunc actionWithTarget:self selector:@selector(cargarModeloSeleccionado)];
        [nodoSeleccionado runAction: [CCSequence actions:tintUp,tintDown,callFuncion, nil ]];
    }
}

-(void)cargarModeloSeleccionado
{
    NSString* modeloACargar =  [[_modelo3DActivo navegacionPorNodo] objectForKey:self.nombreNodoSeleccionado];
    if(modeloACargar && [modeloACargar length])
        [self agregarModelo3D:modeloACargar];
}

-(void)zoomThatThing:(CGFloat)theZoom
{
    CC3Camera *theCamera = (CC3Camera *)[self activeCamera];    
    CC3Vector currentVector = theCamera.location;
    CC3Vector endingVector = CC3VectorAdd(currentVector, cc3v(0.0, 0.0, theZoom));
    
    if ( endingVector.z  > 1 && endingVector.z < 9)
        [theCamera setLocation:endingVector];
}

-(void)spinThatThing:(CGFloat)x :(CGFloat)y
{
    CC3Vector vectorDePosicionActual = [[_modelo3DActivo obtenerArchivoPOD] rotation];
    CC3Vector increment = CC3VectorAdd(vectorDePosicionActual, cc3v(y, x, 0.0));
    [[_modelo3DActivo obtenerArchivoPOD] setRotation:increment];
}

#pragma mark iDelegadoNavegacion

-(void)mostrarModelo3DenPosicion:(int)posicion
{
    [ self agregarModelo3D:[[self modelos3DActivos] objectAtIndex:posicion]];
}

@end



