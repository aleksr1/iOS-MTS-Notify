//
//  SignUpViewController.h
//  ParentMobile
//
//  Created by Justin Owens on 8/18/14.
//  Copyright (c) 2014 VisionCPS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@interface SignUpViewController : UIViewController <UITextFieldDelegate>
{
    NSString *password, *confirmPassword, *name;
}
@property (weak, nonatomic) IBOutlet UITextField *usernameEntry;
@property (weak, nonatomic) IBOutlet UITextField *passwordEntry;
@property (weak, nonatomic) IBOutlet UITextField *confirmPasswordEntry;
@property (weak, nonatomic) IBOutlet UITextField *nameEntry;
- (IBAction)createUser:(id)sender;

@end
