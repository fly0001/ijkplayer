//
//  BlockButton.m
//  ijkpro
//
//  Created by ZQHC on 2018/8/3.
//  Copyright © 2018年 zqlm. All rights reserved.
//
#import "BlockSlider.h"

@implementation BlockSlider

- (instancetype)initWithFrame:(CGRect)frame
{
	self = [super initWithFrame:frame];
	if (self) {
		
		[self addTarget:self action:@selector(doAction:) forControlEvents:UIControlEventValueChanged];
	}
	return self;
}

- (void)doAction:(UISlider *)slider {
	
	self.block(slider);
}

@end
