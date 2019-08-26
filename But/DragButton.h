//
//  DragButton.h
//  Button
//
//  Created by 谢立新 on 2019/8/24.
//  Copyright © 2019 谢立新. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface DragButton : UIView

@property (nonatomic,copy) void(^location)(CGFloat x,CGFloat y);

@end

NS_ASSUME_NONNULL_END
