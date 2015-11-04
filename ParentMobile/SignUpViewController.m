//
//  SignUpViewController.m
//  ParentMobile
//
//  Created by Justin Owens on 8/18/14.
//  Copyright (c) 2014 VisionCPS. All rights reserved.
//

#import "SignUpViewController.h"

@interface SignUpViewController ()

@end

@implementation SignUpViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void) animateTextField: (UITextField*) textField up: (BOOL) up
{
    const int movementDistance = 80; // tweak as needed
    const float movementDuration = 0.3f; // tweak as needed
    
    int movement = (up ? -movementDistance : movementDistance);
    
    [UIView beginAnimations: @"anim" context: nil];
    [UIView setAnimationBeginsFromCurrentState: YES];
    [UIView setAnimationDuration: movementDuration];
    self.view.frame = CGRectOffset(self.view.frame, 0, movement);
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


//This is called when the app goes into the background.
//We must reset the responder because animations will not be saved
- (void)appEnteredBackground{
    [self.usernameEntry resignFirstResponder];
    [self.passwordEntry resignFirstResponder];
    [self.confirmPasswordEntry resignFirstResponder];
    [self.nameEntry resignFirstResponder];
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _nameEntry.returnKeyType = UIReturnKeyDone;
    [_nameEntry setDelegate:self];
    _usernameEntry.returnKeyType = UIReturnKeyDone;
    [_usernameEntry setDelegate:self];
    _passwordEntry.returnKeyType = UIReturnKeyDone;
    [_passwordEntry setDelegate:self];
    _confirmPasswordEntry.returnKeyType = UIReturnKeyDone;
    [_confirmPasswordEntry setDelegate:self];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (IBAction)createUser:(id)sender {
    
    PFUser *user = [PFUser user];
    user[@"name"] = _nameEntry.text;
    user.username = _usernameEntry.text.lowercaseString;
    user.password = _passwordEntry.text;
    user.email = _usernameEntry.text.lowercaseString;
    
    password = _passwordEntry.text;
    confirmPassword = _confirmPasswordEntry.text;
    name = _nameEntry.text;
    
    if ([password isEqualToString:confirmPassword] && password.length >= 6 && ![name isEqualToString:@""])
    {
        [user signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error)
        {
            if (!error) {
                UIAlertView *alertViewSignupSuccess = [[UIAlertView alloc] initWithTitle:@"Success!Thank you for signing up"  message:@"Press OK to get started"
                                                                                delegate:self
                                                                       cancelButtonTitle:@"Ok"
                                                                       otherButtonTitles:nil, nil];
                [alertViewSignupSuccess show];
                
                
            } else {
                UIAlertView *alertViewLoginFailure = [[UIAlertView alloc] initWithTitle:@"Your signup information was invalid" message:@"Please try entering your information again"
                                                                               delegate:self
                                                                      cancelButtonTitle:@"Ok"
                                                                      otherButtonTitles:nil, nil];
                
                [alertViewLoginFailure show];
            }
        }];
        
    } else {
        UIAlertView *alertViewDifferentPassword = [[UIAlertView alloc] initWithTitle:@"Password Error" message:@"Password and re-entered password were different" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alertViewDifferentPassword show];
    }
    
}

-(void)alertView:(UIAlertView *)alertView willDismissWithButtonIndex:(NSInteger)buttonIndex{
    if (buttonIndex==0) {
        PFUser *currentUser = [PFUser currentUser];
        if (currentUser) {
            [self performSegueWithIdentifier:@"signedUpSegue" sender:self];
            
            
        } else {
            NSLog(@"failure");
        }
    }
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [_nameEntry resignFirstResponder];
    [_usernameEntry resignFirstResponder];
    [_passwordEntry resignFirstResponder];
    [_confirmPasswordEntry resignFirstResponder];
    
    
    
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [_nameEntry resignFirstResponder];
    [_usernameEntry resignFirstResponder];
    [_passwordEntry resignFirstResponder];
    [_confirmPasswordEntry resignFirstResponder];
    
    PFUser *user = [PFUser user];
    user.username = _usernameEntry.text.lowercaseString;
    user.password = _passwordEntry.text;
    user.email = _usernameEntry.text.lowercaseString;
    user[@"name"] = _nameEntry.text;
    
    password = _passwordEntry.text;
    confirmPassword = _confirmPasswordEntry.text;
    name = _nameEntry.text;
    
    if ([password isEqualToString:confirmPassword] && password.length >= 6 && ![name isEqualToString:@""]) {
        [user signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error){
            if (!error) {
                UIAlertView *alertViewSignupSuccess = [[UIAlertView alloc] initWithTitle:@"Success!Thank you for signing up"  message:@"Press OK to get started"
                                                                                delegate:self
                                                                       cancelButtonTitle:@"Ok"
                                                                       otherButtonTitles:nil, nil];
                [alertViewSignupSuccess show];
                
                
            } else {
                UIAlertView *alertViewLoginFailure = [[UIAlertView alloc] initWithTitle:@"Your signup information was invalid" message:@"Please try entering your information again"
                                                                               delegate:self
                                                                      cancelButtonTitle:@"Ok"
                                                                      otherButtonTitles:nil, nil];
                
                [alertViewLoginFailure show];
            }
        }];
        
    } else {
        UIAlertView *alertViewDifferentPassword = [[UIAlertView alloc] initWithTitle:@"Password Error" message:@"Password and re-entered password were different" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alertViewDifferentPassword show];
    }
    
    return YES;
    
}

@end
