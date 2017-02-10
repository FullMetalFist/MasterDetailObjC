//
//  AppDelegate.h
//  MasterDetail
//
//  Created by Michael Vilabrera on 1/21/17.
//  Copyright © 2017 Michael Vilabrera. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "MasterController.h"

@interface AppDelegate : NSObject <NSApplicationDelegate>

@property (nonatomic) IBOutlet MasterController *masterController;

@end

