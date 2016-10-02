//
//  SCShareLayout.m
//  SCInbox
//
//  Created by Adrian Ortuzar on 23/09/16.
//  Copyright © 2016 Adrian Ortuzar. All rights reserved.
//

#import "SCShareLayout.h"
#import "SCMailsCollectionView.h"

@interface SCShareLayout ()

@property (nonatomic, strong) NSArray *layoutAttributes;

@end

@implementation SCShareLayout

-(CGSize)collectionViewContentSize
{
    
    CGFloat width;
    NSArray *layoutAttributes = self.layoutAttributes;
    if(layoutAttributes.count){
        UICollectionViewLayoutAttributes *lastatt = (UICollectionViewLayoutAttributes*)layoutAttributes[layoutAttributes.count - 1];
        width = lastatt.frame.origin.x + lastatt.frame.size.width;
    }
    else{
        width = 0;
    }
    
    
    return CGSizeMake(width, self.collectionView.frame.size.height);
}


-(NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect
{
    NSMutableArray* elementsInRect = [NSMutableArray array];
    NSArray *layoutAttributes = self.layoutAttributes;
    
    for(NSUInteger i = 0; i < layoutAttributes.count; i++){
        
        UICollectionViewLayoutAttributes *attribute = (UICollectionViewLayoutAttributes*)layoutAttributes[i];
        if(CGRectIntersectsRect(attribute.frame, rect))
        {
            [elementsInRect addObject:attribute];
        }
    }
    
    return elementsInRect;
}


-(UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewLayoutAttributes* attr = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    
    
    return attr;
}

- (CGFloat)widthOfString:(NSString *)string withFont:(UIFont *)font {
    NSDictionary *attributes = [NSDictionary dictionaryWithObjectsAndKeys:font, NSFontAttributeName, nil];
    return [[[NSAttributedString alloc] initWithString:string attributes:attributes] size].width;
}

-(NSArray *)layoutAttributes
{
    NSMutableArray* elementsInRect = [NSMutableArray array];
    NSArray *contacts = ((SCMailsCollectionView *)self.collectionView).contacts;
    
    for(NSUInteger i = 0; i < contacts.count; i++){
        id contact = contacts[i];
        
        UICollectionViewLayoutAttributes *lastAtt;
        if(elementsInRect.count){
            lastAtt = elementsInRect[i - 1];
        }
        
        CGRect cellFrame;
        
        int marginRight = 3;
        
        if([contact isKindOfClass:[NSString class]]){
            
            
            
            if (lastAtt) {
                CGFloat x = lastAtt.frame.origin.x + lastAtt.frame.size.width + marginRight;
                CGFloat width = self.collectionView.frame.size.width - lastAtt.frame.size.width - lastAtt.frame.origin.x - marginRight;
                if (width < 200 ) {
                    width = 200;
                }
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



@end
