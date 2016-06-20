//
//  Establishment.h
//  FirebaseTest
//
//  Created by Brandon Manson on 6/17/16.
//  Copyright © 2016 DetroitLabs. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Establishment : NSObject

@property (strong, nonatomic) NSString *uid;
@property (strong, nonatomic) NSString *establishmentName;

- (id)initWithEstablishmentName:(NSString *)name;
+ (id)initWithEstablishmentName:(NSString *)name;
@end
