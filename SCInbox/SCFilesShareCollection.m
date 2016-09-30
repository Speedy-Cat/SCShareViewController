//
//  SCFilesShareCollection.m
//  SCInbox
//
//  Created by Adrian Ortuzar on 30/09/16.
//  Copyright © 2016 Adrian Ortuzar. All rights reserved.
//

#import "SCFilesShareCollection.h"
#import "SCFileCollectionViewCell.h"


@interface SCFilesShareCollection()

@property (nonatomic, strong) NSArray *files;

@end

@implementation SCFilesShareCollection

-(instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        self.delegate = self;
        self.dataSource = self;
        
        [self registerNib:[UINib nibWithNibName:@"SCFileCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"fileCell"];
        
        self.files = @[@"a.jpg",@"b.jpg",@"c.jpg",@"d.jpg",@"e.jpg",@"f.jpg",@"g.jpg",@"h.jpg",@"i.jpg",
                       ];
    }
    return self;
}

#pragma mark - datasource

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.files.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    SCFileCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"fileCell" forIndexPath:indexPath];
    NSString *imagename = self.files[indexPath.row];
    cell.imageView.image = [UIImage imageNamed:imagename];
    
    return cell;
}

@end
