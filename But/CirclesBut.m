//
//  CirclesBut.m
//  Button
//
//  Created by 谢立新 on 2019/8/21.
//  Copyright © 2019 谢立新. All rights reserved.
//

#import "CirclesBut.h"

@interface CirclesBut()<CAAnimationDelegate>

@property (nonatomic,strong) UIBezierPath * bezierPath;

@property (nonatomic,strong) CAShapeLayer * progressLayer;

@property (nonatomic,copy) CABasicAnimation * animation;

@property (nonatomic,copy) UIColor * strokeColor;

@property (nonatomic,copy) animationStop myBlock;
@end

@implementation CirclesBut


-(id)initWithFrame:(CGRect)frame and:(UIColor *)color{
    
    if (self ==[super initWithFrame:frame]) {
        self.strokeColor = color;
        [self.layer addSublayer:self.progressLayer];
    }
    return self;
}

-(UIBezierPath *)bezierPath{
    
    if (!_bezierPath) {
        CGFloat radius = self.frame.size.width/2;
        self.bezierPath = [UIBezierPath bezierPathWithArcCenter:CGPointMake(radius, radius) radius:radius startAngle:-2*M_PI endAngle:0 clockwise:YES];
        
    }
    return _bezierPath;
}

-(CAShapeLayer *)progressLayer{
    
    if (!_progressLayer) {
        self.progressLayer = [CAShapeLayer layer];
        self.progressLayer.strokeColor = self.strokeColor?self.strokeColor.CGColor:[UIColor redColor].CGColor;
        self.progressLayer.fillColor = [UIColor clearColor].CGColor;
        self.progressLayer.lineWidth = 1;
        self.progressLayer.path = self.bezierPath.CGPath;
        
        self.animation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
        self.animation.delegate = self;
        self.animation.fromValue = @(0);
        self.animation.toValue = @(1);
        self.animation.duration = 5;
        [self.progressLayer addAnimation:self.animation forKey:@""];
    }
    return _progressLayer;
}


-(void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
    
    if (flag) {
        self.myBlock();
    }
}
-(void)animationdidStopBlock:(animationStop)block{
    
    self.myBlock = block;
}

@end
