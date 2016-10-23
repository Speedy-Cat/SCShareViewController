//
//  SCContactTableViewCell.h
//  SCInbox
//
//  Created by Adrian Ortuzar on 22/10/2016.
//  Copyright © 2016 Adrian Ortuzar. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SCContactTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *initialsLabel;

@property (weak, nonatomic) IBOutlet UIView *circleView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *emailLabel;

@end
