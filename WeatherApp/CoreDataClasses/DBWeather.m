

#import "DBWeather.h"
#import "NSDateAdditions.h"


@implementation DBWeather

@synthesize temp;
@synthesize tempMin;
@synthesize tempMax;
@synthesize humidity;
@synthesize description;
@synthesize date;
@synthesize tempCelcius;
@synthesize tempFahrenheit;
@synthesize day;
@synthesize isTempCelcius;

-(void)parse:(NSDictionary*)object
{
    self.date = [object valueForKeyPath:@"dt_txt"];
    NSArray * weatherArray = [object valueForKeyPath:@"weather"];
    NSDictionary* weatherObject = [weatherArray objectAtIndex:0];
    self.description = [weatherObject valueForKeyPath:@"description"];
    
    NSDictionary *main = [object valueForKey:@"main"];
    self.temp = [main valueForKeyPath:@"temp"];
    self.tempMin = [main valueForKeyPath:@"temp_min"];
    self.tempMax = [main valueForKeyPath:@"temp_max"];
    self.humidity = [main valueForKeyPath:@"humidity"];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"EEEE"];
    NSString *day = [dateFormatter stringFromDate:[NSDate dateFromString:self.date]];
    self.day = day;
    
    dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-dd-MM hh:mm:ss a"];
    NSString *date = [dateFormatter stringFromDate:[NSDate dateFromString:self.date]];
    self.date = date;
    
    self.tempFahrenheit = [self convertKelvinToFahrenheit:self.temp];
    self.tempCelcius = [self convertFahrenheitToCelcius:self.tempFahrenheit];
}

-(NSString*)convertKelvinToFahrenheit:(NSString*)kelvin
{
    NSString* formattedNumber = [NSString stringWithFormat:@"%.02f", [kelvin doubleValue] * 9/5 - 459.67];
    return formattedNumber;
}
-(NSString*)convertFahrenheitToCelcius:(NSString*)fahrenheit
{
    NSString* formattedNumber = [NSString stringWithFormat:@"%.02f",([fahrenheit doubleValue] -32)/1.8];
    return formattedNumber;
}
@end
