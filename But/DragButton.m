//
//  DragButton.m
//  Button
//
//  Created by 谢立新 on 2019/8/24.
//  Copyright © 2019 谢立新. All rights reserved.
//

#import "DragButton.h"

#define SCR_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCR_HEIGHT [UIScreen mainScreen].bounds.size.height
@interface DragButton()

@end


@implementation DragButton

-(id)initWithFrame:(CGRect)frame{
    if (self == [super initWithFrame:frame]) {
        [self creatPanGesture];
    }
    return self;
}

-(void)creatPanGesture{
    
    self.backgroundColor = [UIColor blueColor];
    //添加点击手势
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(buttonClick)];
    
    [self addGestureRecognizer:tap];
    //添加拖动手势
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(pan:)];
    
    [self addGestureRecognizer:pan];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, (self.frame.size.height-40)/2, self.frame.size.width, 40)];
    label.text = @"这是一个可以随意拖动的按钮";
    label.numberOfLines = 0;
    label.font = [UIFont systemFontOfSize:12];
    label.textColor = [UIColor whiteColor];
    [self addSubview:label];
}
//拖动手势的方法
-(void)pan:(UIPanGestureRecognizer *)pan{
    //获取到的是手指移动后，在相对坐标中的偏移量
    CGPoint point = [pan translationInView:pan.view];
    //返回的是相对于最原始的手指的偏移量
    [pan setTranslation:CGPointZero inView:self];
    //获取当前view 相对的中心点
    CGPoint center = CGPointMake(self.center.x+point.x, self.center.y+point.y);
    //下面这段代码是为了不让控件脱出屏幕外
    if (center.x-self.frame.size.width/2<0) {
        center.x = self.frame.size.width/2;
    }else if (center.x+self.frame.size.width/2>=SCR_WIDTH){
        center.x = SCR_WIDTH-self.frame.size.width/2;
    }

    if (center.y-self.frame.size.height/2<0) {
        center.y = self.frame.size.height/2;
    }else if (center.y+self.frame.size.height/2>=SCR_HEIGHT){
        center.y = SCR_HEIGHT-self.frame.size.height/2;
    }
    //通过 block 返回视图的中心点,在显示页面上重新设置中心点
    self.location(center.x, center.y);
    //此方法也可以实现随意拖动,但是是否脱出屏幕外控制不了(有大神解决了这问题,麻烦告诉一下谢谢)
//    self.transform = CGAffineTransformTranslate(self.transform, point.x, point.y);
    
}

-(void)buttonClick{
    NSLog(@"点击你咋滴????");
}

@end
