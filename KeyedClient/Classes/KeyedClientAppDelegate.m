//
//  KeyedClientAppDelegate.m
//  KeyedClient
//
//  Created by Edward Patel on 2010-01-31.
//  Copyright Memention AB 2010. All rights reserved.
//

#import "KeyedClientAppDelegate.h"
#import "KeyedClientViewController.h"

@implementation KeyedClientAppDelegate

@synthesize window;
@synthesize viewController;


- (void)applicationDidFinishLaunching:(UIApplication *)application {    
    
    // Override point for customization after app launch    
    [window addSubview:viewController.view];
    [window makeKeyAndVisible];
}


- (void)dealloc {
    [viewController release];
    [window release];
    [super dealloc];
}


@end
