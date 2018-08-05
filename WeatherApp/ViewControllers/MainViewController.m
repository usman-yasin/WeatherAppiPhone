
#import "MainViewController.h"
#import "TableViewCellPolicy.h"
#import "DBWeather.h"
#import "Defines.h"
#import "MBProgressHUD.h"
#import "Utility.h"
#import "CommunicationModule.h"
#import "NSDateAdditions.h"
#import "DetailViewController.h"

@interface MainViewController ()
@property(nonatomic, retain) NSMutableArray *arrayWeather;
@end

@implementation MainViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notificationWeather:) name:kNotificationWeather object:nil];
    }
    return self;
}

-(void)setLocalNotification
{
    UIUserNotificationType types = UIUserNotificationTypeBadge | UIUserNotificationTypeSound | UIUserNotificationTypeAlert;
    UIUserNotificationSettings *mySettings = [UIUserNotificationSettings settingsForTypes:types categories:nil];
    [[UIApplication sharedApplication] registerUserNotificationSettings:mySettings];
    
    UILocalNotification *notification = [[UILocalNotification alloc] init];
    if (notification)
    {
        notification.fireDate = [NSDate date];
        
        NSDate *fireTime = [[NSDate date] addTimeInterval:15]; // adds 15 secs
        notification.fireDate = fireTime;
        notification.alertBody = @"Weather app notification";
        
        notification.timeZone = [NSTimeZone defaultTimeZone];
        notification.applicationIconBadgeNumber = 1;
        notification.soundName = UILocalNotificationDefaultSoundName;
        notification.repeatInterval = NSCalendarUnitDay;
        notification.alertBody = @"Weather app notification";
    }
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
    [self.segmentTemprature addTarget:self
                         action:@selector(selectedIndexSegmentedAmount:)
               forControlEvents:UIControlEventValueChanged];
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [[CommunicationModule manager] weatherDetails];
    
    [self setLocalNotification];
}
-(void)viewWillAppear:(BOOL)animated
{
    [self.navigationController popToRootViewControllerAnimated:YES];
    self.navigationItem.title = @"Weather";
}
-(void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UI Handler

#pragma mark - UITableView Delegate & DataSource Method
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.arrayWeather count];
}
-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([cell respondsToSelector:@selector(setSeparatorInset:)])
    {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"TableViewCellPolicy";
    TableViewCellPolicy *cell = (TableViewCellPolicy *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    if (!cell)
    {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"TableViewCellPolicy" owner:nil options:nil] lastObject];
        cell.contentView.backgroundColor = [UIColor whiteColor];
        cell.labelDate.textColor = [UIColor grayColor];
    }
    
    DBWeather *dbWeather = [self.arrayWeather objectAtIndex:indexPath.row];
    if(self.segmentTemprature.selectedSegmentIndex==0){
        cell.labelTemprature.text = dbWeather.tempCelcius;
    }else{
        cell.labelTemprature.text = dbWeather.tempFahrenheit;
    }
    
    cell.labelDate.text = dbWeather.date;
    cell.labelDescription.text = dbWeather.description;
    cell.labelDay.text = dbWeather.day;
    cell.labelDate.text = dbWeather.date;
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    DetailViewController * controller = [[DetailViewController alloc] initWithNibName:@"DetailViewController" bundle:nil];
    DBWeather *dbWeatherTemp = [self.arrayWeather objectAtIndex:indexPath.row];
    if(self.segmentTemprature.selectedSegmentIndex==0){
        dbWeatherTemp.isTempCelcius = YES;
    }else{
        dbWeatherTemp.isTempCelcius = NO;
    }
    controller.dbWeather = dbWeatherTemp;
    [self.navigationController pushViewController:controller animated:YES];
}


#pragma mark - Notification Handlers
-(void)notificationWeather:(NSNotification*)notification
{
    [self performSelectorOnMainThread:@selector(notificationWeatherOnMainThread:) withObject:notification waitUntilDone:NO];
}
-(void)notificationWeatherOnMainThread:(NSNotification*)notification
{
    [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
    
    NSDictionary *userInfo = notification.userInfo;
    if ([[userInfo objectForKey:keyStatus] boolValue] == NO)
    {
        NSString *message = notification.object;
        if([message isEqualToString:@""])
        {
            message = @"Unknown error occured.";
        }
        
        [Utility showAlertWithMessage:@"Error occured."];
        return;
    }
    
    id responseData = notification.object;
    if([responseData isKindOfClass:[NSDictionary class]] == NO)
    {
        [Utility showAlertWithMessage:@"Unexpected response sent by server. Please try again after few minutes."];
        return;
    }
    
    NSArray *array = [responseData objectForKey:@"list"];
    self.arrayWeather = [NSMutableArray array];
    for(int i=0;i<[array count];i++){
        NSDictionary *result = [array objectAtIndex:i];
        DBWeather *dbWeather = [[DBWeather alloc] init];
        [dbWeather parse:result];
        
//        NSDateFormatter *format = [[NSDateFormatter alloc] init];
//        [format setDateFormat:@"yyyy-MM-dd"];
//        NSDate *date = [NSDate dateFromString:dbWeather.date];
        
        [self.arrayWeather addObject:dbWeather];
    }
    [self.tableViewWeather reloadData];
}

-(IBAction)selectedIndexSegmentedAmount:(UISegmentedControl*)sender
{
    switch (self.segmentTemprature.selectedSegmentIndex)
    {
        case 0:
            [self.tableViewWeather reloadData];
            break;
        case 1:
            [self.tableViewWeather reloadData];
            break;
        default:
            break;
    }
}

@end
