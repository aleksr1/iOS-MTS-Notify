//
//  NewsTableViewCell.h
//  ParentMobile
//
//  Created by Justin Owens on 8/19/14.
//  Copyright (c) 2014 VisionCPS. All rights reserved.
//
#import <Parse/Parse.h>
#import <UIKit/UIKit.h>

@interface NewsTableViewCell : PFTableViewCell
@property (weak, nonatomic) IBOutlet UILabel *subjectLabel;
@property (weak, nonatomic) IBOutlet UILabel *bodyLabel;
@property (weak, nonatomic) IBOutlet UILabel *createdAtLabel;

@end
