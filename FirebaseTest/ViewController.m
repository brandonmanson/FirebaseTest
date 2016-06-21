//
//  ViewController.m
//  FirebaseTest
//
//  Created by Brandon Manson on 6/13/16.
//  Copyright © 2016 DetroitLabs. All rights reserved.
//

#import "ViewController.h"
#import "ListBeersTableViewController.h"


@interface ViewController ()


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
    _beers = [[NSMutableArray alloc] init];
    _establishments = [[NSMutableArray alloc] init];
    
//    FIRDatabaseReference *ref = [[FIRDatabase database] reference];
//    FIRDatabaseReference *testRef = [ref child:@"test"].childByAutoId;
//    
//    NSDictionary *testObject = [NSDictionary dictionaryWithObjectsAndKeys:@"test", @"test", nil];
//    [testRef setValue:testObject];
//    [testRef observeEventType:FIRDataEventTypeChildAdded
//                    withBlock:^(FIRDataSnapshot *snapshot) {
//                        NSLog(@"Snapshot: %@", snapshot.value);
//                    }];

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

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_beers count];
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"beerCell" forIndexPath:indexPath];
    Beer *beerInCell = [_beers objectAtIndex:indexPath.row];
    cell.textLabel.text = beerInCell.beerName;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    Establishment *establishmentToAdd = [_establishments lastObject];
    Beer *beerAtSelectedIndex = [_beers objectAtIndex:indexPath.row];
    NSString *idOfBeerToUpdate = beerAtSelectedIndex.uid;
    FIRDatabaseReference *ref = [[FIRDatabase database] reference];
    FIRDatabaseReference *beerRef = [ref child:[NSString stringWithFormat:@"beers/%@", idOfBeerToUpdate]];
    FIRDatabaseReference *establishmentsRef = [beerRef child:@"establishments"];
    [establishmentsRef updateChildValues:@{[NSString stringWithFormat:@"%@", establishmentToAdd.uid]: @"true"}];
}

- (IBAction)addBeerButtonPressed:(UIButton *)sender {
    Beer *newBeer = [[Beer alloc] initWithBeerName:_beerTextField.text];
    FIRDatabaseReference *ref = [[FIRDatabase database] reference];
    FIRDatabaseReference *beerRef = [ref child:@"beers"].childByAutoId;
    NSDictionary *newBeerInfo = [NSDictionary dictionaryWithObjectsAndKeys:newBeer.beerName, @"beer_name", @"second value", @"second_value",  nil];
    [beerRef setValue:newBeerInfo];
    [beerRef observeEventType:FIRDataEventTypeChildAdded withBlock:^(FIRDataSnapshot *snapshot) {
        NSLog(@"Beer Snapshot Key: %@", snapshot.key);
        if ([snapshot.key isEqualToString:@"beer_name"]) {
            newBeer.uid = beerRef.key;
            [_beers addObject:newBeer];
            [_beersTableView reloadData];
            _latestBeerLabel.text = [NSString stringWithFormat:@"Latest Beer: %@", snapshot.value];
        }
    }];
    _beerTextField.text = @"";
}
- (IBAction)addEstablishmentButtonPressed:(UIButton *)sender {
    Establishment *newEstablishment = [[Establishment alloc]initWithEstablishmentName:@"Hopcat - Detroit"];
    FIRDatabaseReference *ref = [[FIRDatabase database] reference];
    FIRDatabaseReference *establishmentRef = [ref child:@"establishments"].childByAutoId;
    NSDictionary *newEstablishmentInfo = [NSDictionary dictionaryWithObjectsAndKeys:newEstablishment.establishmentName, @"establishment_name", nil];
    [establishmentRef setValue:newEstablishmentInfo];
    [establishmentRef observeEventType:FIRDataEventTypeChildAdded withBlock:^(FIRDataSnapshot *snapshot) {
        NSLog(@"Establishment Snapshot Key: %@", snapshot.key);
        if ([snapshot.key isEqualToString:@"establishment_name"]) {
            newEstablishment.uid = establishmentRef.key;
            [_establishments addObject:newEstablishment];
        }
    }];
}


- (IBAction)listBeersButton:(UIButton *)sender {
    
}



- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
//    [self listBeers];
//    ListBeersTableViewController *lbvc = [segue destinationViewController];
    
 //   lbvc.listBeersFromFireBaseArray = _listBeersArray;
    NSLog(@"Prepare for Segue triggered");
//    NSLog(@"%@", _listBeersArray);
//    NSLog(@"%@", lbvc.listBeersFromFireBaseArray);
}


@end
