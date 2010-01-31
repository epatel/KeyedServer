//
//  KeyedClientAppDelegate.h
//  KeyedClient
//
//  Created by Edward Patel on 2010-01-31.
//  Copyright Memention AB 2010. All rights reserved.
//

#import <UIKit/UIKit.h>

@class KeyedClientViewController;

@interface KeyedClientAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    KeyedClientViewController *viewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet KeyedClientViewController *viewController;

@end

