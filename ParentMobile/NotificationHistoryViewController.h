//
//  NotificationHistoryViewController.h
//  ParentMobile
//
//  Created by Justin Owens on 11/3/14.
//  Copyright (c) 2014 VisionCPS. All rights reserved.
//
#import <Parse/Parse.h>
#import <UIKit/UIKit.h>

@interface NotificationHistoryViewController : PFQueryTableViewController <UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UINavigationItem *Back;

@end
