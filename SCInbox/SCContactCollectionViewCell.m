//
//  SCContactCollectionViewCell.m
//  SCInbox
//
//  Created by Adrian Ortuzar on 27/09/16.
//  Copyright © 2016 Adrian Ortuzar. All rights reserved.
//

#import "SCContactCollectionViewCell.h"

@implementation SCContactCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    
    self.label.textColor = [UIColor whiteColor];
    [self.roundview.layer setCornerRadius:15.0f];
    
    self.roundview.layer.borderWidth = 1;
    
    self.roundview.backgroundColor = [UIColor whiteColor];
    self.label.textColor =[UIColor blueColor];
    self.roundview.layer.borderColor = [UIColor blueColor].CGColor;//UIColor.redColor().CGColor
    
}

@end
