//
//  SCCCreateContactViewController.h
//  SCInbox
//
//  Created by Adrian Ortuzar on 30/09/16.
//  Copyright © 2016 Adrian Ortuzar. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SCCreateContactDelegate <NSObject>

-(void)didCreateContact:(NSDictionary*)contact;

@end

@interface SCCCreateContactViewController : UIViewController <UITextFieldDelegate>

@property (nonatomic, weak) id <SCCreateContactDelegate> createContactDelegate;

@property (weak, nonatomic) IBOutlet UITextField *emailTextField;
@property (weak, nonatomic) IBOutlet UITextField *firstNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *lastNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *companyTextField;
@property (weak, nonatomic) IBOutlet UIButton *createButton;

@end


