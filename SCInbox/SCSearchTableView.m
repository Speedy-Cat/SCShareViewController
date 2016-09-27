//
//  SCSearchTableView.m
//  SCInbox
//
//  Created by Adrian Ortuzar on 26/09/16.
//  Copyright © 2016 Adrian Ortuzar. All rights reserved.
//

#import "SCSearchTableView.h"

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
        //self.delegate = self;
        self.dataSource = self;
    }
    return self;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (!self.contacts.count) {
        _noResults = YES;
        return 1;
    }
    else{
        _noResults = NO;
        return self.contacts.count;
    }
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MyIdentifier"];
    
    if (cell == nil) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"MyIdentifier"];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
    }
    
    if (_noResults) {
        cell.textLabel.text = @"Create New contact";
    }
    else{
        NSDictionary *contact = self.contacts[indexPath.row];
        cell.textLabel.text = [contact objectForKey:@"mail"];
    }
    
    return cell;
}


@end
