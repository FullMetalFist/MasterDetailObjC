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
    [self.masterController loadProductsFromFile:[self productDataFilePath]];
    [self.masterController loadSelectionFromUserDefaults];
}


- (void)applicationWillTerminate:(NSNotification *)aNotification {
    // Insert code here to tear down your application
    [self.masterController saveProductsToFile:[self productDataFilePath]];
    [self.masterController saveSelectionToUserDefaults];
}

- (NSString *)productDataFilePath {
    // get the path to the desktop directory
    NSFileManager *fm = [NSFileManager defaultManager];
    NSArray *possibleURLs = [fm URLsForDirectory:NSDeveloperDirectory inDomains:NSUserDomainMask];
    NSURL *url = nil;
    if ([possibleURLs count] > 0) {
        // use first match
        url = possibleURLs[0];
    }
    
    if (url != nil) {
        // construct the unique subdirectory path
        NSString *dirName = [[NSBundle mainBundle] bundleIdentifier];
        url = [url URLByAppendingPathComponent:dirName isDirectory:YES];
        // make sure the unique directory exists
        NSError *error = nil;
        BOOL success = [fm createDirectoryAtURL:url withIntermediateDirectories:YES attributes:nil error:&error];
        if (!success) {
            NSLog(@"Could not create directory at: %@. Error %@", url, [error localizedDescription]);
            return nil;
        }
        
        // construct the file path
        NSString *filename = @"product-data.plist";
        url = [url URLByAppendingPathComponent:filename];
        
        // convert to NSString and return the result
        return [url path];
    } else {
        return nil;
    }
}

@end
