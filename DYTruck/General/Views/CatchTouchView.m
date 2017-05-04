//
//  CatchTouchView.m
//  维思诺
//
//  Created by Ian on 15-4-16.
//  Copyright (c) 2015年 iOS Mac o. All rights reserved.
//

#import "CatchTouchView.h"

@interface CatchTouchView ()

@property (strong, nonatomic) UIView *respondView;
@property (strong, nonatomic) MyBlock myBlock;

@end

@implementation CatchTouchView

- (id)initWithFrame:(CGRect)frame respondView:(UIView *)respondView block:(MyBlock)block
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.myBlock = block;
        self.respondView = respondView;
        self.backgroundColor = [UIColor clearColor];
        
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapEvent)];
        [self addGestureRecognizer:tap];
    }
    
    
    return self;
}

- (void)tapEvent
{
    self.myBlock(self);
}


- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event
{
    if (self.respondView)
    {
        CGPoint converPoint =  [self.respondView convertPoint:point fromView:self];
        
        if ([self.respondView pointInside:converPoint withEvent:event])
        {
              return [self.respondView hitTest:converPoint withEvent:event];
        }
    }
    
    NSLog(@"%@",[super hitTest:point withEvent:event]);
    return [super hitTest:point withEvent:event];
}


@end
