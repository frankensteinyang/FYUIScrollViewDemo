//
//  FYBannerItemView.m
//  FYUIScrollViewDemo
//
//  Created by Frankenstein Yang on 11/24/15.
//  Copyright © 2015 Frankenstein Yang. All rights reserved.
//

#import <Masonry/Masonry.h>
#import <libextobjc/EXTScope.h>

#import "FYBannerItemView.h"
#import "FYDefine.h"

@implementation FYBannerItemView

- (void)dealloc {
    _imgView = nil;
    _url = nil;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.clipsToBounds = YES;
        self.userInteractionEnabled = YES;
        if (!kFYIOS7_OR_LATER) {
            self.backgroundColor = [UIColor clearColor];
            self.opaque = NO;
        }
        [self addSubview:self.imgView];
        [self makeConstraint];
    }
    return self;
}

#pragma mark - Lazy Loading

- (UIImageView *)imgView {
    if (!_imgView) {
        _imgView = [[UIImageView alloc] init];
        _imgView.userInteractionEnabled = YES;
        [_imgView setContentMode:UIViewContentModeScaleToFill];
        _imgView.clipsToBounds = YES;
        if (!kFYIOS7_OR_LATER) {
            _imgView.backgroundColor = [UIColor clearColor];
        }
    }
    return _imgView;
}

#pragma mark - Constraint

- (void)makeConstraint {
    @weakify(self);
    [self.imgView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.size.mas_equalTo(self);
        make.center.mas_equalTo(self);
    }];
}



@end
