//
//  BlockButton.h
//  ijkpro
//
//  Created by ZQHC on 2018/8/3.
//  Copyright © 2018年 zqlm. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^Block)(UIButton * button);

@interface BlockButton : UIButton

@property (nonatomic, copy) Block block;

@end
