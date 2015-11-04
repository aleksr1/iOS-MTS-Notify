//
//  FeedbackViewController.h
//  MTS Notify
//
//  Created by Justin Owens on 11/17/14.
//  Copyright (c) 2014 VisionCPS. All rights reserved.
//

#import <Parse/Parse.h> 
#import <UIKit/UIKit.h>

@interface FeedbackViewController : UIViewController <UITextFieldDelegate>
{
    NSString *message, *email, *deleted, *wantsContact;
    
}
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;
@property (weak, nonatomic) IBOutlet UITextField *feedbackTextField;
@property (weak, nonatomic) IBOutlet UITextField *emailTextField;
@property (weak, nonatomic) IBOutlet UISwitch *contactToggle;
@property (weak, nonatomic) IBOutlet UILabel *contactLabel;
-(IBAction)createFeedback:(id)sender;
@property (weak, nonatomic) IBOutlet UINavigationItem *backButton;

@end
