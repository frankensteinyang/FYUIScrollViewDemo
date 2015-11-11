//
//  FYUIButton.m
//  FYUIScrollViewDemo
//
//  Created by Frankenstein Yang on 11/11/15.
//  Copyright © 2015 Frankenstein Yang. All rights reserved.
//

#import "FYUIButton.h"

@interface FYUIButton () {

}

@property (nonatomic, assign) FYUIButtonStyle style;

@end

@implementation FYUIButton

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)initWithFrame:(CGRect)frame style:(FYUIButtonStyle)style {
    if (self = [super initWithFrame:frame]) {
        self.style = style;
        self.userInteractionEnabled = YES;
    }
    return self;
}

@end
