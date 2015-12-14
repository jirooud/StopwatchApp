//
//  ViewController.m
//  StopwatchApp
//
//  Created by bpqd on 2015/12/03.
//  Copyright © 2015年 nakayama. All rights reserved.
//

#import "ViewController.h"

@interface ViewController (){
    UILabel *timeLabel;
    
    UIImageView *backgroundView;

    NSTimer *timer;
    
    NSDate *startDate;
    
    NSInteger totalInterval;
}

@end

@implementation ViewController

-(void)setupParts{
    //背景画像
    backgroundView = [[UIImageView alloc]initWithFrame:[[UIScreen mainScreen]bounds] ];
    backgroundView.image = [UIImage imageNamed:@"sample1.png"];
    [self.view addSubview:backgroundView];
    
    //ラベル
    timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 300, 100)];
    timeLabel.center = CGPointMake(160, 284);
    timeLabel.font = [UIFont fontWithName:@"HiraKakuProN-W6" size:48];
    timeLabel.text = @"00:00";
    timeLabel.textAlignment = NSTextAlignmentCenter;
    timeLabel.backgroundColor = [UIColor clearColor];
    [self.view addSubview:timeLabel];

    //スタートボタン
    UIButton *startButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    startButton.frame = CGRectMake(0, 0, 100, 50);
    startButton.center = CGPointMake(160, 400);
    [startButton setTitle:@"スタート" forState:UIControlStateNormal];
    [startButton addTarget:self action:@selector(timerStart:)
          forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:startButton];
    
    //ストップボタン
    UIButton *stopButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    stopButton.frame = CGRectMake(0, 0, 100, 50);
    stopButton.center = CGPointMake(160, 450);
    [stopButton setTitle:@"停止" forState:UIControlStateNormal];
    [stopButton addTarget:self action:@selector(timerStop:)
         forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:stopButton];
    
    //リセットボタン
    UIButton *resetButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    resetButton.frame = CGRectMake(0, 0, 100, 50);
    resetButton.center = CGPointMake(160, 500);
    [resetButton setTitle:@"リセット" forState:UIControlStateNormal];
    [resetButton addTarget:self action:@selector(timerReset:)
         forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:resetButton];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self setupParts];
}

-(void)tick:(NSTimer*)timer{
    NSDate *aDate = [NSDate date];
    NSLog(@"タイマー");
    NSInteger interval = [aDate timeIntervalSinceDate:startDate]+totalInterval;
    NSInteger minute = interval/60;
    NSInteger second = interval%60;    
    timeLabel.text = [NSString stringWithFormat:@"%02ld:%02ld", (long)minute,(long)second];
}

//スタートボタンを押した時
-(void)timerStart:(id)sender{
    if (timer == nil){
    startDate = [NSDate date];
        timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(tick:)userInfo:nil repeats:YES];
    }
}

//ストップボタンを押した時
-(void)timerStop:(id)sender{
    if (timer != nil){
        NSInteger nawInterval = [[NSDate date]timeIntervalSinceDate:startDate];
        totalInterval += nawInterval;
        [timer invalidate];
        timer = nil;
    }
}

//リセットボタンを押した時
-(void)timerReset:(id)sender{
    if (timer == nil){
        totalInterval = 0;
        timeLabel.text = @"00:00";
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end