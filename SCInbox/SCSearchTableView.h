//
//  SCSearchTableView.h
//  SCInbox
//
//  Created by Adrian Ortuzar on 26/09/16.
//  Copyright © 2016 Adrian Ortuzar. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SCSearchTableView : UITableView <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSArray *contacts;

@end
