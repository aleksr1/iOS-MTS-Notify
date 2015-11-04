//
//  NotificationViewController.h
//  ParentMobile
//
//  Created by Justin Owens on 8/18/14.
//  Copyright (c) 2014 VisionCPS. All rights reserved.
//
#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
#import "NotificationTableViewCell.h"
#define IS_OS_8_OR_LATER ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)
@interface NotificationViewController : PFQueryTableViewController <UITableViewDataSource, UITableViewDelegate>



- (IBAction)showMenu:(id)sender;
- (IBAction)pushMenuItem:(id)sender;
- (IBAction)pushMenuItem1:(id)sender;


@end
