//
//  SCCCreateContactViewController.m
//  SCInbox
//
//  Created by Adrian Ortuzar on 30/09/16.
//  Copyright © 2016 Adrian Ortuzar. All rights reserved.
//

#import "SCCCreateContactViewController.h"
#import "Masonry.h"

@interface SCContactCreateFormRowView : UIView

@property (weak, nonatomic) IBOutlet UILabel *label;
@property (weak, nonatomic) IBOutlet UITextField *textField;

@end

@implementation SCContactCreateFormRowView

-(instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        
    }
    return self;
}
@end



@interface SCCCreateContactViewController ()

@property (nonatomic, strong) SCContactCreateFormRowView *emailRow;
@property (nonatomic, strong) SCContactCreateFormRowView *firstNameRow;
@property (nonatomic, strong) SCContactCreateFormRowView *lastNameRow;
@property (nonatomic, strong) SCContactCreateFormRowView *companyNameRow;

@end

@implementation SCCCreateContactViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    

    
    self.createButton.enabled = NO;
    
    
    // create rows
    self.emailRow = [[[NSBundle mainBundle] loadNibNamed:@"SCCCreateContactViewController" owner:self options:nil] lastObject];
    self.emailTextField = self.emailRow.textField;
    
    
    self.firstNameRow = [[[NSBundle mainBundle] loadNibNamed:@"SCCCreateContactViewController" owner:self options:nil] lastObject];
    self.firstNameRow.label.text = @"First Name";
    self.firstNameTextField = self.firstNameRow.textField;
    
    
    self.lastNameRow = [[[NSBundle mainBundle] loadNibNamed:@"SCCCreateContactViewController" owner:self options:nil] lastObject];
    self.lastNameRow.label.text = @"Last Name";
    self.lastNameTextField = self.lastNameRow.textField;
    
    
    self.companyNameRow = [[[NSBundle mainBundle] loadNibNamed:@"SCCCreateContactViewController" owner:self options:nil] lastObject];
    self.companyNameRow.label.text = @"Company";
    self.companyTextField = self.companyNameRow.textField;
    
    
    
    [self.view addSubview:self.emailRow];
    [self.view addSubview:self.firstNameRow];
    [self.view addSubview:self.lastNameRow];
    [self.view addSubview:self.companyNameRow];
    
    
    
        self.emailTextField.delegate = self;
        self.firstNameTextField.delegate = self;
        self.lastNameTextField.delegate = self;
        self.companyTextField.delegate = self;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.view.hidden = YES;
    
    
//    
    [self.emailRow mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).with.offset(30);
        make.right.equalTo(self.view);
        make.left.equalTo(self.view);
        make.height.equalTo(@40);
    }];
    
    [self.firstNameRow mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.emailRow).with.offset(45);
        make.right.equalTo(self.view);
        make.left.equalTo(self.view);
        make.height.equalTo(@40);
    }];

    [self.lastNameRow mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.firstNameRow).with.offset(45);
        make.right.equalTo(self.view);
        make.left.equalTo(self.view);
        make.height.equalTo(@40);
    }];

    [self.companyNameRow mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.lastNameRow).with.offset(45);
        make.right.equalTo(self.view);
        make.left.equalTo(self.view);
        make.height.equalTo(@40);
    }];
    
//    [self.createButton mas_updateConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(self.companyNameRow).with.offset(50);
//        make.right.equalTo(self.view);
//        make.left.equalTo(self.view);
//        make.bottom.equalTo(self.view);
//        make.width.equalTo(self.view);
//    }];
//    
    
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

@end


