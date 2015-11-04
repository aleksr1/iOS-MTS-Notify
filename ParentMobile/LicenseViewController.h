//
//  LicenseViewController.h
//  MTS Notify
//
//  Created by Justin Owens on 1/16/15.
//  Copyright (c) 2015 VisionCPS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LicenseViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *eulaLabel;
@property (weak, nonatomic) IBOutlet UIButton *agreeButton;
@property (weak, nonatomic) IBOutlet UIButton *declineButton;
@property (weak, nonatomic) IBOutlet UILabel *otherLabel;

@end
