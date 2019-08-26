//
//  SliderButton.m
//  Button
//
//  Created by 谢立新 on 2019/8/23.
//  Copyright © 2019 谢立新. All rights reserved.
//

#import "SliderButton.h"

//滑块的大小
#define SLIDERFRAME  self.frame.size.height/2
//每一个像素点在 0-100 区间内占得值(为了算百分比)
#define SCOPE (100/(self.frame.size.width-SLIDERFRAME))


@interface SliderButton ()
//底层的线
@property (nonatomic,strong) UILabel * bottomLabel;
//返回滑动百分比的 block
@property (nonatomic,copy) SliderLocation location;
//已经滑动的线
@property (nonatomic,strong) UILabel * selectedLine;
//圆形滑块
@property (nonatomic,strong) UIView * sliderView;
//滑块的初始值
@property (nonatomic,assign) CGFloat percentage;
//滑块的填充色
@property (nonatomic,copy) UIColor * fillColor;
//滑块边框的颜色
@property (nonatomic,copy) UIColor * strokeColor;
//底层线的颜色e
@property (nonatomic,copy) UIColor * lineColor;
//已经滑动的线的颜色
@property (nonatomic,copy) UIColor * selectedColor;
@end

@implementation SliderButton

-(id)initWithFrame:(CGRect)frame andCircleFillColor:(UIColor *)fillColor andCircleStrokeColor:(UIColor*)strokeColor andLineColor:(UIColor *)lineColor andselectedLineColor:(UIColor *)selectedColor andStartLocation:(CGFloat)percentage andLocationBlock:(SliderLocation)location{
    
    if (self == [super initWithFrame:frame]) {
        
        self.location = location;
        self.fillColor = fillColor;
        self.strokeColor = strokeColor;
        self.lineColor = lineColor;
        self.selectedColor = selectedColor;
        self.percentage = percentage;
        
        [self addSubview:self.bottomLabel];
        [self addSubview:self.selectedLine];
        [self addSubview:self.sliderView];
    }
    return self;
}

-(UILabel *)bottomLabel{
    
    if (!_bottomLabel) {
        self.bottomLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, (self.frame.size.height-2)/2, self.frame.size.width, 2)];
        self.bottomLabel.backgroundColor = self.lineColor?self.lineColor:[UIColor grayColor];
    }
    return _bottomLabel;
}

-(UILabel *)selectedLine{
    
    if (!_selectedLine) {
        self.selectedLine = [[UILabel alloc] initWithFrame:CGRectMake(0, (self.frame.size.height-2)/2, SCOPE*self.percentage, 2)];
        self.selectedLine.backgroundColor = self.selectedColor?self.selectedColor:[UIColor blueColor];
    }
    return _selectedLine;
}

-(UIView *)sliderView{
    
    if (!_sliderView) {
        //PERCENTAGE/SCOPE*self.percentage 原型按钮的初始位置
        self.sliderView = [[UIView alloc] initWithFrame:CGRectMake(SCOPE*self.percentage, (self.frame.size.height-SLIDERFRAME)/2, SLIDERFRAME, SLIDERFRAME)];
        //给滑块切圆
        UIBezierPath *bezier = [UIBezierPath bezierPathWithArcCenter:CGPointMake(self.sliderView.frame.size.height/2, self.sliderView.frame.size.height/2) radius:self.frame.size.height/4 startAngle:-2*M_PI endAngle:0 clockwise:YES];
        
        CAShapeLayer *layer = [CAShapeLayer layer];
        layer.fillColor = self.fillColor?self.fillColor.CGColor:[UIColor clearColor].CGColor;
        layer.lineWidth =1;
        layer.strokeColor = self.strokeColor?self.strokeColor.CGColor:[UIColor grayColor].CGColor;
        layer.path = bezier.CGPath;
        [self.sliderView.layer addSublayer:layer];
        //给滑块添加手势左滑手势
        UIPanGestureRecognizer *leftPan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(pan:)];
        leftPan.minimumNumberOfTouches = 1;
        
        //给滑块添加手势右滑手势
        UIPanGestureRecognizer *rightPan = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(pan:)];
        rightPan.minimumNumberOfTouches = 1;
        
        [self.sliderView addGestureRecognizer:leftPan];

        [self.sliderView addGestureRecognizer:rightPan];
        
    }
    return _sliderView;
}

-(void)pan:(UIPanGestureRecognizer *)pan{
    
    CGPoint point = [pan translationInView:self.sliderView];
    
    //已经滑过的线的位置
    self.selectedLine.frame = CGRectMake(0, (self.frame.size.height-2)/2, self.sliderView.frame.origin.x, 2);
    //返回的是相对于最原始的手指的偏移量
    [pan setTranslation:CGPointZero inView:self.sliderView];
    //滑块的位置
    if (self.sliderView.frame.origin.x>self.frame.size.width) {
        self.sliderView.frame = CGRectMake(self.frame.size.width-SLIDERFRAME, (self.frame.size.height-SLIDERFRAME)/2, SLIDERFRAME, SLIDERFRAME);
    }else if (self.sliderView.frame.origin.x< 0){
        self.sliderView.frame = CGRectMake(0, (self.frame.size.height-SLIDERFRAME)/2, SLIDERFRAME, SLIDERFRAME);
    }else{
        self.sliderView.transform = CGAffineTransformTranslate(self.sliderView.transform, point.x, 0);
    }
    //当滑块停止的时候 返回滑块的位置
    if (pan.state == UIGestureRecognizerStateEnded) {
        
        if (self.location) {
            NSLog(@"%f",SCOPE); self.location(SCOPE*self.sliderView.frame.origin.x);
        }
    }
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
