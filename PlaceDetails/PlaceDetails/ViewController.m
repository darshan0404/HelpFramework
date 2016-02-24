//
//  ViewController.m
//  PlaceDetails
//
//  Created by Darshan H V on 12/9/15.
//  Copyright © 2015 Darshan H V. All rights reserved.
//

#import "ViewController.h"
#import "NetworkUtility.h"
#import "PlacesObject.h"
#import "PlacesDetailsViewController.h"
#import "Constants.h"

@interface ViewController () <UITableViewDelegate, UITableViewDataSource>

@property(nonatomic,strong)NetworkUtility *networkUtility;
@property(strong,nonatomic)NSMutableArray *placesDetailedArray;
@property (strong, nonatomic) IBOutlet UITableView *placesTableView;
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *serviceActivityIndicator;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self callPlacesService];
}


#pragma mark - Webservice Call
-(void)callPlacesService{
    [self.serviceActivityIndicator startAnimating];
    self.networkUtility = [[NetworkUtility alloc]init];
    
    [self.networkUtility fetchPlacesDetailsWithString:SEARCHTEXT success:^(NSMutableArray * placesList) {

        dispatch_async(dispatch_get_main_queue(), ^{
            // Update the UI on the main thread.
            if ([placesList count]!=0) {
                self.placesDetailedArray=[placesList mutableCopy];
                [self.placesTableView reloadData];
            }
            else{
                [self callAlertController:@"Failure" Message:@"Failed to fetch data currently" Action:@"OK"];
            }
        });
        
        [self.serviceActivityIndicator stopAnimating];
    }failure:^(NSError *error){
        dispatch_async(dispatch_get_main_queue(), ^{
            // Update the UI on the main thread.
            [self callAlertController:@"ERROR" Message:[error description] Action:@"OK"];
        });
        [self.serviceActivityIndicator stopAnimating];
    }];
}

#pragma mark - Alertcontroller
-(void)callAlertController:(NSString *)title Message:(NSString *)messageString Action:(NSString *)actionString{
    
    UIAlertController * alert=   [UIAlertController
                                  alertControllerWithTitle:title
                                  message:messageString
                                  preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* yesButton = [UIAlertAction
                                actionWithTitle:actionString
                                style:UIAlertActionStyleDefault
                                handler:^(UIAlertAction * action)
                                {
                                    [alert dismissViewControllerAnimated:YES completion:nil];
                                    
                                }];
    
    [alert addAction:yesButton];
    
    [self presentViewController:alert animated:YES completion:nil];
}


#pragma mark - Table View Data Source Methods
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.placesDetailedArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *simpleTableIdentifier = @"PlacesCellIdentifier";
    UITableViewCell *mCell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    mCell.textLabel.text=[[self.placesDetailedArray objectAtIndex:indexPath.row] stateNameString];
    mCell.detailTextLabel.text= [[self.placesDetailedArray objectAtIndex:indexPath.row] countryString];
    
    return mCell;
}

#pragma mark - TableViewDelegate Methods
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [self performSegueWithIdentifier:@"showPlacesDetails" sender:self];
}

#pragma mark - Segue Transistion
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([segue.identifier isEqualToString:@"showPlacesDetails"]){
        
        PlacesDetailsViewController *placesDetailsViewController = (PlacesDetailsViewController *)segue.destinationViewController;
        NSIndexPath *indexPath = [self.placesTableView indexPathForSelectedRow];
        placesDetailsViewController.placeDetailObject=[self.placesDetailedArray objectAtIndex:indexPath.row];
    
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
