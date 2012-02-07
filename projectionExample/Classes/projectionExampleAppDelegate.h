//
//  projectionExampleAppDelegate.h
//  projectionExample
//
//  Created by Jesus Cagide on 07/02/12.
//  Copyright INEGI 2012. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CCNodeController.h"
#import "CC3World.h"

@interface projectionExampleAppDelegate : NSObject <UIApplicationDelegate> {
	UIWindow* window;
	CCNodeController* viewController;
}

@property (nonatomic, retain) UIWindow* window;

@end
