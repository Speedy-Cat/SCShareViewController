//
//  SCShareViewController.m
//  ScauraApp
//
//  Created by Adrian Ortuzar on 21/09/16.
//  Copyright © 2016 developer. All rights reserved.
//

#import "SCShareViewController.h"
#import "KGKeyboardChangeManager.h"
#import "SCShareLayout.h"

@interface SCShareViewController ()
@property (weak, nonatomic) IBOutlet UIView *toContainerView;
@property (weak, nonatomic) IBOutlet UITextField *toTextField;
@property (weak, nonatomic) IBOutlet UIView *containerView;
@property (weak, nonatomic) IBOutlet UIScrollView *containerScrollView;
@property (strong, nonatomic) UICollectionView *mailsCollectionView;

@end

@implementation SCShareViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.title = @"Share";
    
    UIBarButtonItem *anotherButton = [[UIBarButtonItem alloc] initWithTitle:@"Next" style:UIBarButtonItemStylePlain target:self action:nil];
    
    UIBarButtonItem *closeButton = [[UIBarButtonItem alloc]
                                    initWithBarButtonSystemItem:(UIBarButtonSystemItemStop)
                                    target:self
                                    action:@selector(refreshPropertyList:)];
    
    self.navigationItem.leftBarButtonItem = closeButton;
    
    self.navigationItem.rightBarButtonItem = anotherButton;
    
    //
    self.toTextField.delegate = self;
    [self.toTextField becomeFirstResponder];
    
    
    
    //
    // keyboard observers
    //
    [[KGKeyboardChangeManager sharedManager] addObserverForKeyboardChangedWithBlock:^(BOOL show, CGRect keyboardRect, NSTimeInterval animationDuration, UIViewAnimationCurve animationCurve) {
        
        self.containerScrollView.frame = CGRectMake(0, 0, CGRectGetWidth(self.containerScrollView.frame), CGRectGetHeight(self.containerScrollView.frame) - CGRectGetHeight(keyboardRect));

    }];
    
    
    self.mailsCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, self.toContainerView.frame.size.width, self.toContainerView.frame.size.height) collectionViewLayout:[[SCShareLayout alloc] init]];
    self.mailsCollectionView.backgroundColor = [UIColor redColor];
    [self.toContainerView addSubview:self.mailsCollectionView];

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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
