//
//  SCCCreateContactViewController.m
//  SCInbox
//
//  Created by Adrian Ortuzar on 30/09/16.
//  Copyright © 2016 Adrian Ortuzar. All rights reserved.
//

#import "SCCCreateContactViewController.h"

@interface SCCCreateContactViewController ()


@end

@implementation SCCCreateContactViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.emailTextField.delegate = self;
    self.firstNameTextField.delegate = self;
    self.lastNameTextField.delegate = self;
    self.companyTextField.delegate = self;
    
    self.createButton.enabled = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if([_emailTextField.text length] && [_firstNameTextField.text length] && [_lastNameTextField.text length] && [_companyTextField.text length]){
        self.createButton.enabled = YES;
    }
    
    return YES;
}
- (IBAction)createAction:(id)sender {
    NSDictionary *contact = @{
                              @"mail":_emailTextField.text,
                              @"name":@""
                              };
    
    if([self.createContactDelegate respondsToSelector:@selector(didCreateContact:)]) {
        [self.createContactDelegate didCreateContact:contact];
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
