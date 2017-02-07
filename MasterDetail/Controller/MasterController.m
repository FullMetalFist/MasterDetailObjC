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

- (void)tableViewSelectionDidChange:(NSNotification *)notification {
    NSInteger selectedRow = [self.tableView selectedRow];
    NSLog(@"Selected Row: %li", (long)selectedRow);
    if (selectedRow > -1) {
        ProductData *product = [self.productList objectInProductsAtIndex:selectedRow];
        NSLog(@"Selected product: %@", product.name);
    } else {
        NSLog(@"No selection");
    }
}

- (void)awakeFromNib {
    [self.tableView selectRowIndexes:[NSIndexSet indexSetWithIndex:1] byExtendingSelection:NO];
    
    [self.productList addObserver:self forKeyPath:@"products" options:0 context:NULL];
}

- (IBAction)insertNewProduct:(id)sender {
    // create the new product data
    ProductData *product = [[ProductData alloc] initWithName:@"New Product" price:[NSDecimalNumber decimalNumberWithString:@"1.99"]];
    
    // figure out the index to insert into (TODO)
    NSInteger index = self.tableView.selectedRow;
    if (index == -1) {
        // no selection, so insert at top of list
        index = 0;
    }
    
    // insert it into the model layer
    [self.productList insertObject:product inProductsAtIndex:index];
    
    // tell the table view it needs updating
    [self.tableView beginUpdates];
    [self.tableView insertRowsAtIndexes:[NSIndexSet indexSetWithIndex:index] withAnimation:NSTableViewAnimationSlideDown];
    [self.tableView scrollRowToVisible:index];
    [self.tableView endUpdates];
    
    // select the new row
    [self.tableView selectRowIndexes:[NSIndexSet indexSetWithIndex:index] byExtendingSelection:NO];
}

- (IBAction)removeSelectedProduct:(id)sender {
    NSInteger index = self.tableView.selectedRow;
    if (index == -1) {
        // no selection, leave as is
        return;
    }
    [self.productList removeObjectFromProductsAtIndex:index];
    
    // update the table view to match
    [self.tableView beginUpdates];
    [self.tableView removeRowsAtIndexes:[NSIndexSet indexSetWithIndex:index] withAnimation:NSTableViewAnimationEffectFade];
    [self.tableView scrollRowToVisible:index];
    [self.tableView endUpdates];
    
    // select a new row, if there are any left
    if ([self.productList countOfProducts] > 0) {
        NSInteger newIndex = index - 1;
        if (newIndex < 0) {
            newIndex = 0;
        }
        [self.tableView selectRowIndexes:[NSIndexSet indexSetWithIndex:newIndex] byExtendingSelection:NO];
    }
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    if (object == self.productList) {
        if ([keyPath isEqualToString:@"products"]) {
            
            // figure out what kind of change occurred
            NSNumber *changeTypeAsNumber = change[NSKeyValueChangeKindKey];
            NSKeyValueChange changeType = [changeTypeAsNumber intValue];
            
            if (changeType == NSKeyValueChangeSetting) {
                NSLog(@"Set a new value");  // not applicable for our example
            } else if (changeType == NSKeyValueChangeInsertion) {
                NSLog(@"Inserted product");
            } else if (changeType == NSKeyValueChangeRemoval) {
                NSLog(@"Removed a product");
            } else if (changeType == NSKeyValueChangeReplacement) {
                NSLog(@"Replaced a product");   // not applicable for our example
            }
        }
    }
}

@end
