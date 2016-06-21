//
//  ViewController.h
//  FirebaseTest
//
//  Created by Brandon Manson on 6/13/16.
//  Copyright © 2016 DetroitLabs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Firebase/Firebase.h>
#import <FirebaseAuth/FirebaseAuth.h>
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import "Beer.h"
#import "Establishment.h"


@interface ViewController : UIViewController <FBSDKLoginButtonDelegate, FIRUserInfo, UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) NSMutableArray *beers;
@property (strong, nonatomic) NSMutableArray *establishments;

@property (strong, nonatomic) IBOutlet UILabel *userNameLabel;
@property (strong, nonatomic) IBOutlet UIImageView *userProfilePicture;
@property (strong, nonatomic) IBOutlet UITextField *beerTextField;
@property (strong, nonatomic) IBOutlet UITableView *beersTableView;
@property (strong, nonatomic) IBOutlet UILabel *latestBeerLabel;
@property (strong, nonatomic) NSMutableArray *listBeersArray;

- (void)getFIRUserProperties;

@end

