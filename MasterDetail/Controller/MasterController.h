//
//  MasterController.h
//  MasterDetail
//
//  Created by Michael Vilabrera on 1/24/17.
//  Copyright © 2017 Michael Vilabrera. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "ProductListData.h"
#import "DetailController.h"

@interface MasterController : NSObject <NSTableViewDataSource, NSTableViewDelegate>

@property (nonatomic) ProductListData *productList;

@property (weak) IBOutlet NSTableView *tableView;
@property (weak) IBOutlet DetailController *detailController;

- (IBAction)insertNewProduct:(id)sender;
- (IBAction)removeSelectedProduct:(id)sender;

- (void)saveSelectionToUserDefaults;

- (void)saveProductsToFile:(NSString *)path;

@end
