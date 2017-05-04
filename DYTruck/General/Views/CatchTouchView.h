//
//  CatchTouchView.h
//  维思诺
//
//  Created by Ian on 15-4-16.
//  Copyright (c) 2015年 iOS Mac o. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CatchTouchView;
typedef void(^MyBlock)(CatchTouchView *catchView);


@interface CatchTouchView : UIView

- (id)initWithFrame:(CGRect)frame respondView:(UIView *)respondView block:(MyBlock)block;

@end
