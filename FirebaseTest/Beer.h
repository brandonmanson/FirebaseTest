//
//  Beer.h
//  FirebaseTest
//
//  Created by Brandon Manson on 6/16/16.
//  Copyright © 2016 DetroitLabs. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Beer : NSObject

@property (strong, nonatomic) NSString *uid;
@property (strong, nonatomic) NSString *beerName;

- (id)initWithBeerName:(NSString *)beerName;
+ (id)initWithBeerName:(NSString *)beerName;

@end
