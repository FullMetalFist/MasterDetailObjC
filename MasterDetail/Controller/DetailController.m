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
    
    NSLog(@"Displaying product %@", product.name);
}

@end
