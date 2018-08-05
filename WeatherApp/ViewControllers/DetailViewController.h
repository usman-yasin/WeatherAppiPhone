

#import <UIKit/UIKit.h>
#import "DBWeather.h"

@interface DetailViewController : UIViewController
@property (strong, nonatomic) IBOutlet UILabel *labelDay;
@property (strong, nonatomic) IBOutlet UILabel *labelDate;
@property (strong, nonatomic) IBOutlet UILabel *labelTemprature;
@property (strong, nonatomic) IBOutlet UILabel *labelDescription;

@property (strong, nonatomic) DBWeather *dbWeather;
@end
