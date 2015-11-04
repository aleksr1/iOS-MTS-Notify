//
//  HomeViewController.h
//  ParentMobile
//
//  Created by Justin Owens on 8/18/14.
//  Copyright (c) 2014 VisionCPS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@interface HomeViewController : UIViewController <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *loginUsernameEntry;
@property (weak, nonatomic) IBOutlet UITextField *loginPasswordEntry;
- (IBAction)login:(id)sender;
- (IBAction)forgotPassword:(id)sender;
- (IBAction)signup:(id)sender;

@end
