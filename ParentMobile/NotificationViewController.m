//
//  NotificationViewController.m
//  ParentMobile
//
//  Created by Justin Owens on 8/18/14.
//  Copyright (c) 2014 VisionCPS. All rights reserved.
//

#import "NotificationViewController.h"
#import "NotificationTableViewCell.h"
#import "KxMenu.h"
#import "AboutViewController.h"

@interface NotificationViewController ()
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NotificationTableViewCell *notificationCell;

@end

@implementation NotificationViewController

static NSString *NotificationCellIdentifier = @"NotificationCell";


- (id)initWithCoder:(NSCoder *)aCoder {
    self = [super initWithCoder:aCoder];
    if (self) {
        // This table displays items in the Todo class
        self.parseClassName = @"Notifications";
        self.pullToRefreshEnabled = YES;
        self.paginationEnabled = YES;
        self.objectsPerPage = 20;
    
    }
    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    PFUser *currentUser = [PFUser currentUser];
    PFInstallation *currentInstallation = [PFInstallation currentInstallation];
    currentInstallation[@"user"] = currentUser;
    [currentInstallation saveInBackground];
    PFRelation *relation = [currentUser relationForKey:@"installation"];
    [relation addObject:currentInstallation];
    [currentUser saveInBackground];
    
    UISwipeGestureRecognizer *swipeLeft = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(tappedRightButton:)];
    [swipeLeft setDirection:UISwipeGestureRecognizerDirectionLeft];
    [self.view addGestureRecognizer:swipeLeft];
    
    UISwipeGestureRecognizer *swipeRight = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(tappedLeftButton:)];
    [swipeRight setDirection:UISwipeGestureRecognizerDirectionRight];
    [self.view addGestureRecognizer:swipeRight];
    
    if(IS_OS_8_OR_LATER) {
        self.tableView.estimatedRowHeight = 75.0;
        self.tableView.rowHeight = UITableViewAutomaticDimension;

   }
    
}

- (void)viewWillAppear:(BOOL)animated
{
    if ([PFUser currentUser])
        [self loadObjects];
}



- (IBAction)tappedRightButton:(id)sender
{
    NSUInteger selectedIndex = [self.tabBarController selectedIndex];
    
    [self.tabBarController setSelectedIndex:selectedIndex + 1];
}

- (IBAction)tappedLeftButton:(id)sender
{
    NSUInteger selectedIndex = [self.tabBarController selectedIndex];
    
    [self.tabBarController setSelectedIndex:selectedIndex - 1];
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
    
    PFQuery *channelQuery = [PFQuery queryWithClassName:self.parseClassName];
    //[channelQuery whereKey:@"channels" containedIn:currentInstallation.channels];
    [channelQuery whereKey:@"channels" containedIn:[[PFInstallation currentInstallation]channels]];

    
    PFQuery *installationQuery = [PFQuery queryWithClassName:self.parseClassName];
    PFInstallation *currentInstallation = [PFInstallation currentInstallation];
    [installationQuery whereKey:@"installation" equalTo:currentInstallation];
    
    PFQuery *query = [PFQuery orQueryWithSubqueries:@[userQuery, installationQuery, channelQuery]];
    
    
    
    
    [query orderByDescending:@"createdAt"];
    //query.limit = 20;

    
    if (self.objects.count == 0) {
        query.cachePolicy = kPFCachePolicyCacheThenNetwork;
    }
    
    
    return query;
}


//setup cells in tableview
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.objects count];
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath object:(PFObject *)object
{
    //setup cell
    NotificationTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:NotificationCellIdentifier];
    if(!cell)
    {
        cell = [[NotificationTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NotificationCellIdentifier];
    }
    
    NSDate *date = [object createdAt];
    NSDateFormatter *dateFormate = [[NSDateFormatter alloc] init];
    [dateFormate setDateFormat:@"EEE, MMM d, HH:mm:ss zzz yyyy"];
    
    cell.messageLabel.text = object[@"message"];
    cell.createdAtLabel.text = [NSString stringWithFormat:[dateFormate stringFromDate:date]];
    
    
     return cell;
}





- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath object:(PFObject *)object
{
    
    NotificationTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"notificationCell"];
    if(!cell)
    {
        cell = [[NotificationTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"notificationCell"];
    }
    
    
    NSDate *date = [object createdAt];
    NSDateFormatter *dateFormate = [[NSDateFormatter alloc] init];
    [dateFormate setDateFormat:@"EEE, MMM d, HH:mm:ss zzz yyyy"];

    cell.messageLabel.text = object[@"message"];
    cell.createdAtLabel.text = [NSString stringWithFormat:[dateFormate stringFromDate:date]];
    
    [self.notificationCell layoutIfNeeded];
    
    CGFloat height = [self.notificationCell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height;
    
    return height + 1;

}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath object:(PFObject *)object
{
    return UITableViewAutomaticDimension;
}

- (IBAction) pushMenuItem:(id)sender
{
    [self performSegueWithIdentifier:@"aboutOneSegue" sender:self];
    }

- (IBAction) pushMenuItem1:(id)sender
{
    
    [self performSegueWithIdentifier:@"historyOneSegue" sender:self];
    
}

- (IBAction) pushMenuItem2:(id)sender
{
    
    [self performSegueWithIdentifier:@"profileOneSegue" sender:self];
    
}
- (IBAction) pushMenuItem3:(id)sender
{
    
    [self performSegueWithIdentifier:@"feedbackOneSegue" sender:self];
    
}


- (IBAction)showMenu:(UIButton *)sender {
    
    
    NSArray *menuItems =
    @[
      [KxMenuItem menuItem:@"About"
                     image:nil
                    target:self
                    action:@selector(pushMenuItem:)],
      
      [KxMenuItem menuItem:@"Notification Archive"
                     image:nil
                    target:self
                    action:@selector(pushMenuItem1:)],
      
      [KxMenuItem menuItem:@"Profile"
                     image:nil
                    target:self
                    action:@selector(pushMenuItem2:)],
      
      [KxMenuItem menuItem:@"Feedback"
                     image:nil
                    target:self
                    action:@selector(pushMenuItem3:)]
     ];
    
    KxMenuItem *first = menuItems[0];
    KxMenuItem *second = menuItems[2];
    KxMenuItem *third = menuItems[3];
    
    first.alignment = NSTextAlignmentCenter;
    second.alignment = NSTextAlignmentCenter;
    third.alignment = NSTextAlignmentCenter;
        
    [KxMenu showMenuInView:self.view
                  fromRect:sender.frame
                 menuItems:menuItems];
}



- (IBAction)unwindSegueToNotification: (UIStoryboardSegue *)segue {
    
    // Do Something With the Segue if Desired
    
}
@end
