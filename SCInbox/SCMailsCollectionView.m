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
    UICollectionViewCell *datasetCell =[collectionView cellForItemAtIndexPath:indexPath];
    [((SCContactCollectionViewCell*)datasetCell).textField becomeFirstResponder];
    ((SCContactCollectionViewCell*)datasetCell).textField.delegate = self;
    
    datasetCell.backgroundColor = [UIColor blueColor];
    
    
//    if(datasetCell.selected){
//        datasetCell.selected = NO;
//        datasetCell.backgroundColor = [UIColor clearColor];
//    }
//    else{
//        datasetCell.selected = YES;
//        datasetCell.backgroundColor = [UIColor blueColor];
//    }
}

-(void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath
{
//    UICollectionViewCell *datasetCell =[collectionView cellForItemAtIndexPath:indexPath];
//    datasetCell.backgroundColor = [UIColor clearColor];
//    NSLog(@"");
}

- (void)collectionView:(UICollectionView *)collectionView didUnhighlightItemAtIndexPath:(NSIndexPath *)indexPath
{
//    UICollectionViewCell *cell = [collectionView cellForItemAtIndexPath:indexPath];
//    cell.backgroundColor = [UIColor blackColor];
}

#pragma mark - helper functions

-(BOOL)addContact:(NSDictionary*)contact
{
    if ([self isContactExist:contact]) {
        return NO;
    }
    else{
        [self.contacts insertObject:contact atIndex:self.contacts.count - 1];
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
