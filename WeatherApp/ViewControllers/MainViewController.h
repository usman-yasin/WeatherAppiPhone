//
//  MainViewController.h
//  EMS
//
//  Created by Faraz Siddiqui on 16/02/2015.
//  Copyright (c) 2015 Core Tech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DBWeather.h"
@interface MainViewController : UIViewController
<UITableViewDelegate,
UITableViewDataSource>
@property (strong, nonatomic) IBOutlet UITableView *tableViewWeather;
@property (strong, nonatomic) IBOutlet UISegmentedControl *segmentTemprature;

@end
