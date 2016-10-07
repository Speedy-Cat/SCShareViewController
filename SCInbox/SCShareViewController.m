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
@property (strong, nonatomic) UILabel *mailsOverlay;
@property (nonatomic) CGRect keyboardFrame;

@end

@implementation SCShareViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.title = @"Share";
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSForegroundColorAttributeName:[UIColor blueColor]}];
    
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
    
    

    
    UIBarButtonItem *sendButton = ^UIBarButtonItem*(){
        // send button
        UIImage *faceImage = [UIImage imageNamed:@"Sent"];
        UIButton *face = [UIButton buttonWithType:UIButtonTypeCustom];
        CGFloat div = 1.3;
        face.bounds = CGRectMake( 0, 0, faceImage.size.width/div, faceImage.size.height/div);
        [face setImage:faceImage forState:UIControlStateNormal];
        return [[UIBarButtonItem alloc] initWithCustomView:face];
    }();
    
    
    
    UIBarButtonItem *closeButton = [[UIBarButtonItem alloc]
                                    initWithBarButtonSystemItem:(UIBarButtonSystemItemStop)
                                    target:self
                                    action:@selector(refreshPropertyList:)];
    
    self.navigationItem.leftBarButtonItem = closeButton;
    
    self.navigationItem.rightBarButtonItem = sendButton;
    
    self.navigationItem.rightBarButtonItem.enabled = NO;
    
    
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
    
    //
    // mails overlay label
    //
    self.mailsOverlay = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.toContainerView.frame.size.width, self.toContainerView.frame.size.height)];
    self.mailsOverlay.text = @"mails overlay";
    self.mailsOverlay.font = [UIFont fontWithName:@"Helvetica-Bold" size:16];
    self.mailsOverlay.backgroundColor = [UIColor whiteColor];
    self.mailsOverlay.hidden = YES;
    [self.toContainerView addSubview:self.mailsOverlay];

    
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
        
        self.keyboardFrame = keyboardRect;
        
        if (show) {
            
            [self.containerView mas_updateConstraints:^(MASConstraintMaker *make) {
                int heithg  = self.view.frame.size.height - self.toContainerView.frame.size.height - self.navigationController.navigationBar.frame.size.height - [UIApplication sharedApplication].statusBarFrame.size.height - keyboardRect.size.height;
                
                make.height.equalTo(@(heithg));
            }];
        }
        else{
            [self.containerView mas_updateConstraints:^(MASConstraintMaker *make) {
                int heithg  = self.view.frame.size.height - self.toContainerView.frame.size.height - self.navigationController.navigationBar.frame.size.height - [UIApplication sharedApplication].statusBarFrame.size.height;
                
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
    
    [self.mailsOverlay mas_updateConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.mailsCollectionView);
    }];
    
    UITapGestureRecognizer *singleFingerTap =
    [[UITapGestureRecognizer alloc] initWithTarget:self
                                            action:@selector(handleSingleTap:)];
    [self.mailsOverlay addGestureRecognizer:singleFingerTap];
    [self.mailsOverlay setUserInteractionEnabled:YES];
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [self.mailsCollectionView.searchTextfield becomeFirstResponder];
}

//The event handling method
- (void)handleSingleTap:(UITapGestureRecognizer *)recognizer {
    self.mailsOverlay.hidden = YES;
    [self mailCollectionAdjustLayout];
    
    [self.mailsCollectionView.searchTextfield becomeFirstResponder];
}

-(void)setTextMailOverlay
{
    NSMutableArray *contacts = [[NSMutableArray alloc] initWithArray:self.mailsCollectionView.contacts];
    [contacts removeObjectAtIndex:contacts.count -1];
    
    NSString *mailsString = @"";
    
    for (int i = 0; i < contacts.count; i++) {
        NSDictionary *contact = contacts[i];
        
        NSString *format = ^NSString*(){
            if (i == contacts.count -1) {
                return @"%@";
            }
            else{
                return @"%@, ";
            }
        }();
        
        mailsString = [mailsString stringByAppendingString:[NSString stringWithFormat:format, [contact objectForKey:@"mail"]]];
    }
    
    self.mailsOverlay.text = mailsString;
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
        
        [self mailCollectionAdjustLayout];
        
        return;
    }
    else{
        self.searchTableView.hidden = NO;
    }
    
    NSArray *result = [self searchEmailWithString:mailText];
    self.searchTableView.contacts = result;
    
    
    [self toCollectionOneLineLayoutInSearch:YES];
    
    
    if(!result.count){
        // create contact
        self.createContactVC.view.hidden = NO;
        self.createContactVC.firstNameTextField.text = @"";
        self.createContactVC.lastNameTextField.text = @"";
        self.createContactVC.companyTextField.text = @"";
        
        self.createContactVC.emailTextField.text = mailText;
        
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
    
    if (self.mailsCollectionView.contacts.count == 1) {
        self.navigationItem.rightBarButtonItem.enabled = NO;
    }
    
    //
    [self mailCollectionAdjustLayout];
}

-(void)toTextFieldDidEndEditing
{
    [self.mailsCollectionView deselectLastCellSelected];
}

-(void)toTextFieldShouldBeginEditing
{
    [self mailCollectionAdjustLayout];
    
    [self.mailsCollectionView deselectLastCellSelected];
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
            
            //
            self.navigationItem.rightBarButtonItem.enabled = YES;
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
        
        self.navigationItem.rightBarButtonItem.enabled = YES;
        
        //
        [self mailCollectionAdjustLayout];
    }
}

#pragma mark - text view delegate

-(BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    // textview placeholder
    if ([textView.text isEqualToString:@"Message:"]) {
        textView.text = @"";
        textView.textColor = [UIColor blackColor];
    }
    
    [self.mailsCollectionView deselectLastCellSelected];
    
    [self toCollectionOneLineLayoutInSearch:NO];
    
    [self setTextMailOverlay];
    
    if (self.mailsCollectionView.contacts.count > 1) {
        self.mailsOverlay.hidden = NO;
    }
    
    return YES;
}

-(void)textViewDidEndEditing:(UITextView *)textView
{
    // textview placeholder
    if ([textView.text isEqualToString:@""]) {
        textView.text = @"Message:";
        textView.textColor = [UIColor lightGrayColor];
    }
}

#pragma mark

-(void)mailCollectionAdjustLayout
{
    NSIndexPath *index = [NSIndexPath indexPathForRow:self.self.mailsCollectionView.contacts.count - 1 inSection:0];
    
    UICollectionViewLayoutAttributes *lastCelllayoutAtt = [self.mailsCollectionView layoutAttributesForItemAtIndexPath:index];
    
    
    if (lastCelllayoutAtt) {
        CGFloat height = lastCelllayoutAtt.frame.origin.y + lastCelllayoutAtt.frame.size.height;
        
        if (height + 1 == self.toContainerView.frame.size.height) {
            return;
        }
        
        
        [self.view bringSubviewToFront:self.toContainerView];
        
        [self.toContainerView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@(height + 1));
        }];
        
        dispatch_time_t delay = dispatch_time(DISPATCH_TIME_NOW, NSEC_PER_SEC * 0.1);
        dispatch_after(delay, dispatch_get_main_queue(), ^(void){
            [self.containerView mas_updateConstraints:^(MASConstraintMaker *make) {
                int heithg  = self.view.frame.size.height - self.toContainerView.frame.size.height - self.navigationController.navigationBar.frame.size.height - [UIApplication sharedApplication].statusBarFrame.size.height - self.keyboardFrame.size.height;
                make.height.equalTo(@(heithg));
            }];
        });
    }
    
}

-(void)toCollectionOneLineLayoutInSearch:(BOOL)isInSearch
{
    
    if(self.toContainerView.frame.size.height == 36){
        return;
    }
    
    int toViewHeight = ^int(){
        if (isInSearch) {
            return 50;
        }
        else{
            return 36;
        }
    }();
    
    [self.toContainerView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@(toViewHeight));
    }];
    
    dispatch_time_t delay = dispatch_time(DISPATCH_TIME_NOW, NSEC_PER_SEC * 0.1);
    dispatch_after(delay, dispatch_get_main_queue(), ^(void){
        [self.containerView mas_updateConstraints:^(MASConstraintMaker *make) {
            int heithg  = self.view.frame.size.height - self.toContainerView.frame.size.height - self.navigationController.navigationBar.frame.size.height - [UIApplication sharedApplication].statusBarFrame.size.height - self.keyboardFrame.size.height;
            make.height.equalTo(@(heithg));
        }];
        
       NSIndexPath *index  = [NSIndexPath indexPathForRow:self.mailsCollectionView.contacts.count - 1 inSection:0];
        [self.mailsCollectionView scrollToItemAtIndexPath:index atScrollPosition:UICollectionViewScrollPositionTop animated:NO];
    });
}

@end
