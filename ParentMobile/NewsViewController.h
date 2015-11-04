//
//  NewsViewController.h
//  ParentMobile
//
//  Created by Justin Owens on 8/18/14.
//  Copyright (c) 2014 VisionCPS. All rights reserved.
//
#import "NewsTableViewCell.h"
#import <Parse/Parse.h>
#import <UIKit/UIKit.h>
#import "SingleNewsViewController.h"
@interface NewsViewController : PFQueryTableViewController <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) NSArray *channels;
- (IBAction)showMenu:(id)sender;
- (IBAction)pushMenuItem:(id)sender;
@end

