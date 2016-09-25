//
//  SCShareLayout.m
//  SCInbox
//
//  Created by Adrian Ortuzar on 23/09/16.
//  Copyright © 2016 Adrian Ortuzar. All rights reserved.
//

#import "SCShareLayout.h"

@implementation SCShareLayout

-(CGSize)collectionViewContentSize
{
    return CGSizeMake(300, 300);
}

-(NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect
{
    NSMutableArray* elementsInRect = [NSMutableArray array];
    
    for(NSUInteger i = 0; i < [self.collectionView numberOfItemsInSection:0]; i++){
        //this is the cell at row j in section i
        CGRect cellFrame = CGRectMake(0, 0, 100, 100);
        
        NSIndexPath* indexPath = [NSIndexPath indexPathForRow:i inSection:0];
        UICollectionViewLayoutAttributes* attr = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
        
        attr.frame = cellFrame;
        
        [elementsInRect addObject:attr];
    }
    
    return elementsInRect;
}

-(UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewLayoutAttributes* attr = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    
    CGRect cellFrame = CGRectMake(0, 0, 100, 100);;
    attr.frame = cellFrame;
    
    return attr;
}


@end
