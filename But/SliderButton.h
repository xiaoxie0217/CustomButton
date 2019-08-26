//
//  SliderButton.h
//  Button
//
//  Created by 谢立新 on 2019/8/23.
//  Copyright © 2019 谢立新. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^SliderLocation)(CGFloat location);
NS_ASSUME_NONNULL_BEGIN

@interface SliderButton : UIView
/**
 * @param frame view的frame
 * @param fillColor 滑块填充色
 * @param strokeColor 滑块边框填充色
 * @param lineColor  底层线的颜色
 * @param selectedColor  已经滑动的线的颜色
 * @param percentage  滑块初始值
 * @param location  滑块滑动位置的返回 Block
 */
-(id)initWithFrame:(CGRect)frame andCircleFillColor:(UIColor *)fillColor andCircleStrokeColor:(UIColor*)strokeColor andLineColor:(UIColor *)lineColor andselectedLineColor:(UIColor *)selectedColor andStartLocation:(CGFloat)percentage andLocationBlock:(SliderLocation)location;
@end

NS_ASSUME_NONNULL_END
