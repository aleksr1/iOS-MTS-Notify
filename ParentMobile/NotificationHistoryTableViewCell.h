//
//  NotificationHistoryTableViewCell.h
//  ParentMobile
//
//  Created by Justin Owens on 11/5/14.
//  Copyright (c) 2014 VisionCPS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NotificationHistoryTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *createdAtLabel;
@property (weak, nonatomic) IBOutlet UILabel *messageLabel;


@end
