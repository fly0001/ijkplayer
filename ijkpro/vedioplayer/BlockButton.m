//
//  BlockButton.m
//  ijkpro
//
//  Created by ZQHC on 2018/8/3.
//  Copyright © 2018年 zqlm. All rights reserved.
//
#import "BlockButton.h"

@implementation BlockButton

- (instancetype)initWithFrame:(CGRect)frame
{
	self = [super initWithFrame:frame];
	if (self) {
		
		[self addTarget:self action:@selector(doAction:) forControlEvents:UIControlEventTouchUpInside];
	}
	return self;
}

- (void)doAction:(UIButton *)button {
	
	self.block(button);
}

@end
