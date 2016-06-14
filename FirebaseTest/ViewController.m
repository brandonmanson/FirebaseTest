//
//  ViewController.m
//  FirebaseTest
//
//  Created by Brandon Manson on 6/13/16.
//  Copyright © 2016 DetroitLabs. All rights reserved.
//

#import "ViewController.h"


@interface ViewController ()
@property (strong, nonatomic) IBOutlet UILabel *userNameLabel;
@property (strong, nonatomic) IBOutlet UIImageView *userProfilePicture;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Facebook Login
    FBSDKLoginButton *loginButton = [[FBSDKLoginButton alloc] init];
    loginButton.readPermissions = @[@"email", @"public_profile"];
    [loginButton setDelegate:self];
    // Optional: Place the button in the center of your view.
    loginButton.center = self.view.center;
    [self.view addSubview:loginButton];
    [self getFIRUserProperties];
    
//    FIRDatabaseReference *ref = [[FIRDatabase database] reference];
//    FIRDatabaseReference *userRef = [ref child:@"user"];
//    NSLog(@"Before Set Value: %@", userRef);
//    NSDictionary *newUser = [NSDictionary dictionaryWithObjectsAndKeys:@"Brandon", @"firstName", @"Manson", @"lastName", nil];
//    FIRDatabaseReference *newUserRef = [userRef childByAutoId];
//    [newUserRef setValue:newUser];
//    
//    // Get user info
//    [[userRef child:@"-KKDeMy0WdkqCcD5_JLe"] observeSingleEventOfType:FIRDataEventTypeValue withBlock:^(FIRDataSnapshot *snapshot) {
//        NSLog(@"%@ %@", snapshot.value[@"firstName"], snapshot.value[@"lastName"]);
//    } withCancelBlock:^(NSError *error) {
//        NSLog(@"%@", error.localizedDescription);
//    }];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)loginButton:(FBSDKLoginButton *)loginButton didCompleteWithResult:(FBSDKLoginManagerLoginResult *)result error:(NSError *)error {
    if (error == nil) {
        NSLog(@"Logged in!");
        FIRAuthCredential *credential = [FIRFacebookAuthProvider credentialWithAccessToken:[FBSDKAccessToken currentAccessToken].tokenString];
        NSLog(@"%@", credential.description);
        if ([FIRAuth auth].currentUser) {
            [[FIRAuth auth].currentUser linkWithCredential:credential completion:^(FIRUser *user, NSError *error) {
                if (error) {
                    NSLog(@"%@", error.localizedDescription);
                }
            }];
        } else {
            [[FIRAuth auth] signInWithCredential:credential completion:^(FIRUser *user, NSError *error) {
                if (user) {
                    NSLog(@"%@", error.localizedDescription);
                }
            }];
        }
    } else {
        NSLog(@"%@", error.localizedDescription);
    }
}

- (void)getFIRUserProperties {
    FIRUser *user = [FIRAuth auth].currentUser;
    
    if (user != nil) {
        for (id<FIRUserInfo> profile in user.providerData) {
            NSString *providerID = profile.providerID;
            NSString *uid = profile.uid;
            NSString *name = profile.displayName;
            NSString *email = profile.email;
            NSURL *photoURL = profile.photoURL;
            NSLog(@"Provider ID: %@", providerID);
            NSLog(@"uid: %@", uid);
            NSLog(@"Name: %@", name);
            NSLog(@"Email: %@", email);
            NSLog(@"Photo URL: %@", [NSString stringWithFormat:@"%@", photoURL]);
            _userNameLabel.text = name;
            _userProfilePicture.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:photoURL]];
        }
    }
}

@end
