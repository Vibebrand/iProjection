//
//  ServicioGestorModelos3D.m
//  projectionExample
//
//  Created by Jesus Cagide on 13/03/12.
//  Copyright (c) 2012 INEGI. All rights reserved.
//

#import "ServicioGestorModelos3D.h"

@implementation ServicioGestorModelos3D

-(void)dealloc
{
    [modelos3D release];
    [super dealloc];
}

-(id)init
{
    if(self)
    {
        modelos3D = [NSMutableDictionary new];
        
        Modelo3D* tower01 = [[Modelo3D new] autorelease];
        [tower01 setNombre:@"CHOC_Towe01"];
        [tower01 setIcono:[UIImage imageNamed:@"3.png"]];
        [tower01 setNavegacionPorNodo:[NSMutableDictionary new]];
        [[tower01 navegacionPorNodo] setObject:@"CHOC_Towe01_FloorView_nuevo" forKey:@"CHOC_L_06-submesh1"];
        [[tower01 navegacionPorNodo] setObject:@"CHOC_Towe01_FloorView_nuevo" forKey:@"CHOC_L_06-submesh0"];
        
        Modelo3D* towe01_FloorView = [[Modelo3D new] autorelease];
        [towe01_FloorView setNombre:@"CHOC_Towe01_FloorView_nuevo"];
        [towe01_FloorView setIcono:[UIImage imageNamed:@"2.png"]];
        [towe01_FloorView setNavegacionPorNodo:[NSMutableDictionary new]];
        [[towe01_FloorView navegacionPorNodo] setObject:@"Towe01_FloorPlanView" forKey:@"CHOC_West_Wing"];
        [[towe01_FloorView navegacionPorNodo] setObject:@"Towe01_FloorPlanView" forKey:@"Detail_01"];
        
        Modelo3D* tower01FloorPlanView = [[Modelo3D new] autorelease];
        [tower01FloorPlanView setNombre:@"Towe01_FloorPlanView"];
        [tower01FloorPlanView setIcono:[UIImage imageNamed:@"1.png"]];
        [tower01FloorPlanView setNavegacionPorNodo:[NSMutableDictionary new]];
        
        [modelos3D setObject:tower01 forKey:tower01.nombre];
        [modelos3D setObject:towe01_FloorView forKey:towe01_FloorView.nombre];
        [modelos3D setObject:tower01FloorPlanView forKey:tower01FloorPlanView.nombre];
    }
    
    return self;
 }

-(NSDictionary*) obtenerModelos3D
{
    return modelos3D;
}

@end
