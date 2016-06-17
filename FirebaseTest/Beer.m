//
//  Beer.m
//  FirebaseTest
//
//  Created by Brandon Manson on 6/16/16.
//  Copyright © 2016 DetroitLabs. All rights reserved.
//

#import "Beer.h"

@implementation Beer

- (id)initWithBeerName:(NSString *)beerName {
    self = [super init];
    if (self) {
        _beerName = beerName;
    }
    return self;
}

+ (id)initWithBeerName:(NSString *)beerName {
    return [[super alloc] initWithBeerName:beerName];
}

@end
