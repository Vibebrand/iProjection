//
//  Modelo3D.h
//  projectionExample
//
//  Created by Jesus Cagide on 12/03/12.
//  Copyright (c) 2012 INEGI. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CC3PODResourceNode.h"

@interface Modelo3D : NSObject
{
    CC3PODResourceNode * _archivoPOD;

}

-(CC3PODResourceNode*)obtenerArchivoPOD;

@property(nonatomic, retain)NSString* nombre;
@property(nonatomic, retain)UIImage *icono;


@end
