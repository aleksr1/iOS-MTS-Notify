//
//  NewsViewController.m
//  ParentMobile
//
//  Created by Justin Owens on 8/18/14.
//  Copyright (c) 2014 VisionCPS. All rights reserved.
//

#import "NewsViewController.h"
#import "KxMenu.h"
#import "AboutViewController.h"

@interface NewsViewController ()

@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NewsTableViewCell *newsCell;
@end

@implementation NewsViewController

- (id)initWithCoder:(NSCoder *)aCoder {
    self = [super initWithCoder:aCoder];
    if (self) {
        // This table displays items in the Todo class
        self.parseClassName = @"News";
        self.pullToRefreshEnabled = YES;
        self.paginationEnabled = YES;
        self.objectsPerPage = 25;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    UISwipeGestureRecognizer *swipeLeft = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(tappedRightButton:)];
    [swipeLeft setDirection:UISwipeGestureRecognizerDirectionLeft];
    [self.view addGestureRecognizer:swipeLeft];
    
    UISwipeGestureRecognizer *swipeRight = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(tappedLeftButton:)];
    [swipeRight setDirection:UISwipeGestureRecognizerDirectionRight];
    [self.view addGestureRecognizer:swipeRight];
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
    PFQuery *query = [PFQuery queryWithClassName:self.parseClassName];
    
    [query whereKey:@"channels" containedIn:[[PFInstallation currentInstallation]channels]];
    [query orderByDescending:@"createdAt"];

    if (self.objects.count == 0) {
        query.cachePolicy = kPFCachePolicyCacheThenNetwork;
    }
    [self.tableView reloadData];
  
    return query;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.objects count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath object:(PFObject *)object
{
    
    NewsTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"NewsCell"];
    if (!cell) {
        cell = [[NewsTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle
                                   reuseIdentifier:@"NewsCell"];
        
    }
    
    // Configure the cell to show todo item with a priority at the bottom
    NSDate *date = [object createdAt];
    NSDateFormatter *dateFormate = [[NSDateFormatter alloc] init];
    [dateFormate setDateFormat:@"EEE, MMM d, HH:mm:ss zzz yyyy"];
    cell.subjectLabel.text = object[@"subject"];
    cell.bodyLabel.text = object[@"message"];
    cell.createdAtLabel.text = [NSString stringWithFormat:[dateFormate stringFromDate:date]];

    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(!self.newsCell){
        self.newsCell = [self.tableView dequeueReusableCellWithIdentifier:@"NewsCell"];
    }
    PFObject *update = [self.objects objectAtIndex:indexPath.row];
    
    self.newsCell.subjectLabel.text = update[@"subject"];
    self.newsCell.bodyLabel.text = update[@"message"];
    
    [self.newsCell layoutIfNeeded];
    
    CGFloat height = [self.newsCell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height;
    return  height + 1;
    
}

- (IBAction) pushMenuItem:(id)sender
{
    [self performSegueWithIdentifier:@"aboutTwoSegue" sender:self];
    
}
- (IBAction) pushMenuItem1:(id)sender
{
    
    [self performSegueWithIdentifier:@"historyTwoSegue" sender:self];
    
}

- (IBAction) pushMenuItem2:(id)sender
{
    
    [self performSegueWithIdentifier:@"profileTwoSegue" sender:self];
    
}

- (IBAction) pushMenuItem3:(id)sender
{
    
    [self performSegueWithIdentifier:@"feedbackTwoSegue" sender:self];
    
}



- (void)showMenu:(UIButton *)sender
{
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
      
      [KxMenuItem menuItem:@"Profle"
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
                 menuItems:menuItems];}




- (IBAction)unwindSegueToNotification: (UIStoryboardSegue *)segue {
    
    // Do Something With the Segue if Desired
    
}



@end
