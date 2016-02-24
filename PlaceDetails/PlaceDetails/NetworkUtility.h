//
//  NetworkUtility.h
//  PlaceDetails
//
//  Created by Darshan H V on 12/9/15.
//  Copyright © 2015 Darshan H V. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^tFailureBlock)(NSError *error);
typedef void(^tSuccessBlock)(id response);

@interface NetworkUtility : NSObject

-(void)fetchPlacesDetailsWithString:(NSString *)placeSearchString success:(void (^)(id))successBlock
                            failure:(tFailureBlock)failureBlock;
@end
