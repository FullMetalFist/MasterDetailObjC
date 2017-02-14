//
//  ProductData.h
//  MasterDetail
//
//  Created by Michael Vilabrera on 1/22/17.
//  Copyright © 2017 Michael Vilabrera. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ProductData : NSObject <NSCoding>

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSDecimalNumber *price;
@property (nonatomic) NSImage *image;
@property (nonatomic) NSInteger *numberOfSales;

- (id)initWithName:(NSString *)name price:(NSDecimalNumber *)price;

@end
