//
//  Establishment.m
//  FirebaseTest
//
//  Created by Brandon Manson on 6/17/16.
//  Copyright © 2016 DetroitLabs. All rights reserved.
//

#import "Establishment.h"

@implementation Establishment

- (id)initWithEstablishmentName:(NSString *)name {
    self = [super init];
    if (self) {
        _establishmentName = name;
    }
    return self;
    
}

+ (id)initWithEstablishmentName:(NSString *)name {
    return [[super alloc] initWithEstablishmentName:name];
}

@end
