//
//  SCSearchTableView.m
//  SCInbox
//
//  Created by Adrian Ortuzar on 26/09/16.
//  Copyright © 2016 Adrian Ortuzar. All rights reserved.
//

#import "SCSearchTableView.h"
#import "SCContactTableViewCell.h"

@interface SCSearchTableView ()

@property (nonatomic) BOOL noResults;

@end

@implementation SCSearchTableView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.dataSource = self;
        
        // register cell nib
        UINib *nib = [UINib nibWithNibName:@"SCContactTableViewCell" bundle:nil];
        [self registerNib:nib forCellReuseIdentifier:@"SCContactCell"];
        
        // separator lines
        [self setSeparatorStyle:UITableViewCellSeparatorStyleSingleLine];
        [self setSeparatorInset:UIEdgeInsetsZero];
    }
    return self;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
//    if (!self.contacts.count) {
//        _noResults = YES;
//        return 1;
//    }
//    else{
        _noResults = NO;
        return self.contacts.count;
//    }
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SCContactTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SCContactCell"];
    
    
    NSDictionary *contact = self.contacts[indexPath.row];
    NSString *email = [contact objectForKey:@"mail"];
    NSString *name = [contact objectForKey:@"name"];
    
    cell.emailLabel.text = email;
    cell.nameLabel.text = name;
    
    NSString *initials = ^NSString*(){
        NSArray *stringArr = [name componentsSeparatedByString:@" "];
        
        if (!stringArr.count || [name isEqualToString:@""]) {
            return [email substringToIndex:1];
        }
        else if(stringArr.count == 1){
            NSString *first = stringArr[0];
            return [first substringToIndex:1];
        }
        else{
            NSString *first = stringArr[0];
            NSString *second = stringArr[1];
            return [NSString stringWithFormat:@"%@%@", [first substringToIndex:1], [second substringToIndex:1]];
        }
    }();
    
    cell.initialsLabel.text = initials;
    


    return cell;
}



@end
