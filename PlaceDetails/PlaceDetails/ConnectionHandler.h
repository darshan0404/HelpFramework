//
//  ConnectionHandler.h
//  PlaceDetails
//
//  Created by Darshan H V on 12/9/15.
//  Copyright © 2015 Darshan H V. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^asyncCompletionBlock_t)(NSData *data); // COMPLETION BLOCK
typedef void (^asyncErrorBlock_t)(NSError *error);     // ERROR BLOCK

@interface ConnectionHandler : NSObject

+ (id) request:(NSURLRequest *) request completionBlock:(asyncCompletionBlock_t) completeBlock errorBlock:(asyncErrorBlock_t) errorBlock;



@end
