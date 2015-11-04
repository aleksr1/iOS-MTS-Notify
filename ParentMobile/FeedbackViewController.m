//
//  FeedbackViewController.m
//  MTS Notify
//
//  Created by Justin Owens on 11/17/14.
//  Copyright (c) 2014 VisionCPS. All rights reserved.
//

#import "FeedbackViewController.h"

@interface FeedbackViewController ()

@end

@implementation FeedbackViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _feedbackTextField.returnKeyType = UIReturnKeyDone;
    [_feedbackTextField setDelegate:self];
    _emailTextField.returnKeyType = UIReturnKeyDone;
    [_emailTextField setDelegate:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    
    return YES;
}

-(IBAction)createFeedback:(id)sender
{
    PFObject *feedback = [PFObject objectWithClassName:@"Feedback"];
   
    message  = self.feedbackTextField.text;
    

    if ([message isEqualToString:@""])    {
        UIAlertView *alterViewNoFeedbackMessage = [[UIAlertView alloc] initWithTitle:@"Feedback missing" message:@"You must provide feedback before sending" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        
        [alterViewNoFeedbackMessage show];
    } else {
        if(self.contactToggle.on)
        {
            email = self.emailTextField.text;
            feedback[@"email"] = email;
            
            if ([email isEqualToString:@""])
            {
                UIAlertView *alterViewNoEmail = [[UIAlertView alloc] initWithTitle:@"Email missing" message:@"You must provide an email address to be reached at" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
                
                [alterViewNoEmail show];

            } else {
                
               
                
                email = self.emailTextField.text;
                feedback[@"message"] = message;
                feedback[@"email"] = email;
                feedback[@"wantsContact"] = @YES;
                feedback[@"deleted"] = @NO;
                feedback[@"contacted"] = @NO;
                [feedback saveInBackground];
                
                UIAlertView *alterViewFeedbackWithContactSuccess = [[UIAlertView alloc] initWithTitle:@"Success!" message:@"Thank you for your feedback!" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
                
                [alterViewFeedbackWithContactSuccess show];
                
                [self performSegueWithIdentifier:@"rewindFeedbackSegue" sender:self];
  
            }
        } else {
            
            feedback[@"message"] = message;
            
            feedback[@"wantsContact"] = @NO;
            feedback[@"deleted"] = @NO;
            feedback[@"contacted"] = @NO;
            [feedback saveInBackground];
            
            UIAlertView *alterViewFeedbackNoContactSuccess = [[UIAlertView alloc] initWithTitle:@"Success!" message:@"Thank you for your feedback!" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
            
            [alterViewFeedbackNoContactSuccess show];
            
            [self performSegueWithIdentifier:@"rewindFeedbackSegue" sender:self];

        }
    }
}

@end
