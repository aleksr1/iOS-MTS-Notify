//
//  SingleNewsViewController.h
//  ParentMobile
//
//  Created by Justin Owens on 8/20/14.
//  Copyright (c) 2014 VisionCPS. All rights reserved.
//
#import <Parse/Parse.h>
#import <UIKit/UIKit.h>
#import "NewsViewController.h"

@interface SingleNewsViewController : UIViewController
{
    
}
@property (nonatomic, strong) PFObject *passedNews;
@property (weak, nonatomic) IBOutlet UINavigationItem *subjectlabel;
@property (weak, nonatomic) IBOutlet UILabel *bodyLabel;

@end
