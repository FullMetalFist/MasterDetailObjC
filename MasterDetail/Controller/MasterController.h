//
//  MasterController.h
//  MasterDetail
//
//  Created by Michael Vilabrera on 1/24/17.
//  Copyright © 2017 Michael Vilabrera. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "ProductListData.h"

@interface MasterController : NSObject <NSTableViewDataSource, NSTableViewDelegate>

@property (nonatomic) ProductListData *productList;

@property (weak) IBOutlet NSTableView *tableView;

@end
