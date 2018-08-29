//
//  ationViewController.h
//  ijkpro
//
//  Created by ZQHC on 2018/7/30.
//  Copyright © 2018年 zqlm. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol ationViewControllerDelegate <NSObject>
- (void)doSomethingAftercaiZuohaole;
@end
@interface ationViewController : UIViewController
@property (nonatomic, weak) id <ationViewControllerDelegate> delegate;
- (void)kaiShiZuoCai;
@end
