//
//  SCFileCollectionViewCell.m
//  SCInbox
//
//  Created by Adrian Ortuzar on 30/09/16.
//  Copyright © 2016 Adrian Ortuzar. All rights reserved.
//

#import "SCFileCollectionViewCell.h"

@implementation SCFileCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    UIApplicationShortcutIcon *icon = [UIApplicationShortcutIcon iconWithType:UIApplicationShortcutIconTypeConfirmation];
    
    //[self addSubview:icon];
}

@end
