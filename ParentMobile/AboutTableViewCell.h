//
//  AboutTableViewCell.h
//  ParentMobile
//
//  Created by Justin Owens on 8/25/14.
//  Copyright (c) 2014 VisionCPS. All rights reserved.
//
#import <Parse/Parse.h>
#import <UIKit/UIKit.h>

@interface AboutTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;
@property (weak, nonatomic) IBOutlet UILabel *companyLabel;
@property (weak, nonatomic) IBOutlet UILabel *versionLabel;
@property (weak, nonatomic) IBOutlet UILabel *releaseLabel;
@property (weak, nonatomic) IBOutlet UILabel *updateLabel;
@end
