//
//  SCMailsCollectionView.h
//  
//
//  Created by Adrian Ortuzar on 26/09/16.
//
//

#import <UIKit/UIKit.h>

@protocol SCMailsCollectionDelegate <NSObject>

-(void)mailCollectionChangeMailText:(NSString*)mailText;

-(void)mailCollectionRemoveContact:(NSDictionary*)contact;

-(void)toTextFieldDidEndEditing;

-(void)toTextFieldShouldBeginEditing;

@end

@interface SCMailsCollectionView : UICollectionView <UICollectionViewDataSource, UICollectionViewDelegate, UITextFieldDelegate>

@property (nonatomic, strong) NSMutableArray *contacts;

@property (nonatomic, strong) UITextField *searchTextfield;

@property (nonatomic, weak) id <SCMailsCollectionDelegate> SCMailsDelegate;

-(BOOL)addContact:(NSDictionary*)contact;

@end
