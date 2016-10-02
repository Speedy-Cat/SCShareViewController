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
        NSString *mail = [((NSDictionary*)contact) objectForKey:@"mail"];
        cell.label.text = mail;
        cell.textField.text = mail;
        cell.textField.delegate = self;
        
        return cell;
    }
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    UICollectionViewCell *cell = [[textField superview] superview];
    
    NSString * proposedNewString = [[textField text] stringByReplacingCharactersInRange:range withString:string];
    
    if([cell isKindOfClass:[SCContactCollectionViewCell class]]){
        
        NSString *contactmail = ((SCContactCollectionViewCell*)cell).label.text;
        NSIndexPath *indexPath = [self indexPathForCell:cell];
        
        // delete contact cell
        NSDictionary *contact = [self searchEmailWithString:contactmail][0];
        [self.contacts removeObject:contact];
        [self deleteItemsAtIndexPaths:@[indexPath]];
        [self.searchTextfield becomeFirstResponder];
        
        // notify removed contact
        if([self.SCMailsDelegate respondsToSelector:@selector(mailCollectionRemoveContact:)]) {
            [self.SCMailsDelegate mailCollectionRemoveContact:contact];
        }
    }
    else{
        // SCSearchCollectionViewCell
        // deselect cells
        NSArray *selectItems = self.indexPathsForSelectedItems;
        if (selectItems.count) {
            NSIndexPath *selectCellIndex = (NSIndexPath*)selectItems[0];
            [self deselectItemAtIndexPath:selectCellIndex animated:NO];
            SCContactCollectionViewCell *cell = (SCContactCollectionViewCell*)[self cellForItemAtIndexPath:selectCellIndex];
            cell.roundview.backgroundColor = [UIColor whiteColor];
            cell.label.textColor = [UIColor blueColor];
        }
    }
    
    if([self.SCMailsDelegate respondsToSelector:@selector(mailCollectionChangeMailText:)]) {
        [self.SCMailsDelegate mailCollectionChangeMailText:proposedNewString];
    }
    
    
    return YES;
}

-(NSArray*)searchEmailWithString:(NSString*)string
{
    NSMutableArray *contacts = [[NSMutableArray alloc] initWithArray:[self.contacts copy]];
    [contacts removeObjectAtIndex:contacts.count - 1];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF.mail == %@", string];
    NSArray *result = [contacts filteredArrayUsingPredicate:predicate];
    return result;
}

#pragma mark - collection delegate

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    SCContactCollectionViewCell *datasetCell = (SCContactCollectionViewCell*)[collectionView cellForItemAtIndexPath:indexPath];
    [datasetCell.textField becomeFirstResponder];
    
    datasetCell.roundview.backgroundColor = [UIColor blueColor];
    datasetCell.label.textColor = [UIColor whiteColor];
}

-(void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath
{
    SCContactCollectionViewCell *datasetCell = (SCContactCollectionViewCell*)[collectionView cellForItemAtIndexPath:indexPath];

    datasetCell.roundview.backgroundColor = [UIColor whiteColor];
    datasetCell.label.textColor = [UIColor blueColor];
}


#pragma mark - helper functions

-(BOOL)addContact:(NSDictionary*)contact
{
    if ([self isContactExist:contact]) {
        return NO;
    }
    else{
        [self.contacts insertObject:contact atIndex:0];
        self.searchTextfield.text = @"";
        [self insertItemsAtIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:0]]];
        return YES;
    }
}

-(BOOL)isContactExist:(NSDictionary*)contact
{
    return [self.contacts containsObject:contact];
}



@end
