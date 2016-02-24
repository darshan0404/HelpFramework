//
//  NetworkUtility.m
//  PlaceDetails
//
//  Created by Darshan H V on 12/9/15.
//  Copyright © 2015 Darshan H V. All rights reserved.
//

#import "NetworkUtility.h"
#import "ConnectionHandler.h"
#import "PlacesObject.h"
#import "Constants.h"
@implementation NetworkUtility

-(void)fetchPlacesDetailsWithString:(NSString *)placeSearchString success:(tSuccessBlock)successBlock
                            failure:(tFailureBlock)failureBlock{
    
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://services.groupkt.com/state/search/ind?text=%@",placeSearchString]];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    [ConnectionHandler request:request completionBlock:^(NSData *data) {
        
        
        NSError * jsonError = nil ;
        NSDictionary * jsonData;
        id jsonResponse   = [NSJSONSerialization JSONObjectWithData:data
                                                            options:NSJSONReadingAllowFragments
                                                              error:&jsonError];
        if([jsonResponse isKindOfClass:[NSNull class]] ){
            successBlock(nil);
        }else{
            jsonData = (NSDictionary *)jsonResponse;
            
        }
        
        /*Parse object values from json to array */
        NSMutableArray *placeDetailsArray=[@[] mutableCopy];
        placeDetailsArray=[[jsonData objectForKey:RESTRESPONSE]objectForKey:RESULTS];
        
        NSMutableArray *placeslist=[@[] mutableCopy];
        for (NSDictionary *places in placeDetailsArray) {
            PlacesObject *placeObject=[[PlacesObject alloc]init];
            [placeObject setObject:places];
            [placeslist addObject:placeObject];
        }
        
        successBlock(placeslist);
        
    }errorBlock:^(NSError *error) {
        
        failureBlock(error);
       
    }];
}
@end
