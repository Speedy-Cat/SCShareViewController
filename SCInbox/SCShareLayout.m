//
//  SCShareLayout.m
//  SCInbox
//
//  Created by Adrian Ortuzar on 23/09/16.
//  Copyright © 2016 Adrian Ortuzar. All rights reserved.
//

#import "SCShareLayout.h"
#import "SCMailsCollectionView.h"

@implementation SCShareLayout

-(CGSize)collectionViewContentSize
{
    return self.collectionView.frame.size;
}

-(NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect
{
    NSMutableArray* elementsInRect = [NSMutableArray array];
    
    for(NSUInteger i = 0; i < ((SCMailsCollectionView *)self.collectionView).contacts.count; i++){
        id contact = ((SCMailsCollectionView *)self.collectionView).contacts[i];
        
        UICollectionViewLayoutAttributes *lastAtt;
        if(elementsInRect.count){
            lastAtt = elementsInRect[i - 1];
        }
        
        CGRect cellFrame;
        
        int marginRight = 3;
        
        if([contact isKindOfClass:[NSString class]]){
            
            
            
            if (lastAtt) {
                CGFloat x = lastAtt.frame.origin.x + lastAtt.frame.size.width + marginRight;
                CGFloat width = self.collectionView.frame.size.width - lastAtt.frame.size.width;
                cellFrame = CGRectMake(x, 0, width, self.collectionView.frame.size.height);
            }
            else{
                cellFrame = CGRectMake(0, 0, self.collectionView.frame.size.width, self.collectionView.frame.size.height);
            }
            
            
        }
        else{
            NSString *mail = [((NSDictionary*)contact) objectForKey:@"mail"];
            
            CGFloat size = [self widthOfString:mail withFont:[UIFont fontWithName:@"Helvetica" size:16]];
            CGFloat padding = 8 * 2;
            
            
            
            if (lastAtt) {
                CGFloat x = lastAtt.frame.origin.x + lastAtt.frame.size.width + marginRight;
                cellFrame = CGRectMake(x, 0, size + padding, self.collectionView.frame.size.height);
            }
            else{
                cellFrame = CGRectMake(0, 0, size + padding, self.collectionView.frame.size.height);
            }
        }
        
        NSIndexPath* indexPath = [NSIndexPath indexPathForRow:i inSection:0];
        UICollectionViewLayoutAttributes* attr = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
        attr.frame = cellFrame;
        [elementsInRect addObject:attr];
        
        
    }
    
    return elementsInRect;
}

- (CGFloat)widthOfString:(NSString *)string withFont:(UIFont *)font {
    NSDictionary *attributes = [NSDictionary dictionaryWithObjectsAndKeys:font, NSFontAttributeName, nil];
    return [[[NSAttributedString alloc] initWithString:string attributes:attributes] size].width;
}

//-(UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath
//{
//    UICollectionViewLayoutAttributes* attr = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
//    
//    CGRect cellFrame = CGRectMake(0, 0, 100, 100);;
//    attr.frame = cellFrame;
//    
//    return attr;
//}


@end
