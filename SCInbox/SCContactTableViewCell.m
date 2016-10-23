//
//  SCContactTableViewCell.m
//  SCInbox
//
//  Created by Adrian Ortuzar on 22/10/2016.
//  Copyright © 2016 Adrian Ortuzar. All rights reserved.
//

#import "SCContactTableViewCell.h"

@implementation SCContactTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    //
    self.circleView.layer.cornerRadius = self.circleView.frame.size.width / 2;
    self.circleView.layer.masksToBounds = YES;
    
    //
//    NSMutableAttributedString *attributedString;
//    attributedString = [[NSMutableAttributedString alloc] initWithString:@"AO"];
//    [attributedString addAttribute:NSKernAttributeName value:@5 range:NSMakeRange(10, 5)];
//    [self.initialsLabel setAttributedText:attributedString];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
