//
//  projectionExampleAppDelegate.m
//  projectionExample
//
//  Created by Jesus Cagide on 07/02/12.
//  Copyright INEGI 2012. All rights reserved.
//

#import "cocos2d.h"

#import "projectionExampleAppDelegate.h"
#import "projectionExampleLayer.h"
#import "Mundo3D.h"
#import "CC3EAGLView.h"

@implementation projectionExampleAppDelegate

@synthesize window;

- (void)dealloc {
	[[CCDirector sharedDirector] release];
	[window release];
    [controladorVentanaPrincipal release];
    
	//[viewController release];
	[super dealloc];
}

- (void) applicationDidFinishLaunching:(UIApplication*)application {
	
	window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
	
	
	if( ! [CCDirector setDirectorType:kCCDirectorTypeDisplayLink] )
		[CCDirector setDirectorType:kCCDirectorTypeDefault];
	
	CCDirector *director = [CCDirector sharedDirector];

	// If the rotation is going to be controlled by a UIViewController
	// then the device orientation should be "Portrait".
	[director setDeviceOrientation:kCCDeviceOrientationPortrait];

	[director setAnimationInterval:1.0/60];
	[director setDisplayFPS:NO];
	
     controladorVentanaPrincipal = [[ControladorVentanaPrincipal alloc] initWithNibName:@"ControladorVentanaPrincipal" bundle:[NSBundle mainBundle]];
	
	[window addSubview: [controladorVentanaPrincipal view] ];
	[window makeKeyAndVisible];

	[CCTexture2D setDefaultAlphaPixelFormat:kCCTexture2DPixelFormat_RGBA8888];
	
    /*viewController = [[CCNodeController controller] retain];
	viewController.doesAutoRotate = YES;
	[viewController runSceneOnNode: mainLayer];	*/		
}

- (void)applicationWillResignActive:(UIApplication *)application {
	[[CCDirector sharedDirector] pause];
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
	[[CCDirector sharedDirector] resume];
}

- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application {
	[[CCDirector sharedDirector] purgeCachedData];
}

-(void) applicationDidEnterBackground:(UIApplication*)application {
	[[CCDirector sharedDirector] stopAnimation];
}

-(void) applicationWillEnterForeground:(UIApplication*)application {
	[[CCDirector sharedDirector] startAnimation];
}

- (void)applicationWillTerminate:(UIApplication *)application {
	CCDirector *director = [CCDirector sharedDirector];
	
	[[director openGLView] removeFromSuperview];
    
	[controladorVentanaPrincipal release];
	//[viewController release];
	
	[window release];
	
	[director end];	
}

- (void)applicationSignificantTimeChange:(UIApplication *)application {
	[[CCDirector sharedDirector] setNextDeltaTimeZero:YES];
}

@end
