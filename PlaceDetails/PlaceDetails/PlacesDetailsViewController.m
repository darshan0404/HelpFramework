//
//  PlacesDetailsViewController.m
//  PlaceDetails
//
//  Created by Darshan H V on 12/10/15.
//  Copyright © 2015 Darshan H V. All rights reserved.
//

#import "PlacesDetailsViewController.h"

@interface PlacesDetailsViewController ()
@property (strong, nonatomic) IBOutlet UILabel *stateLbl;
@property (strong, nonatomic) IBOutlet UILabel *capitalLbl;
@property (strong, nonatomic) IBOutlet UILabel *largestCityLbl;
@property (strong, nonatomic) IBOutlet UILabel *areaLbl;
@property (strong, nonatomic) IBOutlet UILabel *abbreviationLbl;
@property (strong, nonatomic) IBOutlet UILabel *countryLbl;

@end

@implementation PlacesDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self loadUIViewLabels];
}


-(void)loadUIViewLabels{
    self.stateLbl.text=self.placeDetailObject.stateNameString;
    self.capitalLbl.text=self.placeDetailObject.capitalNameString;
    self.capitalLbl.text=self.placeDetailObject.capitalNameString;
    self.largestCityLbl.text=self.placeDetailObject.largestCityString;
    self.areaLbl.text=self.placeDetailObject.areaString;
    self.abbreviationLbl.text=self.placeDetailObject.abbrevationStateNameString;
    self.countryLbl.text=self.placeDetailObject.countryString;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
