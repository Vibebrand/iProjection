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
#import "SBTickerView.h"

@interface ControladorVentanaPrincipal : UIViewController<UITableViewDelegate, UITableViewDataSource, iDelegadoRepresentacionNavegacion>
{
    EAGLView *_glView;

}

@property(nonatomic, assign) NSArray *representacionModelos3ds;
@property(nonatomic, assign) IBOutlet UITableView *tablaDatos;
@property(nonatomic, assign) IBOutlet UIView *panelRedondo;
@property(nonatomic, assign) CCDirector* director;

@property(nonatomic, assign)id<iDelegadoNavegacion> delegadoNavegacion;

@property(nonatomic, retain) IBOutlet CeldaModelo3D * celdaModelo3D;
@property(nonatomic, retain) UINib * cellNib;


@property (nonatomic, strong) IBOutlet SBTickerView *fullTickerView;
@property (nonatomic, strong) IBOutlet UIView *frontView;
@property (nonatomic, strong) IBOutlet UIView *backView;
- (IBAction)tick:(id)sender;

-(void)setupMenu;

#pragma mark iDelegadoRepresentacionNavegacion

-(void)actualizarBarraNevegacion:(NSArray*)representacionModelos3D;

@end
