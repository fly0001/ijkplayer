//
//  ationViewController.m
//  ijkpro
//
//  Created by ZQHC on 2018/7/30.
//  Copyright © 2018年 zqlm. All rights reserved.
//

#import "ationViewController.h"

@interface ationViewController ()

@end

@implementation ationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
	
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)kaiShiZuoCai{
	NSLog(@"开始做菜");
	sleep(2);
	NSLog(@"做好菜了，该上菜了");
	
	//下面这句是判断 一下delegate是否实现了doSomethingAftercaiZuohaole方法，如果delegate没有实现
	//直接[self.delegate doSomethingAftercaiZuohaole];会crash
	if ([self.delegate respondsToSelector:@selector(doSomethingAftercaiZuohaole)]) {
		[self.delegate doSomethingAftercaiZuohaole];
	}
	
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
