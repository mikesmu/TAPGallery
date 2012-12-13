//
//  ViewController.m
//  TAPGallery
//
//  Created by Michał Smulski on 13.12.2012.
//  Copyright (c) 2012 TAP. All rights reserved.
//

#import "CollectionController.h"
#import "CollectionViewCell.h"

static NSString * const kPhotoCellId = @"photo:cell:id";

@interface CollectionController ()

@end

@implementation CollectionController

- (void)viewDidLoad
{
    [super viewDidLoad];
	self.collectionView.backgroundColor = [UIColor colorWithRed:0.000 green:0.216 blue:0.282 alpha:1.000];
	[self.collectionView registerClass:[CollectionViewCell class]
			forCellWithReuseIdentifier:kPhotoCellId];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
	return 100;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
	return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
	CollectionViewCell *cell = (CollectionViewCell*)[collectionView dequeueReusableCellWithReuseIdentifier:kPhotoCellId
																		   forIndexPath:indexPath];
	return cell;
}
#pragma mark -


@end
