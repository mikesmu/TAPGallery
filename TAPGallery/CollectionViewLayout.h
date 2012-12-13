//
//  CollectionViewLayout.h
//  TAPGallery
//
//  Created by Michał Smulski on 13.12.2012.
//  Copyright (c) 2012 TAP. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CollectionViewLayout : UICollectionViewLayout

@property (unsafe_unretained) int columnsCount;
@property (unsafe_unretained) UIEdgeInsets itemInsets;
@property (unsafe_unretained) CGSize itemSize;
@property (unsafe_unretained) float interSpacingY;

@end
