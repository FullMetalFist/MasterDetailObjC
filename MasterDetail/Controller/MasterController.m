//
//  MasterController.m
//  MasterDetail
//
//  Created by Michael Vilabrera on 1/24/17.
//  Copyright © 2017 Michael Vilabrera. All rights reserved.
//

#import "MasterController.h"
#import "ProductData.h"

@implementation MasterController

- (id)init {
    self = [super init];
    if (self) {
        // create a new product list
        _productList = [[ProductListData alloc] init];
        
        // add some dummy data
        [_productList insertObject:[[ProductData alloc] initWithName:@"Coffee" price:[NSDecimalNumber decimalNumberWithString:@"1.99"]] inProductsAtIndex:0];
        [_productList insertObject:[[ProductData alloc] initWithName:@"Latte" price:[NSDecimalNumber decimalNumberWithString:@"3.49"]] inProductsAtIndex:1];
        [_productList insertObject:[[ProductData alloc] initWithName:@"Flat White" price:[NSDecimalNumber decimalNumberWithString:@"3.99"]] inProductsAtIndex:2];
    }
    return self;
}

- (NSInteger)numberOfRowsInTableView:(NSTableView *)tableView {
    return [self.productList countOfProducts];
}

- (NSView *)tableView:(NSTableView *)tableView viewForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row {
    // request a view for the cell
    NSTableCellView *cellView = [tableView makeViewWithIdentifier:@"ProductNameCell" owner:nil];
    // configure the view for the specified row
    ProductData *product = [self.productList objectInProductsAtIndex:row];
    cellView.textField.stringValue = product.name;
    // return the cell
    return cellView;
}

@end
