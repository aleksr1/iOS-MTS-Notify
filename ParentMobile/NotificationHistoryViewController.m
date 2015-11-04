//
//  NotificationHistoryViewController.m
//  ParentMobile
//
//  Created by Justin Owens on 11/3/14.
//  Copyright (c) 2014 VisionCPS. All rights reserved.
//
#import <Parse/Parse.h>
#import "NotificationHistoryViewController.h"
#import "NotificationHistoryTableViewCell.h"



@interface NotificationHistoryViewController ()
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NotificationHistoryTableViewCell *notificationHistoryCell;

@end

@implementation NotificationHistoryViewController

static NSString *NotificationHistoryCellIdentifier = @"NotificationHistoryCell";



- (id)initWithCoder:(NSCoder *)aCoder {
    self = [super initWithCoder:aCoder];
    if (self) {
        // This table displays items in the Todo class
        self.parseClassName = @"Notifications";
        self.pullToRefreshEnabled = YES;
        self.paginationEnabled = NO;
        
    }
    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (PFQuery *)queryForTable
{
    PFQuery *userQuery = [PFQuery queryWithClassName:self.parseClassName];
    PFUser *currentUser = [PFUser currentUser];
    [userQuery whereKey:@"user" equalTo:currentUser];
    
    PFQuery *installationQuery = [PFQuery queryWithClassName:self.parseClassName];
    PFInstallation *currentInstallation = [PFInstallation currentInstallation];
    [installationQuery whereKey:@"installation" equalTo:currentInstallation];
    
    PFQuery *channelQuery = [PFQuery queryWithClassName:self.parseClassName];
    //[channelQuery whereKey:@"channels" containedIn:currentInstallation.channels];
    [channelQuery whereKey:@"channels" containedIn:[[PFInstallation currentInstallation]channels]];
    
    PFQuery *query = [PFQuery orQueryWithSubqueries:@[userQuery, installationQuery, channelQuery]];
    
    
    [query orderByDescending:@"createdAt"];
    query.skip = 21;
    
    
    if (self.objects.count == 0) {
        query.cachePolicy = kPFCachePolicyCacheThenNetwork;
    }
    
    
    return query;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.objects count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath object:(PFObject *)object
{
    NotificationHistoryTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"NotificationHistoryCell"];
    if(!cell){
        cell = [[NotificationHistoryTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"NotificationHistoryCell"];
    }
    
    NSDate *date = [object createdAt];
    NSDateFormatter *dateFormate = [[NSDateFormatter alloc] init];
    [dateFormate setDateFormat:@"EEE, MMM d, HH:mm:ss zzz yyyy"];

    cell.messageLabel.text = object[@"message"];
    cell.createdAtLabel.text = [NSString stringWithFormat:[dateFormate stringFromDate:date]];
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath object:(PFObject *)object
{
    NotificationHistoryTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"notificationHistoryCell"];
    if(!cell)
    {
       cell = [[NotificationHistoryTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"notificationHistoryCell"];
    }

    [self.notificationHistoryCell layoutIfNeeded];
    
    CGFloat height = [self.notificationHistoryCell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height;
    
    return height + 1;
}

@end


