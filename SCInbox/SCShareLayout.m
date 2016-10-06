//
//  SCShareLayout.m
//  SCInbox
//
//  Created by Adrian Ortuzar on 23/09/16.
//  Copyright © 2016 Adrian Ortuzar. All rights reserved.
//

#import "SCShareLayout.h"
#import "SCMailsCollectionView.h"

#define ROW_HEIGHT 35

@interface SCShareLayout ()

@end

@implementation SCShareLayout

-(CGSize)collectionViewContentSize
{
    
    CGFloat height;
    NSArray *layoutAttributes = self.layoutAttributes;
    if(layoutAttributes.count){
        UICollectionViewLayoutAttributes *lastatt = (UICollectionViewLayoutAttributes*)layoutAttributes[layoutAttributes.count - 1];
        height = lastatt.frame.origin.y + lastatt.frame.size.height;
    }
    else{
        height = ROW_HEIGHT;
    }
    
    return CGSizeMake(self.collectionView.frame.size.width, height);
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
    NSArray *atts = [self layoutAttributes];
    
    
    return atts[indexPath.row];
}

- (CGFloat)widthOfString:(NSString *)string withFont:(UIFont *)font {
    NSDictionary *attributes = [NSDictionary dictionaryWithObjectsAndKeys:font, NSFontAttributeName, nil];
    return [[[NSAttributedString alloc] initWithString:string attributes:attributes] size].width;
}

-(NSArray *)layoutAttributes
{
    NSMutableArray <UICollectionViewLayoutAttributes*> *elementsInRect = [NSMutableArray array];
    NSArray *contacts = ((SCMailsCollectionView *)self.collectionView).contacts;
    
    for(NSUInteger i = 0; i < contacts.count; i++){
        
        id contact = contacts[i];
        
        // last attribute
        UICollectionViewLayoutAttributes *lastAtt = ^UICollectionViewLayoutAttributes *(NSArray<UICollectionViewLayoutAttributes *> *attributes){
                return (attributes.count)?attributes[i - 1]:nil;
        }(elementsInRect);
        
        // calculate the frame
        CGRect cellFrame = ^CGRect(id contact, UICollectionViewLayoutAttributes *lastAtt){
            
            CGFloat x;
            CGFloat y;
            CGFloat height = ROW_HEIGHT;
            CGFloat width;
            
            int marginRight = 3;
            
            
            if([contact isKindOfClass:[NSString class]]){
                // search cell
                if (lastAtt) {
                    width = ^int(){
                        int width = self.collectionView.frame.size.width - lastAtt.frame.size.width - lastAtt.frame.origin.x - marginRight;
                        
                        if (width < 200 ) {
                            return  200;
                        }
                        else{
                            return width;
                        }
                    }();
                    
                    __block BOOL nextRow = NO;
                    
                    x = ^int(){
                        int result = lastAtt.frame.origin.x + lastAtt.frame.size.width + marginRight;
                        
                        if (result + width > self.collectionView.frame.size.width) {
                            result = 0;
                            nextRow = YES;
                        }
                        return result;
                    }();
                    y = ^int(){
                        if (nextRow) {
                            return lastAtt.frame.origin.y + ROW_HEIGHT;
                        }
                        else{
                            return lastAtt.frame.origin.y;
                        }
                    }();
                    
                }
                else{
                    x = 0;
                    y = 0;
                    width = self.collectionView.frame.size.width;
                }
            }
            else{
                // contact cell
                width = ^int(){
                    NSString *mail = [((NSDictionary*)contact) objectForKey:@"mail"];
                    CGFloat padding = 8 * 2;
                    return [self widthOfString:mail withFont:[UIFont fontWithName:@"Helvetica" size:16]] + padding;
                }();
                
                
                if (lastAtt) {
                    __block BOOL nextRow = NO;
                    
                    x = ^int(){
                        
                        int result = lastAtt.frame.origin.x + lastAtt.frame.size.width + marginRight;
                        
                        if (result + width > self.collectionView.frame.size.width) {
                            result = 0;
                            nextRow = YES;
                        }
                        
                        return result;
                    }();
                    
                    y = ^int(){
                        if (nextRow) {
                            return lastAtt.frame.origin.y + ROW_HEIGHT;
                        }
                        else{
                            return lastAtt.frame.origin.y;
                        }
                    }();
                }
                else{
                    x = 0;
                    y = 0;
                }
            }
            
            return CGRectMake(x, y, width, height);
            
        }(contact, lastAtt);
        
        
        //
        NSIndexPath* indexPath = [NSIndexPath indexPathForRow:i inSection:0];
        UICollectionViewLayoutAttributes* attr = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
        attr.frame = cellFrame;
        [elementsInRect addObject:attr];
        
    }
    
    return elementsInRect;
}



@end
