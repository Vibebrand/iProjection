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


@interface ControladorVentanaPrincipal : UIViewController
{
    EAGLView *_glView;
}

@property(nonatomic, assign) CCDirector* director;

@end
