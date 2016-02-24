//
//  PlacesObject.h
//  PlaceDetails
//
//  Created by Darshan H V on 12/9/15.
//  Copyright © 2015 Darshan H V. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PlacesObject : NSObject

@property(strong,nonatomic)NSString *stateNameString;
@property(strong,nonatomic)NSString *capitalNameString;
@property(strong,nonatomic)NSString *areaString;
@property(strong,nonatomic)NSString *abbrevationStateNameString;
@property(strong,nonatomic)NSString *countryString;
@property(strong,nonatomic)NSString *largestCityString;

-(void)setObject:(NSDictionary *)placesDictionary;

@end
