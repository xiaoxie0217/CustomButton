//
//  ChooseIntervalButton.h
//  Button
//
//  Created by 谢立新 on 2019/8/26.
//  Copyright © 2019 谢立新. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^Interval)(CGFloat start,CGFloat end);
NS_ASSUME_NONNULL_BEGIN

@interface ChooseIntervalButton : UIView
@property (nonatomic,copy) Interval myBlock;
@end

NS_ASSUME_NONNULL_END
