//
//  CommunicationModule.h
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>



#define AM_DEFAULT_API_HOST         @"http://api.openweathermap.org"

@interface CommunicationModule : NSObject


- (void)weatherDetails;

+ (CommunicationModule*)manager;


@end
