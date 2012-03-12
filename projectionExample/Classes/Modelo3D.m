//
//  Modelo3D.m
//  projectionExample
//
//  Created by Jesus Cagide on 12/03/12.
//  Copyright (c) 2012 INEGI. All rights reserved.
//

#import "Modelo3D.h"

@implementation Modelo3D

@synthesize nombre;
@synthesize icono;


-(void)dealloc
{
    self.nombre = nil;
    self.icono = nil;
    [_archivoPOD release];
    [super dealloc];
}

-(CC3PODResourceNode*)obtenerArchivoPOD
{
    if(_archivoPOD && self.nombre.length>0)
    {   
        _archivoPOD = [CC3PODResourceNode nodeWithName: self.nombre];
        _archivoPOD.resource = [CC3PODResource resourceFromResourceFile: 
                                [NSString stringWithFormat:@"%@.pod",self.nombre]
                                ];
        _archivoPOD.location = cc3v(0.0, 0.0, 0.0);
        [_archivoPOD touchEnableAll];
    }
    return _archivoPOD;
}

@end
