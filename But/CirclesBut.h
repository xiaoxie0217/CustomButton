//
//  CirclesBut.h
//  Button
//
//  Created by 谢立新 on 2019/8/21.
//  Copyright © 2019 谢立新. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef void(^animationStop)(void);
@interface CirclesBut : UIButton

-(id)initWithFrame:(CGRect)frame and:(UIColor *)color;
-(void)animationdidStopBlock:(animationStop)block;
@end

NS_ASSUME_NONNULL_END
