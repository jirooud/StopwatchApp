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
    
    //画面サイズ取得
    CGRect screenSize = [UIScreen mainScreen].bounds;
    
    //ラベル
    timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 300, 100)];
    timeLabel.center = CGPointMake(screenSize.size.width / 2, screenSize.size.height / 2);
    timeLabel.font = [UIFont boldSystemFontOfSize:48];
    timeLabel.text = @"00:00";
    timeLabel.textAlignment = NSTextAlignmentCenter;
    timeLabel.backgroundColor = [UIColor clearColor];
    [self.view addSubview:timeLabel];
    
    //スタートボタン
    UIButton *startButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [startButton setTitle:@"スタート" forState:UIControlStateNormal];
    [startButton addTarget:self action:@selector(timerStart:) forControlEvents:UIControlEventTouchDown];
    startButton.frame = CGRectMake(0, 0, 100, 50);
    startButton.center = CGPointMake(screenSize.size.width / 2, screenSize.size.height - 90);
    [self.view addSubview:startButton];
    
    //リセットボタン
    UIButton *resetButton = [UIButton buttonWithType:UIButtonTypeCustom];
    resetButton.frame = CGRectMake(0, 0, 100, 50);
    resetButton.center = CGPointMake(screenSize.size.width / 2, screenSize.size.height - 40);
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

//スイッチ切り替え
-(void)timerStart:(UIButton *)sender{
    if (timer == nil){
        [sender setTitle:@"ストップ" forState:UIControlStateNormal];
        startDate = [NSDate date];
        timer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(tick:)userInfo:nil repeats:YES];
    }else{
        [sender setTitle:@"スタート" forState:UIControlStateNormal];
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

//再提出

@end