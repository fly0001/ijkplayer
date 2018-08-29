//
//  BlockButton.h
//  ijkpro
//
//  Created by ZQHC on 2018/8/3.
//  Copyright © 2018年 zqlm. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^sBlock)(UISlider * slider);

@interface BlockSlider : UISlider

@property (nonatomic, copy) sBlock block;

@end
