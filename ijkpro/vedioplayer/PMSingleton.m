//
//  PMSingleton.m
//  ijkpro
//
//  Created by ZQHC on 2018/8/2.
//  Copyright © 2018年 zqlm. All rights reserved.
//

#define SCREEN_WIDTH ([[UIScreen mainScreen] bounds].size.width)
#define SCREEN_HEIGHT ([[UIScreen mainScreen] bounds].size.height)

#import "PMSingleton.h"
#import "IJKMediaFramework/IJKMediaFramework.h"
#import "BlockButton.h"
#import "BlockSlider.h"
@interface PMSingleton ()
@property (atomic, retain) id <IJKMediaPlayback> player;
@property (weak, nonatomic) UIView *playView;
@property (weak, nonatomic) UIButton *playBtn;
@property (nonatomic) UILabel *nowlabel;
@property (nonatomic)NSTimer* timer;
@property (nonatomic)UIView *bottomview;
@end

@implementation PMSingleton

static PMSingleton * pm_singleton = nil;

#pragma mark 单例模式
+(PMSingleton *)shareInstance{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        pm_singleton = [[super allocWithZone:nil] init];
    });
    return pm_singleton;
}
+(id)allocWithZone:(NSZone *)zone{
	return [PMSingleton shareInstance];
}
-(id)copyWithZone:(NSZone *)zone{
	return [PMSingleton shareInstance];
}
-(id)mutableCopyWithZone:(NSZone *)zone{
	return [PMSingleton shareInstance];
}
#pragma mark 界面布局
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
	//
	self.view.frame=CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.width/2);
	
	NSURL *url = [NSURL URLWithString:@"rtmp://localhost:1935/myapp/wdqk.mp4"];
	_player = [[IJKFFMoviePlayerController alloc] initWithContentURL:url withOptions:nil];
	UIView *playerView = [_player view];
	playerView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.width/2);
	[self.view addSubview:playerView];
	[self.player prepareToPlay];
	[self.player play];
	[self createbottomview];
	self.timer= [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(updatetime) userInfo:nil repeats:YES];
    UITapGestureRecognizer *tapGesturRecognizer=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction:)];
    [playerView addGestureRecognizer:tapGesturRecognizer];
    [self performSelector:@selector(hidebottom) withObject:nil afterDelay:10];
}
-(void)updatetime
{
   self.nowlabel.text =[self TimeformatFromSeconds:self.player.currentPlaybackTime];
    
}
-(void)tapAction:(id)tap
{
    self.bottomview.hidden=NO;
    [self performSelector:@selector(hidebottom) withObject:nil afterDelay:10];
    NSLog(@"点击了playerView");
}
-(void)hidebottom
{
   self.bottomview.hidden=YES;
}
-(void)createbottomview
{
	self.bottomview=[[UIView alloc]initWithFrame:CGRectMake(0, self.view.frame.size.height-50, self.view.frame.size.width, 50)];
	self.bottomview.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"pbg.png"]];
	self.bottomview.layer.cornerRadius = 8;
	self.bottomview.layer.masksToBounds = YES;
	//设置边框及边框颜色
	self.bottomview.layer.borderWidth = 3;
	self.bottomview.layer.borderColor =[ [UIColor grayColor] CGColor];
    
	BlockButton *startbutton=[[BlockButton alloc]initWithFrame:CGRectMake(0, 0, 50, 50)];
	startbutton.block = ^(UIButton * button) {
		NSLog(@"%@",button);
		if (![self.player isPlaying]) {
			[self.player play];
			[button setTitle:@"Pause" forState:UIControlStateNormal];
			[button setImage:[UIImage imageNamed:@"pause.png"] forState:UIControlStateNormal];
            self.timer=[NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(updatetime) userInfo:nil repeats:YES];
		}else {
			[self.player pause];
			[button setTitle:@"Play" forState:UIControlStateNormal];
			[button setImage:[UIImage imageNamed:@"start.png"] forState:UIControlStateNormal];
            [self.timer invalidate];
		}
	};
	BlockSlider *progress=[[BlockSlider alloc]initWithFrame:CGRectMake(50, 10, self.view.frame.size.width-100, 30)];
    progress.block=^(UISlider * slider) {
        NSLog(@"now--- %f",slider.value);
        self.player.currentPlaybackTime = slider.value* self.player.duration;
        self.nowlabel.text =[self TimeformatFromSeconds:self.player.currentPlaybackTime];
    };
	BlockButton *allscreembutton=[[BlockButton alloc]initWithFrame:CGRectMake(self.view.frame.size.width-50, 0, 50, 50)];
	[startbutton setImage:[UIImage imageNamed:@"start.png"] forState:UIControlStateNormal];
	[allscreembutton setImage:[UIImage imageNamed:@"allscreen.png"] forState:UIControlStateNormal];
    static	BOOL isallscreen=NO;
	allscreembutton.block = ^(UIButton * button) {
		
		self.player.view.center=CGPointMake(SCREEN_WIDTH/2, SCREEN_HEIGHT/2);//找到中心
		if(!isallscreen){
		isallscreen=YES;
		CGAffineTransform transform = CGAffineTransformMakeRotation(M_PI/2);
		[self.player.view setTransform:transform];
		[self.bottomview setTransform:transform];
		self.view.frame=CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
		self.player.view.frame=CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
		 self.bottomview.center=CGPointMake(50/2, SCREEN_HEIGHT/2);
		}else
			{
			isallscreen=NO;
		//	CGAffineTransform transform = CGAffineTransformMakeRotation(2*M_PI);
			[self.player.view setTransform: CGAffineTransformIdentity];
			[self.bottomview setTransform:CGAffineTransformIdentity];
			self.view.frame=CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_WIDTH/2);
			self.player.view.frame=CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_WIDTH/2);
			self.bottomview.center=CGPointMake(SCREEN_WIDTH/2, SCREEN_WIDTH/2-50/2);
			}
	};
	
	UILabel *timelabel=[[UILabel alloc]initWithFrame:CGRectMake(self.view.frame.size.width-50-55, 25, 120, 20)];
	timelabel.font=[UIFont systemFontOfSize:12];
	timelabel.textColor=[UIColor lightGrayColor];
    timelabel.text =[NSString stringWithFormat:@"%@",[self TimeformatFromSeconds:self.player.duration]];
    
    self.nowlabel=[[UILabel alloc]initWithFrame:CGRectMake(self.view.frame.size.width-50-55, 5, 120, 20)];
    self.nowlabel.font=[UIFont systemFontOfSize:12];
    self.nowlabel.textColor=[UIColor lightGrayColor];
    self.nowlabel.text=@"00:06:56";
    
	[self.bottomview addSubview:startbutton];
    [self.bottomview addSubview:self.nowlabel];
    [self.bottomview addSubview:timelabel];
	[self.bottomview addSubview:progress];
	[self.bottomview addSubview:allscreembutton];
	[self.view addSubview:self.bottomview];
}
#pragma mark-公共方法
- (NSString*)TimeformatFromSeconds:(NSInteger)seconds
{
    //format of hour
    NSString *str_hour = [NSString stringWithFormat:@"%02ld",seconds/3600];
    //format of minute
    NSString *str_minute = [NSString stringWithFormat:@"%02ld",(seconds%3600)/60];
    //format of second
    NSString *str_second = [NSString stringWithFormat:@"%02ld",seconds%60];
    //format of time
    NSString *format_time = [NSString stringWithFormat:@"%@:%@:%@",str_hour,str_minute,str_second];
    return format_time;
}
-(IBAction)clickedAction:(id)sender {
	if (![_player isPlaying]) {
		[self.player play];
		[self.playBtn setTitle:@"Pause" forState:UIControlStateNormal];
		
	}else {
		[self.player pause];
		[self.playBtn setTitle:@"Play" forState:UIControlStateNormal];
		
	}
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
