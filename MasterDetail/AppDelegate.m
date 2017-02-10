//
//  AppDelegate.m
//  MasterDetail
//
//  Created by Michael Vilabrera on 1/21/17.
//  Copyright © 2017 Michael Vilabrera. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@property (weak) IBOutlet NSWindow *window;
@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    // Insert code here to initialize your application
}


- (void)applicationWillTerminate:(NSNotification *)aNotification {
    // Insert code here to tear down your application
    [self.masterController saveProductsToFile:@"/Users/mvilabrera/Developer/Rypress/MasterDetail/product-data.plist"];
    [self.masterController saveSelectionToUserDefaults];
}


@end
