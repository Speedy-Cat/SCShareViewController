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
#import "Masonry.h"

@interface SCShareViewController ()
@property (weak, nonatomic) IBOutlet UIView *toContainerView;
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
    //collection
    //
    self.mailsCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, self.toContainerView.frame.size.width, self.toContainerView.frame.size.height) collectionViewLayout:[[SCShareLayout alloc] init]];
    self.mailsCollectionView.backgroundColor = [UIColor redColor];
    [self.toContainerView addSubview:self.mailsCollectionView];
    
    

    
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
        make.edges.equalTo(self.toContainerView);
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
