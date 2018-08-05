//
//  DBWeather.h
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class DBWeather;

@interface DBWeather : NSManagedObject

@property (nonatomic, retain) NSString * temp;
@property (nonatomic, retain) NSString * tempMin;
@property (nonatomic, retain) NSString * tempMax;
@property (nonatomic, retain) NSString * humidity;
@property (nonatomic, retain) NSString * description;
@property (nonatomic, retain) NSString * date;
@property (nonatomic, retain) NSString * day;
@property (nonatomic, retain) NSString * tempCelcius;
@property (nonatomic, retain) NSString * tempFahrenheit;
@property BOOL isTempCelcius;

-(void)parse:(NSDictionary*)object;
-(NSString*)convertKelvinToFahrenheit:(NSString*)kelvin;
-(NSString*)convertFahrenheitToCelcius:(NSString*)fahrenheit;

@end
