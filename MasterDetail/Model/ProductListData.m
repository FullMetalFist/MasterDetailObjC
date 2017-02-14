//
//  ProductListData.m
//  MasterDetail
//
//  Created by Michael Vilabrera on 1/22/17.
//  Copyright © 2017 Michael Vilabrera. All rights reserved.
//

#import "ProductListData.h"

@implementation ProductListData {
    NSMutableArray *_products;
}

- (id)init {
    self = [super init];
    if (self) {
        _products = [NSMutableArray array];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super init];
    if (self) {
        _products = [aDecoder decodeObjectForKey:@"products"];
    }
    return self;
}

- (NSUInteger)countOfProducts {
    return [_products count];
}

- (id)objectInProductsAtIndex:(NSUInteger)index {
    return _products[index];
}

- (void)insertObject:(id)object inProductsAtIndex:(NSUInteger)index {
    [_products insertObject:object atIndex:index];
}

- (void)removeObjectFromProductsAtIndex:(NSUInteger)index {
    [_products removeObjectAtIndex:index];
}

- (NSInteger)indexOfObjectInProducts:(id)product {
    return [_products indexOfObject:product];
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:_products forKey:@"products"];
}

@end
