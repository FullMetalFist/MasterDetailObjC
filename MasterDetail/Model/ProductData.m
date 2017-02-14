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

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super init];
    if (self) {
        _name = [aDecoder decodeObjectForKey:@"name"];
        _price = [aDecoder decodeObjectForKey:@"price"];
        _numberOfSales = [aDecoder decodeIntegerForKey:@"numberOfSales"];
        _image = [aDecoder decodeObjectForKey:@"image"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:self.name forKey:@"name"];
    [aCoder encodeObject:self.price forKey:@"price"];
    [aCoder encodeInteger:self.numberOfSales forKey:@"numberOfSales"];
    [aCoder encodeObject:self.image forKey:@"image"];
}

@end
