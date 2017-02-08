//
//  DetailController.h
//  MasterDetail
//
//  Created by Michael Vilabrera on 2/8/17.
//  Copyright © 2017 Michael Vilabrera. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "ProductData.h"

@interface DetailController : NSObject

@property (nonatomic) ProductData *product;

@property (weak) IBOutlet NSTextField *nameTextField;
@property (weak) IBOutlet NSTextField *priceTextField;
@property (weak) IBOutlet NSImageView *imageView;
@property (weak) IBOutlet NSButton *editImageButton;
@property (weak) IBOutlet NSTextField *numberOfSalesTextField;
@property (weak) IBOutlet NSButton *makeSaleButton;

- (IBAction)changeName:(id)sender;
- (IBAction)changePrice:(id)sender;
- (IBAction)changeImage:(id)sender;
- (IBAction)makeSale:(id)sender;

@end
