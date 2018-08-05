//
//  AccelaRESTAPIs.m

//
//  Created by Syed Kamran Hassan on 9/3/13.
//  Copyright (c) 2013 CityGovApp.com. All rights reserved.
//

#import "CommunicationModule.h"
#import "Defines.h"
#import <MobileCoreServices/MobileCoreServices.h>


NSString* const AccelaAPIErrorDomain = @"AccelaAPIErrorDomain";


@interface CommunicationModule ()

@property (nonatomic, retain) NSOperationQueue *operationQueue;

@property UIBackgroundTaskIdentifier backgroundUpdateTask;

@end

@implementation CommunicationModule


+ (id)manager
{
    static CommunicationModule *accelaManager = nil;
	if(!accelaManager)
    {
		accelaManager = [[CommunicationModule alloc] init];
	}
    
	return accelaManager;
}


#pragma mark - Initialization
- (id)init
{
    if ((self = [super init]))
    {
        self.operationQueue = [[NSOperationQueue alloc] init] ;
    }
	return self;
}

#pragma mark - Public Functions

- (void)weatherDetails
{
    NSInvocationOperation *operation = [[NSInvocationOperation alloc] initWithTarget:self
                                                                            selector:@selector(getWeatherDetails)
                                                                              object:nil];
    
    [self.operationQueue addOperation:operation];
}
- (void)getWeatherDetails
{
    NSString *notificationName = kNotificationWeather;
    NSDictionary *userInfo = @{keyStatus : @NO};
    
    NS_DURING
    [[UIApplication sharedApplication] setIdleTimerDisabled:YES];
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
 
    NSError *error = nil;
    NSMutableString *urlWithParam = [NSMutableString stringWithFormat:@"%@/data/2.5/forecast?id=524901&apikey=ff894e4a508edb82c153d29c1bf608ac", AM_DEFAULT_API_HOST];
    NSURL *url = [NSURL URLWithString:urlWithParam];
    NSLog(@"weather url: %@", url);
    NSMutableURLRequest *request = [self getRequestForURL:url];
    [request setHTTPMethod:@"GET"];
    
    error = nil;
    NSHTTPURLResponse *response = nil;
    NSData *receivedData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    if([response statusCode] == 401)
    {
        return;
    }
    
    if(error)
    {
        NSString *errorMessage = [error localizedDescription];
        if(receivedData)
        {
            id responseData = [NSJSONSerialization JSONObjectWithData:receivedData options:NSJSONReadingMutableContainers error:&error];
            if(responseData)
            {
                NSInteger statusCode = [[responseData objectForKey:@"status"] intValue];
                if(statusCode == 401)
                {
                    errorMessage = [NSString stringWithFormat:@"%@\nResponse: %@", errorMessage, responseData];
                }
                errorMessage = [NSString stringWithFormat:@"%@\nResponse: %@", errorMessage, responseData];
            }
        }
        
        [[NSNotificationCenter defaultCenter] postNotificationName:notificationName object:errorMessage userInfo:userInfo];
        return;
    }
    if([response statusCode] != 200)
    {
        NSString *reason = [NSString stringWithFormat:@"%@", [[response allHeaderFields] objectForKey:@"x-accela-resp-message"]];
        if([reason isEqualToString:@""] || (id)reason == [NSNull null] || [reason isEqualToString:@"(null)"])
        {
            id responseData = [NSJSONSerialization JSONObjectWithData:receivedData options:NSJSONReadingMutableContainers error:&error];
            if(responseData)
            {
                reason = [NSString stringWithFormat:@"%@", responseData];
            }
            else
            {
                reason = @"Error occured at server.";
            }
        }
        [[NSNotificationCenter defaultCenter] postNotificationName:notificationName object:reason userInfo:userInfo];
        return;
    }
    
    error = nil;
    id responseData = [NSJSONSerialization JSONObjectWithData:receivedData options:NSJSONReadingMutableContainers error:&error];
    if (error)
    {
        [[NSNotificationCenter defaultCenter] postNotificationName:notificationName object:[error localizedDescription] userInfo:userInfo];
        return;
    }
    //NSLog(@"%@", [responseData bv_jsonStringWithPrettyPrint:YES]);
    
    userInfo = @{ keyStatus : @YES };
    [[NSNotificationCenter defaultCenter] postNotificationName:notificationName object:responseData userInfo:userInfo];
    
    NS_HANDLER
    [[NSNotificationCenter defaultCenter] postNotificationName:notificationName object:[localException reason] userInfo:userInfo];
    NS_ENDHANDLER
    @finally
    {
        [[UIApplication sharedApplication] setIdleTimerDisabled:NO];
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    }
}

- (NSMutableURLRequest*)getRequestForURL:(NSURL*)url
{
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:60.0];
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    return request;
}
@end
