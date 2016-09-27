//
//  SCMailsCollectionView.m
//  
//
//  Created by Adrian Ortuzar on 26/09/16.
//
//

#import "SCMailsCollectionView.h"
#import "SCShareLayout.h"
#import "SCSearchCollectionViewCell.h"
#import "SCContactCollectionViewCell.h"

@interface SCMailsCollectionView ()


@end

@implementation SCMailsCollectionView

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame collectionViewLayout:[[SCShareLayout alloc] init]];
    if (self) {
        self.delegate = self;
        self.dataSource = self;
        
        _contacts = [NSMutableArray new];
        [self.contacts addObject:@"textfield"];
        
        [self registerNib:[UINib nibWithNibName:@"SCSearchCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"searchCell"];
        [self registerNib:[UINib nibWithNibName:@"SCContactCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"contactCell"];
        
    }
    return self;
}


#pragma mark - data source

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.contacts.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    id contact = self.contacts[indexPath.row];
    
    if ([contact isKindOfClass:[NSString class]]) {
        
        SCSearchCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"searchCell" forIndexPath:indexPath];
        
        self.searchTextfield = cell.toTextField;
        [cell.toTextField becomeFirstResponder];
        cell.toTextField.delegate = self;
        
        return cell;
        
    }
    else{
        
        SCContactCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"contactCell" forIndexPath:indexPath];
        cell.label.text = [((NSDictionary*)contact) objectForKey:@"mail"];
        cell.backgroundColor = [UIColor greenColor];
        
        return cell;
        
    }
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    
    NSString * proposedNewString = [[textField text] stringByReplacingCharactersInRange:range withString:string];
    
    if([self.SCMailsDelegate respondsToSelector:@selector(mailCollectionChangeMailText:)]) {
        [self.SCMailsDelegate mailCollectionChangeMailText:proposedNewString];
    }
    
    return YES;
}

-(BOOL)addContact:(NSDictionary*)contact
{
    if ([self isContactExist:contact]) {
        return NO;
    }
    else{
        [self.contacts insertObject:contact atIndex:self.contacts.count - 1];
        self.searchTextfield.text = @"";
        [self reloadData];
        return YES;
    }
}

-(BOOL)isContactExist:(NSDictionary*)contact
{
    return [self.contacts containsObject:contact];
}

@end
