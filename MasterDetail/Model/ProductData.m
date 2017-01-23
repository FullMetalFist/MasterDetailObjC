//
//  ProductData.m
//  MasterDetail
//
//  Created by Michael Vilabrera on 1/22/17.
//  Copyright © 2017 Michael Vilabrera. All rights reserved.
//

#import "ProductData.h"

@implementation ProductData

- (id)initWithName:(NSString *)name price:(NSDecimalNumber *)price {
    self = [super init];
    if (self) {
        _name = name;
        _price = price;
    }
    return self;
}

@end
