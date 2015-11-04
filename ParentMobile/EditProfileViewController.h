//
//  EditProfileViewController.h
//  MTS Notify
//
//  Created by Justin Owens on 12/17/14.
//  Copyright (c) 2014 VisionCPS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@interface EditProfileViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UITextField *emailTextField;
- (IBAction)submitButton:(id)sender;



@end
