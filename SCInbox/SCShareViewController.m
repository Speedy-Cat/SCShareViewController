//
//  SCShareViewController.m
//  ScauraApp
//
//  Created by Adrian Ortuzar on 21/09/16.
//  Copyright © 2016 developer. All rights reserved.
//

#import "SCShareViewController.h"
#import "KGKeyboardChangeManager.h"
#import "Masonry.h"
#import "SCFilesShareCollection.h"


@interface SCShareViewController ()

@property (weak, nonatomic) IBOutlet UIView *toContainerView;
@property (weak, nonatomic) IBOutlet UIView *containerView;
@property (weak, nonatomic) IBOutlet UIScrollView *containerScrollView;
@property (strong, nonatomic) SCMailsCollectionView *mailsCollectionView;
@property (strong, nonatomic) NSMutableArray *contacts;
@property (strong, nonatomic) SCSearchTableView *searchTableView;
@property (weak, nonatomic) IBOutlet SCFilesShareCollection *filesCollection;
@property (nonatomic, strong) SCCCreateContactViewController *createContactVC;
@property (weak, nonatomic) IBOutlet UITextView *textView;

@end

@implementation SCShareViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.title = @"Share";
    
    self.contacts = [[NSMutableArray alloc] initWithArray:@[
                                                           @{
                                                               @"mail":@"john@gmail.com",
                                                               @"name":@"John Poe"},
                                                           @{
                                                               @"mail":@"daniel@gmail.com",
                                                               @"name":@"Daniel Ases"},
                                                           @{
                                                               @"mail":@"angel@gmail.com",
                                                               @"name":@"Daniel Ases"},
                                                           @{
                                                               @"mail":@"oscar@gmail.com",
                                                               @"name":@"Daniel Ases"},
                                                           @{
                                                               @"mail":@"roberto@gmail.com",
                                                               @"name":@"Daniel Ases"},
                                                           @{
                                                               @"mail":@"anguita@gmail.com",
                                                               @"name":@"Daniel Ases"},
                                                           @{
                                                               @"mail":@"juan@gmail.com",
                                                               @"name":@"juan Ases"}
                                                           ]];
    
    
    UIBarButtonItem *anotherButton = [[UIBarButtonItem alloc] initWithTitle:@"Send" style:UIBarButtonItemStylePlain target:self action:nil];
    
    UIBarButtonItem *closeButton = [[UIBarButtonItem alloc]
                                    initWithBarButtonSystemItem:(UIBarButtonSystemItemStop)
                                    target:self
                                    action:@selector(refreshPropertyList:)];
    
    self.navigationItem.leftBarButtonItem = closeButton;
    
    self.navigationItem.rightBarButtonItem = anotherButton;
    
    
    //
    // mails collection
    //
    self.mailsCollectionView = [[SCMailsCollectionView alloc] initWithFrame:CGRectMake(0, 0, self.toContainerView.frame.size.width, self.toContainerView.frame.size.height)];
    self.mailsCollectionView.backgroundColor = [UIColor whiteColor];
    self.mailsCollectionView.SCMailsDelegate = self;
    [self.toContainerView addSubview:self.mailsCollectionView];
    
    //
    // table search
    //
    self.searchTableView = [[SCSearchTableView alloc] initWithFrame:self.containerView.frame];
    self.searchTableView.hidden = YES;
    self.searchTableView.delegate = self;
    [self.containerView addSubview:self.searchTableView];

    
    // create contact vc
    self.createContactVC = [SCCCreateContactViewController new];
    self.createContactVC.createContactDelegate = self;
    [self.containerView addSubview:self.createContactVC.view];
    self.createContactVC.view.hidden = YES;
    [self addChildViewController:self.createContactVC];
    
    self.textView.delegate = self;
    //
    // keyboard observers
    //
    [[KGKeyboardChangeManager sharedManager] addObserverForKeyboardChangedWithBlock:^(BOOL show, CGRect keyboardRect, NSTimeInterval animationDuration, UIViewAnimationCurve animationCurve) {
        
        if (show) {
            
            [self.containerView mas_updateConstraints:^(MASConstraintMaker *make) {
                int heithg  = self.view.frame.size.height - self.toContainerView.frame.size.height - self.navigationController.navigationBar.frame.size.height - [UIApplication sharedApplication].statusBarFrame.size.height - keyboardRect.size.height;
                
                make.height.equalTo(@(heithg));
            }];
            
            [self.containerScrollView mas_updateConstraints:^(MASConstraintMaker *make) {
                int heithg  = self.view.frame.size.height - self.navigationController.navigationBar.frame.size.height - [UIApplication sharedApplication].statusBarFrame.size.height - keyboardRect.size.height;
                
                make.height.equalTo(@(heithg));
            }];
        }
        else{
            [self.containerView mas_updateConstraints:^(MASConstraintMaker *make) {
                int heithg  = self.view.frame.size.height - self.toContainerView.frame.size.height - self.navigationController.navigationBar.frame.size.height - [UIApplication sharedApplication].statusBarFrame.size.height;
                
                make.height.equalTo(@(heithg));
            }];
            
            [self.containerScrollView mas_updateConstraints:^(MASConstraintMaker *make) {
                int heithg  = self.view.frame.size.height - self.navigationController.navigationBar.frame.size.height - [UIApplication sharedApplication].statusBarFrame.size.height;
                
                make.height.equalTo(@(heithg));
            }];
        }
    }];
    

}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.containerView mas_updateConstraints:^(MASConstraintMaker *make) {
        int heithg  = self.view.frame.size.height - self.toContainerView.frame.size.height - self.navigationController.navigationBar.frame.size.height - [UIApplication sharedApplication].statusBarFrame.size.height;
        
        make.height.equalTo(@(heithg));
    }];
    
    
    [self.mailsCollectionView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.toContainerView);
        make.bottom.equalTo(self.toContainerView).with.offset(-1);
        make.right.equalTo(self.toContainerView).with.offset(-10);
        make.left.equalTo(self.toContainerView).with.offset(5);
    }];
    
    [self.searchTableView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.containerView);
    }];
    
    [self.createContactVC.view mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.containerView);
        make.bottom.equalTo(self.containerView);
        make.right.equalTo(self.containerView).with.offset(-170);
        make.left.equalTo(self.containerView).with.offset(170);
    }];
}

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    
    return YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)refreshPropertyList:(id)sender {
    //[[PNMApplicationManager sharedInstance].navigationController popViewControllerAnimated:YES];
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - SCMailsCollectionDelegate

-(void)mailCollectionChangeMailText:(NSString *)mailText
{
    if ([mailText isEqualToString:@""]) {
        self.searchTableView.hidden = YES;
        self.createContactVC.view.hidden = YES;
        return;
    }
    else{
        self.searchTableView.hidden = NO;
    }
    
    NSArray *result = [self searchEmailWithString:mailText];
    self.searchTableView.contacts = result;
    
    
    if(!result.count){
        // create contact
        self.createContactVC.view.hidden = NO;
        self.createContactVC.firstNameTextField.text = @"";
        self.createContactVC.lastNameTextField.text = @"";
        self.createContactVC.companyTextField.text = @"";
        
        self.createContactVC.emailTextField.text = mailText;
        
        //
        //self.searchTableView.hidden = YES;
        //self.textView.hidden =YES;
    }
    else{
        self.createContactVC.view.hidden = YES;
        self.searchTableView.hidden = NO;
        self.textView.hidden = NO;
    }
    
    [self.searchTableView reloadData];
}

-(void)mailCollectionRemoveContact:(NSDictionary*)contact
{
    [self.contacts addObject:contact];
}

#pragma mark - search table view delegate

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(self.searchTableView.contacts.count){
        NSDictionary *contact = self.searchTableView.contacts[indexPath.row];
        
        // add contact to mail collecion
        if([self.mailsCollectionView addContact:contact]){
            // remove contact from search table
            self.searchTableView.hidden = YES;
            [self.contacts removeObject:contact];
            
            //
            [self mailCollectionAdjustLayout];
        }
    }
}


-(NSArray*)searchEmailWithString:(NSString*)string
{
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF.mail CONTAINS %@ || self.name CONTAINS %@", string, string];
    NSArray *result = [self.contacts filteredArrayUsingPredicate:predicate];
    return result;
}

#pragma mark - create contact delegate

-(void)didCreateContact:(NSDictionary *)contact
{
    // add contact to mail collecion
    if([self.mailsCollectionView addContact:contact]){
        // remove contact from search table
        self.searchTableView.hidden = YES;
        self.createContactVC.view.hidden = YES;
        [self.contacts removeObject:contact];
        
        //
        [self mailCollectionAdjustLayout];
    }
}

#pragma mark - text view delegate

-(BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    if ([textView.text isEqualToString:@"Message"]) {
        textView.text = @"";
    }
    
    return YES;
}

-(void)textViewDidEndEditing:(UITextView *)textView
{
    if ([textView.text isEqualToString:@""]) {
        textView.text = @"Message";
    }
}

#pragma mark

-(void)mailCollectionAdjustLayout
{
    UICollectionViewCell *lastcell = [self.mailsCollectionView cellForItemAtIndexPath:[NSIndexPath indexPathForRow:self.self.mailsCollectionView.contacts.count - 1 inSection:0]];
    CGFloat height = lastcell.frame.origin.y + lastcell.frame.size.height;
    
    [self.view bringSubviewToFront:self.toContainerView];
    //self.toContainerView.backgroundColor = [UIColor redColor];
    [self.toContainerView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@(height + 1));
    }];
    
    [self.containerView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@(height+1));
    }];
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
