//
//  ProfileViewController.m
//  MTS Notify
//
//  Created by Justin Owens on 11/14/14.
//  Copyright (c) 2014 VisionCPS. All rights reserved.
//

#import "ProfileViewController.h"

@interface ProfileViewController ()

@end

@implementation ProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [[PFUser currentUser] fetchInBackgroundWithBlock:nil];
    PFUser *currentUser = [PFUser currentUser];
    
    self.nameLabel.text = currentUser[@"name"];
    self.emailLabel.text = currentUser[@"email"];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (IBAction)editButton:(id)sender {
    
    [self performSegueWithIdentifier:@"editSegue" sender:self];
}
@end
