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
    // stop observing the old selected product's name
    if (self.detailController.product != nil) {
        [self.detailController.product removeObserver:self forKeyPath:@"name"];
    }
    
    if (self.tableView.selectedRow > -1) {
        self.detailController.product = [self.productList objectInProductsAtIndex:self.tableView.selectedRow];
        
        // start observing the new selected product's name
        if (self.detailController.product != nil) {
            [self.detailController.product addObserver:self forKeyPath:@"name" options:0 context:NULL];
        }
    } else {
        self.detailController.product = nil;
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
    
    // (removed table view updating code)
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
    
    // (removed table view updating code)
    
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
            
            NSIndexSet *indexes = change[NSKeyValueChangeIndexesKey];
            NSInteger index = [indexes firstIndex];
            
            if (changeType == NSKeyValueChangeInsertion) {
                // update the table view to match
                [self.tableView beginUpdates];
                [self.tableView insertRowsAtIndexes:[NSIndexSet indexSetWithIndex:index] withAnimation:NSTableViewAnimationSlideDown];
                [self.tableView scrollRowToVisible:index];
                [self.tableView endUpdates];
            } else if (changeType == NSKeyValueChangeRemoval) {
                // update the table view to match
                [self.tableView beginUpdates];
                [self.tableView removeRowsAtIndexes:[NSIndexSet indexSetWithIndex:index] withAnimation:NSTableViewAnimationEffectFade];
                [self.tableView scrollRowToVisible:index];
                [self.tableView endUpdates];
            }
        }
    }
    
    if ([object isKindOfClass:[ProductData class]] && [keyPath isEqualToString:@"name"]) {
        // the selected product's name changed, so refresh the row in the table
        NSIndexSet *indexSet = [NSIndexSet indexSetWithIndex:[self.productList indexOfObjectInProducts:object]];
        NSIndexSet *columnSet = [NSIndexSet indexSetWithIndex:0];
        [self.tableView reloadDataForRowIndexes:indexSet columnIndexes:columnSet];
    }
}

- (void)saveSelectionToUserDefaults {
    // get the current selection index
    NSInteger currentSelection = [self.tableView selectedRow];
    
    // save it with user defaults
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setInteger:currentSelection forKey:@"initalSelection"];
    
    NSLog(@"Saved selected row %li", currentSelection);
}

- (void)loadSelectionFromUserDefaults {
    // load the initial selection from NSUserDefaults
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSInteger initialSelection = [defaults integerForKey:@"initialSelection"];
    
    // update table view to match
    [self.tableView selectRowIndexes:[NSIndexSet indexSetWithIndex:initialSelection] byExtendingSelection:NO];
    
    NSLog(@"Loaded selected row %li", initialSelection);
}

- (void)saveProductsToFile:(NSString *)path {
    // archive the model as an NSData object
    NSData *archivedProducts = [NSKeyedArchiver archivedDataWithRootObject:self.productList];
    
    // save the NSData object
    [archivedProducts writeToFile:path atomically:YES];
    
    NSLog(@"Saved products %@\nTo file: %@", self.productList, path);
}

- (void)loadProductsFromFile:(NSString *)path {
    // stop observing the current ProductListData
    [self.productList removeObserver:self forKeyPath:@"products"];
    
    // load the NSData object
    NSData *archivedProducts = [NSData dataWithContentsOfFile:path];
    
    if (archivedProducts == nil) {
        // there are no saved products
        self.productList = [[ProductListData alloc] init];
        NSLog(@"No saved products");
    } else {
        // unarchive the model
        ProductListData *productList = [NSKeyedUnarchiver unarchiveObjectWithData:archivedProducts];
        self.productList = productList;
        NSLog(@"Loaded products : %@\nFrom file: %@", productList, path);
    }
    
    // start observing the new ProductListData
    [self.productList addObserver:self forKeyPath:@"products" options:0 context:NULL];
    
    // update the tableview
    [self.tableView reloadData];
}

@end
