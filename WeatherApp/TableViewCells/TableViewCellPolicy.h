//
//  TableViewCellPolicy.h
//  EMT
//
//  Created by Faraz Siddiqui on 20/03/2015.
//  Copyright (c) 2015 Core Tech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TableViewCellPolicy : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *labelDate;
@property (strong, nonatomic) IBOutlet UILabel *labelDescription;
@property (strong, nonatomic) IBOutlet UILabel *labelTemprature;
@property (strong, nonatomic) IBOutlet UILabel *labelDay;


@end
