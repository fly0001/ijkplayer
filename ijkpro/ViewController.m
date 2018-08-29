//
//  ViewController.m
//  ijkpro
//
//  Created by ZQHC on 2018/7/25.
//  Copyright © 2018年 zqlm. All rights reserved.
//

#import "ViewController.h"
#import "PMSingleton.h"
@interface ViewController ()

@end

@implementation ViewController

-(void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];

}
-(void)viewDidLoad {
	[super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
//	NSURL *url = [NSURL URLWithString:@"http://192.168.2.38:8080/html/myvideo/test.m3u8"];
	
	
	[self.view addSubview:[PMSingleton shareInstance].view];
}


- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}


@end
