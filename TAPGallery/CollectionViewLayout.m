//
//  CollectionViewLayout.m
//  TAPGallery
//
//  Created by Michał Smulski on 13.12.2012.
//  Copyright (c) 2012 TAP. All rights reserved.
//

#import "CollectionViewLayout.h"


static NSString * const kPhotoCellKind = @"photo:cell";

@interface CollectionViewLayout ()

@property (strong) NSDictionary *layoutInfo;

@end

@implementation CollectionViewLayout

- (id)init {
	self = [super init];
	if (self) {
		[self setup];
	}
	return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
	self = [super initWithCoder:aDecoder];
	if (self) {
		[self setup];
	}
	return self;
}

- (void)setup {
	self.columnsCount = 3;
	self.itemInsets = UIEdgeInsetsMake(20.0, 20.0, 20.0, 20.0);
	self.interSpacingY = 10.0;
	float uniSize = ([UIScreen mainScreen].preferredMode.size.width - self.itemInsets.left - self.itemInsets.right -
					 (self.columnsCount - 1)*self.interSpacingY) / self.columnsCount;
	self.itemSize = CGSizeMake(uniSize, uniSize);
}

#pragma mark -
- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath {
	return self.layoutInfo[kPhotoCellKind][indexPath];
}

- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect {
	NSMutableArray *allAttributes = [NSMutableArray new];
	
	[self.layoutInfo enumerateKeysAndObjectsUsingBlock:^(NSString *key,
														 NSDictionary *cellInfo,
														 BOOL *stop) {
		[cellInfo enumerateKeysAndObjectsUsingBlock:^(NSIndexPath *indexPath,
													  UICollectionViewLayoutAttributes *attributes,
													  BOOL *stop) {
			if (CGRectIntersectsRect(rect, attributes.frame)) {
				[allAttributes addObject:attributes];
			}
		}];
	}];
	return allAttributes;
}

- (CGSize)collectionViewContentSize {
	int rowCount = [self.collectionView numberOfSections] / self.columnsCount;
	
	if ([self.collectionView numberOfSections] % self.columnsCount) {
		rowCount += 1;
	}
	float height = self.itemInsets.top + rowCount*self.itemSize.height + (rowCount - 1)*self.interSpacingY + self.itemInsets.bottom;
	
	return CGSizeMake(self.collectionView.bounds.size.width, height);
}
#pragma mark -


- (void)prepareLayout {
	NSMutableDictionary *newLayoutInfo = [NSMutableDictionary new];
	NSMutableDictionary *cellLayoutInfo = [NSMutableDictionary new];
	
	int sectionCount = [self.collectionView numberOfSections];
	NSIndexPath *indexPath = [NSIndexPath indexPathForItem:0 inSection:0];
	for(int section = 0; section < sectionCount; section++) {
		int itemCount = [self.collectionView numberOfItemsInSection:section];
		
		for (int item = 0; item < itemCount; item++) {
			indexPath = [NSIndexPath indexPathForItem:item inSection:section];
			
			UICollectionViewLayoutAttributes *attributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
			attributes.frame = [self frameForCellAtIndexPath:indexPath];
			
			cellLayoutInfo[indexPath] = attributes;
		}
	}
	
	newLayoutInfo[kPhotoCellKind] = cellLayoutInfo;
	self.layoutInfo = newLayoutInfo;
}


- (CGRect)frameForCellAtIndexPath:(NSIndexPath*)indexPath {
	int row = indexPath.section / self.columnsCount;
	int column = indexPath.section % self.columnsCount;
	
	float spacingX = self.collectionView.bounds.size.width - self.itemInsets.left - self.itemInsets.right - (self.columnsCount * self.itemSize.width);
	
	if (self.columnsCount > 1) {
		spacingX = spacingX / (self.columnsCount - 1);
	}
	
	float originX = floorf(self.itemInsets.left + column*(self.itemSize.width + spacingX));
	float originY = floorf(self.itemInsets.top + row*(self.itemSize.height + self.interSpacingY));
	
	return CGRectMake(originX, originY, self.itemSize.width, self.itemSize.height);
}

@end
