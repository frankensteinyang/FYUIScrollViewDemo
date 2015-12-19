//
//  FYCommodityCell.m
//  FYUIScrollViewDemo
//
//  Created by Frankenstein Yang on 12/11/15.
//  Copyright © 2015 Frankenstein Yang. All rights reserved.
//

#import <SDWebImage/UIImageView+WebCache.h>

#import "FYCommodityCell.h"
#import "FYWaterfallView.h"
#import "FYCommodityModel.h"

@interface FYCommodityCell ()

@property (weak, nonatomic) UIImageView *imageView;
@property (weak, nonatomic) UILabel *priceLabel;

@end

@implementation FYCommodityCell

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

+ (instancetype)cellWithWaterfallView:(FYWaterfallView *)waterfallView {
    static NSString *cellID = @"FYCommodityCell";
    FYCommodityCell *cell = [waterfallView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[FYCommodityCell alloc] init];
        cell.identifier = cellID;
    }
    return cell;
}

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        UIImageView *imgView = [[UIImageView alloc] init];
        [self addSubview:imgView];
        self.imageView = imgView;
        
        UILabel *priceLbl = [[UILabel alloc] init];
        priceLbl.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.3];
        priceLbl.textAlignment = NSTextAlignmentCenter;
        priceLbl.textColor = [UIColor whiteColor];
        [self addSubview:priceLbl];
        self.priceLabel = priceLbl;
    }
    return self;
}

- (void)setCommodity:(FYCommodityModel *)commodity {
    _commodity = commodity;
    self.priceLabel.text = commodity.price;
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:commodity.img] placeholderImage:[UIImage imageNamed:@"Loading"]];
}

@end
