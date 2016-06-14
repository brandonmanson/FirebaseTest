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


@interface ViewController : UIViewController <FBSDKLoginButtonDelegate, FIRUserInfo>

- (void)getFIRUserProperties;

@end

