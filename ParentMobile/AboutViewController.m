//
//  AboutViewController.m
//  ParentMobile
//
//  Created by Justin Owens on 8/25/14.
//  Copyright (c) 2014 VisionCPS. All rights reserved.
//

#import "AboutViewController.h"
#import "AboutTableViewCell.h"

@interface AboutViewController ();

@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) AboutTableViewCell *aboutCell;
@end

@implementation AboutViewController

- (id)initWithCoder:(NSCoder *)aCoder {
    self = [super initWithCoder:aCoder];
    if (self) {
       
    }
    return self;
}



- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath /*object:(PFObject *)object*/
{
    AboutTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"AboutCell"];
    if(!cell){
        cell = [[AboutTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"AboutCell"];
    }

    
    return cell;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath 
{
    if(!self.aboutCell){
        
        self.aboutCell = [self.tableView dequeueReusableCellWithIdentifier:@"AboutCell"];
    }

    
    [self.aboutCell layoutIfNeeded];
    
    CGFloat height = [self.aboutCell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height;
    
    return height;
}




@end
