//
//  ViewController.m
//  Button
//
//  Created by 谢立新 on 2019/8/21.
//  Copyright © 2019 谢立新. All rights reserved.
//

#import "ViewController.h"
#import "CirclesBut.h"
#import "SliderButton.h"
#import "DragButton.h"
#import "ChooseIntervalButton.h"
@interface ViewController ()
@property (nonatomic,strong) CirclesBut *but;
@property (nonatomic,strong) SliderButton * sliderBut;
@property (nonatomic,strong) DragButton * dragBut;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self creatCirclesBut];
    [self.view addSubview:self.sliderBut];
    [self.view addSubview:self.drafBut];
    [self creatIntervalBut];
}

-(CirclesBut *)but{
    
    if (!_but) {
        self.but = [[CirclesBut alloc] initWithFrame:CGRectMake(50, 100, 50 , 50) and:[UIColor grayColor]];
        [self.view addSubview:self.but];
    }
    return _but;
}

-(void)creatCirclesBut{

    [self.but setTitle:@"确定" forState:UIControlStateNormal];
    
    [self.but setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    self.but.titleLabel.font = [UIFont systemFontOfSize:12];
    
    [self.but animationdidStopBlock:^{
        NSLog(@"动画已经结束");
    }];
}

-(SliderButton *)sliderBut{
    
    if (!_sliderBut) {
        
        self.sliderBut = [[SliderButton alloc] initWithFrame:CGRectMake(50, 200, 200, 50) andCircleFillColor:[UIColor grayColor] andCircleStrokeColor:[UIColor blackColor] andLineColor:[UIColor grayColor] andselectedLineColor:[UIColor redColor] andStartLocation:50 andLocationBlock:^(CGFloat location) {
            
            NSLog(@"滑动了%.2f%%",location);
        }];
        
        [self.view addSubview:self.sliderBut];
    }
    return _sliderBut;
}

-(DragButton *)drafBut{
    
    if (!_dragBut) {
        self.dragBut = [[DragButton alloc] initWithFrame:CGRectMake(200, 100, 100, 100)];
        __weak typeof(self) weakSelf = self;
        self.dragBut.location = ^(CGFloat x, CGFloat y) {
            weakSelf.dragBut.center = CGPointMake(x, y);
        };
    }
    return _dragBut;
}

-(void)creatIntervalBut{
    
    ChooseIntervalButton *intervalBut = [[ChooseIntervalButton alloc] initWithFrame:CGRectMake(100, 300, 200, 50)];
    intervalBut.myBlock = ^(CGFloat start, CGFloat end) {
        NSLog(@"区间为%.2f%%-%.2f%%",start,end);
    };
    [self.view addSubview:intervalBut];
    
}


@end
