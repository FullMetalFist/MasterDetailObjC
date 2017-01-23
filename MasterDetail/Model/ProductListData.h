//
//  ProductListData.h
//  MasterDetail
//
//  Created by Michael Vilabrera on 1/22/17.
//  Copyright © 2017 Michael Vilabrera. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ProductData.h"

@interface ProductListData : NSObject

// KVO-enabling methods
- (NSUInteger)countOfProducts;
- (id)objectInProductsAtIndex:(NSUInteger)index;
- (void)insertObject:(id)object inProductsAtIndex:(NSUInteger)index;
- (void)removeObjectFromProductsAtIndex:(NSUInteger)index;

// Other useful methods
- (NSInteger)indexOfObjectInProducts:(id)product;

@end
