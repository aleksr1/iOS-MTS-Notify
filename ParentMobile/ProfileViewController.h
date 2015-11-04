//
//  ProfileViewController.h
//  MTS Notify
//
//  Created by Justin Owens on 11/14/14.
//  Copyright (c) 2014 VisionCPS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
@interface ProfileViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *emailLabel;
- (IBAction)editButton:(id)sender;

@end
