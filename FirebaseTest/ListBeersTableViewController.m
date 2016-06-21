//
//  ListBeersTableViewController.m
//  FirebaseTest
//
//  Created by Srinivas Bodhanampati on 6/20/16.
//  Copyright © 2016 DetroitLabs. All rights reserved.
//

#import "ListBeersTableViewController.h"
#import "ViewController.h"

@interface ListBeersTableViewController ()

@end

@implementation ListBeersTableViewController

- (void)viewDidLoad {
    [self listBeers];
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_listBeersFromFireBaseArray count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    UIImage *image1 = [UIImage imageNamed:@"beer-icon"];
    cell.imageView.image = image1;
    
    cell.textLabel.text = [_listBeersFromFireBaseArray objectAtIndex:indexPath.row];
    
    return cell;
}

-(void) listBeers {
    _listBeersFromFireBaseArray = [[NSMutableArray alloc]init];
    FIRDatabaseReference *ref = [[FIRDatabase database] reference];
    FIRDatabaseReference *beerRef = [ref child:@"beers"];
    
    [beerRef observeEventType:FIRDataEventTypeChildAdded withBlock:^(FIRDataSnapshot *snapshot) {
       for (FIRDataSnapshot *child in snapshot.children) {
            if ([child.key isEqualToString:@"beer_name"]) {
                [_listBeersFromFireBaseArray addObject:child.value];
            }
        }
        [self.tableView reloadData];
    }];
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
