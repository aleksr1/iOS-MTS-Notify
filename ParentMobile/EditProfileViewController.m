//
//  EditProfileViewController.m
//  MTS Notify
//
//  Created by Justin Owens on 12/17/14.
//  Copyright (c) 2014 VisionCPS. All rights reserved.
//

#import "EditProfileViewController.h"

@interface EditProfileViewController ()

@end



@implementation EditProfileViewController

- (void) animateTextField: (UITextField*) textField up: (BOOL) up
{
    const float movementDuration = 0.3f; // tweak as needed
    
    
    [UIView beginAnimations: @"anim" context: nil];
    [UIView setAnimationBeginsFromCurrentState: YES];
    [UIView setAnimationDuration: movementDuration];
    
    [UIView commitAnimations];
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    [self animateTextField: textField up: YES];
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    [self animateTextField: textField up: NO];
}

- (void)appEnteredBackground
{
    [self.nameTextField resignFirstResponder];
    [self.emailTextField resignFirstResponder];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    PFUser *currentUser = [PFUser currentUser];
    
    _nameTextField.returnKeyType = UIReturnKeyDone;
    [_nameTextField setDelegate:self];
    
    _emailTextField.returnKeyType = UIReturnKeyDone;
    [_emailTextField setDelegate:self];
    
    _nameTextField.text = currentUser[@"name"];
    _emailTextField.text = currentUser[@"email"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [_nameTextField resignFirstResponder];
    [_emailTextField resignFirstResponder];
    
    
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [_nameTextField resignFirstResponder];
    [_emailTextField resignFirstResponder];
    return YES;
}


- (IBAction)submitButton:(id)sender {
    [[PFUser currentUser] fetchInBackgroundWithBlock:nil];
    PFUser *currentUser = [PFUser currentUser];
    currentUser[@"name"] = _nameTextField.text;
    currentUser.username = _emailTextField.text;
    currentUser.email = _emailTextField.text;
    
    [currentUser saveInBackground];
    
    [self performSegueWithIdentifier:@"profileSegue" sender:self];

}
@end
