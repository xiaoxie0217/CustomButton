//
//  ChooseIntervalButton.m
//  Button
//
//  Created by 谢立新 on 2019/8/26.
//  Copyright © 2019 谢立新. All rights reserved.
//

#import "ChooseIntervalButton.h"

//滑块的大小
#define SLIDERFRAME  self.frame.size.height/2

@interface ChooseIntervalButton()

@property (nonatomic,strong) UIView * leftView;

@property (nonatomic,strong) UIView * rightView;

@property (nonatomic,strong) UILabel * lineLabel;
//每一个像素点在 0-100 区间内占得值(为了算百分比)
@property (nonatomic,assign) CGFloat percentage;

@end

@implementation ChooseIntervalButton

-(id)initWithFrame:(CGRect)frame{
    
    if (self == [super initWithFrame:frame]) {
        self.percentage = 100/(frame.size.width-(frame.size.height/2));
        [self creatUI];
    }
    return self;
}

//绘制 UI 界面图
-(void)creatUI{
    
    self.lineLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, (self.frame.size.height-2)/2, self.frame.size.width, 2)];
    
    self.lineLabel.backgroundColor = [UIColor grayColor];
    
    [self addSubview:self.lineLabel];
    
    self.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, (self.frame.size.height-SLIDERFRAME)/2, SLIDERFRAME, SLIDERFRAME)];
    [self addSubview:self.leftView];
    
    //左边滑块切圆
    [self tailorView:self.leftView];
    
    self.rightView = [[UIView alloc] initWithFrame:CGRectMake(self.frame.size.width-SLIDERFRAME, (self.frame.size.height-SLIDERFRAME)/2, SLIDERFRAME, SLIDERFRAME)];
    [self addSubview:self.rightView];
    //右边滑块切圆
    [self tailorView:self.rightView];
    //添加滑动手势
    UIPanGestureRecognizer *leftPan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(leftPan:)];
    
    [self.leftView addGestureRecognizer:leftPan];
    
    UIPanGestureRecognizer *rightPan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(rightPan:)];
    [self.rightView addGestureRecognizer:rightPan];
}
//左边滑块的滑动方法
-(void)leftPan:(UIPanGestureRecognizer*)leftPan{
    
    CGPoint point = [leftPan translationInView:self.leftView];
    
    [leftPan setTranslation:CGPointZero inView:self.leftView];
    //判断左边滑块向左不能超出线的位置  向右不能超过右边滑块的位置
    if (self.leftView.frame.origin.x+self.leftView.frame.size.width>self.rightView.frame.origin.x){//向右
        
        self.leftView.frame = CGRectMake(self.rightView.frame.origin.x-SLIDERFRAME, (self.frame.size.height-SLIDERFRAME)/2, SLIDERFRAME, SLIDERFRAME);
        
    }else if (self.leftView.frame.origin.x<0){//向左
        
        self.leftView.frame = CGRectMake(0, (self.frame.size.height-SLIDERFRAME)/2, SLIDERFRAME, SLIDERFRAME);
        
    }else{//正常滑动
        self.leftView.transform = CGAffineTransformTranslate(self.leftView.transform, point.x, 0);
    }
    //当滑块停止滑动的时候,返回区间值
    if (leftPan.state == UIGestureRecognizerStateEnded) {
        [self sliderStop];
    }
}
//右边滑块的滑动方法
-(void)rightPan:(UIPanGestureRecognizer *)rightPan{
    
    CGPoint point = [rightPan translationInView:rightPan.view];
    
    [rightPan setTranslation:CGPointZero inView:rightPan.view];
    //判断右边滑块向右不能超出线的位置,向左不能超过左边滑块的位置
    if (self.rightView.frame.origin.x+SLIDERFRAME>self.frame.size.width) {//向左
        self.rightView.frame = CGRectMake(self.frame.size.width-SLIDERFRAME, (self.frame.size.height-SLIDERFRAME)/2, SLIDERFRAME, SLIDERFRAME);
    }else if (self.rightView.frame.origin.x-self.leftView.frame.size.width<self.leftView.frame.origin.x){//向右
        self.rightView.frame = CGRectMake(self.leftView.frame.origin.x+SLIDERFRAME, (self.frame.size.height-SLIDERFRAME)/2, SLIDERFRAME, SLIDERFRAME);
    }else{//正常滑动
        self.rightView.transform = CGAffineTransformTranslate(self.rightView.transform, point.x, 0);
    }
    //当滑块停止的时候返回区间值
    if (rightPan.state == UIGestureRecognizerStateEnded) {
        [self sliderStop];
    }
}

-(void)sliderStop{
    //当两个滑块a贴近的时候,返回右边滑块的百分比值
    if (self.rightView.frame.origin.x-self.leftView.frame.origin.x<=25) {
        CGFloat right =self.percentage*self.rightView.frame.origin.x;
        self.myBlock(right, right);
    }else{//当两个滑块分开的时候,分别返回滑块的百分比值
        CGFloat left = self.percentage*self.leftView.frame.origin.x;
        CGFloat right =self.percentage*self.rightView.frame.origin.x;
        if (self.myBlock) {
            self.myBlock(left, right);
        }
    }
}

-(void)tailorView:(UIView *)view{
    //右边k滑块切圆
    UIBezierPath *rightBezier = [UIBezierPath bezierPathWithRoundedRect:view.bounds byRoundingCorners:UIRectCornerAllCorners cornerRadii:CGSizeMake(view.frame.size.height, view.frame.size.height)];
    
    CAShapeLayer *rightLayer = [CAShapeLayer layer];
    rightLayer.fillColor = [UIColor grayColor].CGColor;
    rightLayer.path = rightBezier.CGPath;
    [view.layer addSublayer:rightLayer];
}


@end
