//
//  PlacesObject.m
//  PlaceDetails
//
//  Created by Darshan H V on 12/9/15.
//  Copyright © 2015 Darshan H V. All rights reserved.
//

#import "PlacesObject.h"
#import "Constants.h"
@implementation PlacesObject


-(void)setObject:(NSDictionary *)placesDictionary
{
    self.stateNameString=[placesDictionary objectForKey:STATENAME];
    self.capitalNameString=[placesDictionary objectForKey:CAPITAL];
    self.areaString=[placesDictionary objectForKey:AREA];
    self.abbrevationStateNameString=[placesDictionary objectForKey:ABBREVIATION];
    self.countryString=[placesDictionary objectForKey:COUNTRY];
    self.largestCityString=[placesDictionary objectForKey:LARGESTCITY];
}

@end
