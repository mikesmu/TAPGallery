//
//  CollectionViewCell.m
//  TAPGallery
//
//  Created by Michał Smulski on 13.12.2012.
//  Copyright (c) 2012 TAP. All rights reserved.
//

#import "CollectionViewCell.h"
#import <QuartzCore/QuartzCore.h>

@interface CollectionViewCell ()

@property (assign) CGPoint orignalCenter;
@end

@implementation CollectionViewCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithRed:0.449 green:0.290 blue:0.607 alpha:1.000];
		self.orignalCenter = [self center];
		
		UIPinchGestureRecognizer *gesture = [[UIPinchGestureRecognizer alloc] initWithTarget:self
																					  action:@selector(pinchCell:)];
		[gesture setScale:2.0];
		[self setUserInteractionEnabled:YES];
		[self addGestureRecognizer:gesture];
		
		UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self
																					 action:@selector(restoreCellSizeAndCenter)];
		[tapGesture setNumberOfTapsRequired:2];
		[tapGesture setNumberOfTouchesRequired:1];
		[self addGestureRecognizer:tapGesture];
    }
    return self;
}

- (void)prepareForReuse {
	[super prepareForReuse];
	
	[[self layer] setTransform:CATransform3DIdentity];
	[self setCenter:self.orignalCenter];
}

- (void)restoreCellSizeAndCenter {
	[UIView animateWithDuration:0.32
					 animations:^{
						 if (CGPointEqualToPoint(self.center, self.orignalCenter)) {
							 CATransform3D transform = CATransform3DMakeScale(2.0, 2.0, 1.0);
							 [[self layer] setTransform:transform];
							 
							 CGPoint newCenter = self.orignalCenter;
							 newCenter.y += 5;
							 
							 [self setCenter:newCenter];
						 } else {
							 CATransform3D transform = CATransform3DIdentity;
							 [[self layer] setTransform:transform];
							 
							 [self setCenter:self.orignalCenter]; 
						 }
					 }];
}

- (void)pinchCell:(UIPinchGestureRecognizer*)sender {
	NSLog(@"pinch scale %f", sender.scale);
	
	CATransform3D transform = CATransform3DMakeScale(sender.scale, sender.scale, 1.0);
	[[self layer] setTransform:transform];
	
	[self setCenter:[sender locationInView:self.superview]];
}

@end
