//
//  ControladorVentanaPrincipal.h
//  projectionExample
//
//  Created by Jesus Cagide on 08/03/12.
//  Copyright (c) 2012 INEGI. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "cocos2d.h"
#import "CC3EAGLView.h"
#import "CeldaModelo3D.h"
#import "iDelegadoRepresentacionNavegacion.h"
#import "iDelegadoNavegacion.h"

@interface ControladorVentanaPrincipal : UIViewController<UITableViewDelegate, UITableViewDataSource, iDelegadoRepresentacionNavegacion>
{
    EAGLView *_glView;
}

@property(nonatomic, assign) IBOutlet NSArray *representacionModelos3ds;
@property(nonatomic, assign) IBOutlet UITableView *tablaDatos;
@property(nonatomic, assign) CCDirector* director;

@property(nonatomic, assign)id<iDelegadoNavegacion> delegadoNavegacion;

@property(nonatomic, retain) IBOutlet CeldaModelo3D * celdaModelo3D;
@property(nonatomic, retain) UINib * cellNib;

-(void)setupMenu;

#pragma mark iDelegadoRepresentacionNavegacion

-(void)actualizarBarraNevegacion:(NSArray*)representacionModelos3D;

@end
