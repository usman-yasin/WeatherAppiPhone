
#import "DetailViewController.h"
#import "TableViewCellPolicy.h"
#import "DBWeather.h"
#import "Defines.h"
#import "MBProgressHUD.h"
#import "Utility.h"
#import "CommunicationModule.h"
#import "NSDateAdditions.h"

@interface DetailViewController ()
@property(nonatomic, retain) NSMutableArray *arrayWeather;
@end

@implementation DetailViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        
    }
    return self;
}

-(BOOL)shouldAutorotate
{
    return NO;
}

#pragma mark - ViewController Defaults
-(void)viewDidLoad
{
    [super viewDidLoad];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    [self displayDetail];
}

-(void)displayDetail
{
    self.labelDay.text = self.dbWeather.day;
    self.labelDate.text = self.dbWeather.date;
    self.labelDescription.text = self.dbWeather.description;
    
    if(self.dbWeather.isTempCelcius){
        self.labelTemprature.text = self.dbWeather.tempCelcius;
    }else{
        self.labelTemprature.text = self.dbWeather.tempFahrenheit;
    }
}
-(void)viewWillAppear:(BOOL)animated
{
    //[self.navigationController popToRootViewControllerAnimated:YES];
    self.navigationItem.title = @"Detail";
}
-(void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UI Handler

//-(void)pushToPolicyFormsViewController
//{
//    PolicyFormsViewController *controller = [[PolicyFormsViewController alloc] initWithNibName:@"PolicyFormsViewController" bundle:nil];
//    [self.navigationController pushViewController:controller animated:YES];
//}

@end
