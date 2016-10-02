//
//  SCShareViewController.h
//  ScauraApp
//
//  Created by Adrian Ortuzar on 21/09/16.
//  Copyright © 2016 developer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SCMailsCollectionView.h"
#import "SCSearchTableView.h"
#import "SCCCreateContactViewController.h"

@interface SCShareViewController : UIViewController <UITextFieldDelegate, SCMailsCollectionDelegate, UITableViewDelegate, SCCreateContactDelegate>

@end
