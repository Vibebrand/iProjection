//
//  ServicioGestorModelos3D.h
//  projectionExample
//
//  Created by Jesus Cagide on 13/03/12.
//  Copyright (c) 2012 INEGI. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Modelo3D.h"
#import "iServicioGestorModelos3D.h"

@interface ServicioGestorModelos3D : NSObject<iServicioGestorModelos3D>
{
    NSMutableDictionary* modelos3D;
}

#pragma mark iServicioGestorModelos3D
-(NSDictionary*) obtenerModelos3D;

@end
