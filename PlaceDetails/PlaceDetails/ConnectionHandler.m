//
//  ConnectionHandler.m
//  PlaceDetails
//
//  Created by Darshan H V on 12/9/15.
//  Copyright © 2015 Darshan H V. All rights reserved.
//

#import "ConnectionHandler.h"

@interface ConnectionHandler()
{
    NSMutableData * responseData ;
    asyncCompletionBlock_t completionBlock ;
    asyncErrorBlock_t errornousBlock ;
}
- (id) initWithRequest:(NSURLRequest *) request completionBlock:(asyncCompletionBlock_t) completeBlock errorBlock:(asyncErrorBlock_t) errorBlock ;


@end
@implementation ConnectionHandler

+ (id) request:(NSURLRequest *) request completionBlock:(asyncCompletionBlock_t) completeBlock errorBlock:(asyncErrorBlock_t) errorBlock {
    
    ConnectionHandler * connection = [[self alloc] initWithRequest:request
                                                           completionBlock:completeBlock
                                                                errorBlock:errorBlock] ;
    
    return connection ;
    
}

- (id) initWithRequest:(NSURLRequest *) request completionBlock:(asyncCompletionBlock_t) completeBlock errorBlock:(asyncErrorBlock_t) errorBlock {
    
    
    if (self = [super init]) {
        
        responseData = [[NSMutableData alloc] init] ;
        completionBlock = [completeBlock copy];
        errornousBlock = [errorBlock copy] ;
        
        [self startConnectionWithRequest:request];
        
    }
    
    return self ;
}


- (void) startConnectionWithRequest:(id) request {
    
    NSURLConnection * connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    
    [connection start];
    
}


- (BOOL)connection:(NSURLConnection *)conn canAuthenticateAgainstProtectionSpace:(NSURLProtectionSpace *)protectionSpace{
    // A delegate method called by the NSURLConnection when something happens with the
    // connection security-wise.  We defer all of the logic for how to handle this to
    // the ChallengeHandler module (and it's very custom subclasses).
    
    if ([protectionSpace authenticationMethod] == NSURLAuthenticationMethodNTLM) {
        return NO ;
    }
    
    return YES ;
}
-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    
    [responseData setLength:0];
    
    /**<Check If there is any protocol related Errors*/
    NSHTTPURLResponse *httpResponse = nil;
    httpResponse = (NSHTTPURLResponse *) response;
    
    /**Error code from 200 to 299 is Success status*/
    if([httpResponse statusCode] ==200){
        
        
    }
    else {
        
        /**If any error Cancel the connection*/
        [connection cancel] ;
        
        /**<Delegate NSError to View Controller*/
        NSError *err = nil;
        NSDictionary *dic = nil;
        
        err = [NSError errorWithDomain:@"Http Protocol Error"
                                  code:[httpResponse statusCode]
                              userInfo:dic];
        
        errornousBlock(err);
        
    }
    
    
}
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    
    [responseData appendData:data];
}
- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    
    /**<Cancel the connection if there are connection Errors*/
    
    [connection cancel] ;
    
    errornousBlock(error);
    
    /**<Delegate NSError to View Controller*/
    responseData = nil ;
}
- (void)connectionDidFinishLoading:(NSURLConnection *)connection{
    /**<Cancel the connection on connectionDidFinishLoading*/
    [connection cancel] ;
    
    /**<Send the response to Respective View Controllers*/
    
    completionBlock(responseData);
    responseData = nil ;
}

@end
