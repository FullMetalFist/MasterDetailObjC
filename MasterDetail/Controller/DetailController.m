//
//  DetailController.m
//  MasterDetail
//
//  Created by Michael Vilabrera on 2/8/17.
//  Copyright © 2017 Michael Vilabrera. All rights reserved.
//

#import "DetailController.h"

@implementation DetailController

- (void)setProduct:(ProductData *)product {
    _product = product;
    [self synchronizeWithData];
}

- (void)synchronizeWithData {
    if (self.product == nil) {
        // nothing to display, so disable everything
        [self.nameTextField setEnabled:NO];
        [self.priceTextField setEnabled:NO];
        [self.imageView setEnabled:NO];
        [self.imageView setEditable:NO];
        [self.editImageButton setEnabled:NO];
        [self.makeSaleButton setEnabled:NO];
        
        self.nameTextField.stringValue = @"";
        self.priceTextField.stringValue = @"";
        self.imageView.image = nil;
        self.numberOfSalesTextField.stringValue = @"";
        return;
    }
    
    // make sure everything is enabled
    [self.nameTextField setEnabled:YES];
    [self.priceTextField setEnabled:YES];
    [self.imageView setEnabled:YES];
    [self.imageView setEditable:YES];
    [self.editImageButton setEnabled:YES];
    [self.makeSaleButton setEnabled:YES];
    
    // display everything
    self.nameTextField.stringValue = self.product.name;
    
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    [formatter setNumberStyle:NSNumberFormatterCurrencyStyle];
    self.priceTextField.stringValue = [formatter stringFromNumber:self.product.price];
    
    self.imageView.image = self.product.image;
    self.numberOfSalesTextField.stringValue = [NSString stringWithFormat:@"Sales: %ld", self.product.numberOfSales];
}

- (void)awakeFromNib {
    [self synchronizeWithData];
}

- (IBAction)changeName:(id)sender {
    self.product.name = self.nameTextField.stringValue;
    [self synchronizeWithData];
}

- (IBAction)changePrice:(id)sender {
    // string dollar sign
    NSString *priceAsString = [self.priceTextField.stringValue stringByReplacingOccurrencesOfString:@"$" withString:@""];
    self.product.price = [NSDecimalNumber decimalNumberWithString:priceAsString];
    [self synchronizeWithData];
}

- (IBAction)changeImage:(id)sender {
    self.product.image = self.imageView.image;
    [self synchronizeWithData];
}

- (IBAction)makeSale:(id)sender {
    self.product.numberOfSales += 1;
    [self synchronizeWithData];
}

- (IBAction)selectImageWithPanel:(id)sender {
    // configure the panel
    NSOpenPanel *panel = [NSOpenPanel openPanel];
    
    // show the panel
    [panel beginWithCompletionHandler:^(NSInteger result) {
        if (result == NSFileHandlingPanelOKButton) {
            NSURL *imageURL = [[panel URLs] objectAtIndex:0];
            NSImage *image = [[NSImage alloc] initWithContentsOfURL:imageURL];
            if (image != nil) {
                self.product.image = image;
                [self synchronizeWithData];
            } else {
                NSLog(@"Error loading image: %@", imageURL);
            }
        }
    }];
}

@end
