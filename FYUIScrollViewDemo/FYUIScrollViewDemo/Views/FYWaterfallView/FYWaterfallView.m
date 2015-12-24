//
//  FYWaterfallView.m
//  FYUIScrollViewDemo
//
//  Created by Frankenstein Yang on 12/6/15.
//  Copyright © 2015 Frankenstein Yang. All rights reserved.
//

#import "FYWaterfallView.h"
#import "FYWaterfallViewCell.h"

#define FYWaterfallViewDefaultCellH           70
#define FYWaterfallViewDefaultMargin          8
#define FYWaterfallViewDefaultNumberOfColumns 3

@interface FYWaterfallView ()

@property (nonatomic, strong) NSMutableArray      *cellFrames;
@property (nonatomic, strong) NSMutableDictionary *displayingCells;
@property (nonatomic, strong) NSMutableSet        *reusableCells;

@end

@implementation FYWaterfallView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (NSMutableArray *)cellFrames {
    if (_cellFrames == nil) {
        self.cellFrames = [NSMutableArray array];
    }
    return _cellFrames;
}

- (NSMutableDictionary *)displayingCells {
    if (_displayingCells == nil) {
        self.displayingCells = [NSMutableDictionary dictionary];
    }
    return _displayingCells;
}

- (NSMutableSet *)reusableCells {
    if (_reusableCells == nil) {
        self.reusableCells = [NSMutableSet set];
    }
    return _reusableCells;
}

#pragma mark - Interface

- (CGFloat)cellWidth {
    NSUInteger numberOfColumns = [self numberOfColumns];
    CGFloat leftM = [self marginForType:FYWaterfallViewMarginTypeLeft];
    CGFloat rightM = [self marginForType:FYWaterfallViewMarginTypeRight];
    CGFloat columnM = [self marginForType:FYWaterfallViewMarginTypeColumn];
    CGFloat allColumnsM = (numberOfColumns - 1) * columnM;
    CGFloat viewWidth = self.bounds.size.width;
    return (viewWidth - leftM - rightM - allColumnsM) / numberOfColumns;
}

- (void)reloadData {
    [self.displayingCells.allValues makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [self.displayingCells removeAllObjects];
    [self.cellFrames removeAllObjects];
    [self.reusableCells removeAllObjects];
    
    NSUInteger numberOfCells = [self.dataSource numberOfCellsInWaterfallView:self];
    NSUInteger numberOfColumns = [self numberOfColumns];
    
    CGFloat topM = [self marginForType:FYWaterfallViewMarginTypeTop];
    CGFloat bottomM = [self marginForType:FYWaterfallViewMarginTypeBottom];
    CGFloat leftM = [self marginForType:FYWaterfallViewMarginTypeLeft];
    CGFloat columnM = [self marginForType:FYWaterfallViewMarginTypeColumn];
    CGFloat rowM = [self marginForType:FYWaterfallViewMarginTypeRow];
    
    CGFloat cellW = [self cellWidth];
    
    CGFloat maxYOfColumns[numberOfColumns];
    for (int i = 0; i < numberOfColumns; i ++) {
        maxYOfColumns[i] = 0.0f;
    }
    
    for (int i = 0; i < numberOfCells; i ++) {
        NSUInteger cellColumn = 0;
        CGFloat maxYOfCellColumn = maxYOfColumns[cellColumn];
        for (int j = 1; j < numberOfColumns; j ++) {
            if (maxYOfColumns[j] < maxYOfCellColumn) {
                cellColumn = j;
                maxYOfCellColumn = maxYOfColumns[j];
            }
        }
        CGFloat cellH = [self heightAtIndex:i];
        CGFloat cellX = leftM + cellColumn * (cellW + columnM);
        CGFloat cellY = 0;
        if (maxYOfCellColumn == 0.0) {
            cellY = topM;
        } else {
            cellY = maxYOfCellColumn + rowM;
        }
        CGRect cellFrame = CGRectMake(cellX, cellY, cellW, cellH);
        [self.cellFrames addObject:[NSValue valueWithCGRect:cellFrame]];
        
        maxYOfColumns[cellColumn] = CGRectGetMaxY(cellFrame);
    }
    CGFloat contentH = maxYOfColumns[0];
    for (int i = 1; i < numberOfColumns; i ++) {
        if (maxYOfColumns[i] > contentH) {
            contentH = maxYOfColumns[i];
        }
    }
    contentH += bottomM;
    self.contentSize = CGSizeMake(0, contentH);
}

/**
 *  UIScrollView滚动的时候调用
 */
- (void)layoutSubviews {
    [super layoutSubviews];
    NSUInteger numberOfCells = [self.cellFrames count];
    for (int i = 0; i < numberOfCells; i ++) {
        CGRect cellFrame = [self.cellFrames[i] CGRectValue];
        FYWaterfallViewCell *cell = self.displayingCells[@(i)];
        if ([self isInScreen:cellFrame]) {
            if (cell == nil) {
                cell = [self.dataSource waterfallView:self cellAtIndex:i];
                cell.frame = cellFrame;
                [self addSubview:cell];
                self.displayingCells[@(i)] = cell;
            }
        } else {
            if (cell) {
                [cell removeFromSuperview];
                [self.displayingCells removeObjectForKey:@(i)];
                [self.reusableCells addObject:cell];
            }
        }
    }
}

- (id)dequeueReusableCellWithIdentifier:(NSString *)identifier {
    __block FYWaterfallViewCell *reusableCell = nil;
    [self.reusableCells enumerateObjectsUsingBlock:^(FYWaterfallViewCell *cell,
                                                     BOOL * _Nonnull stop) {
        if ([cell.identifier isEqualToString:identifier]) {
            reusableCell = cell;
            *stop = YES;
        }
    }];
    if (reusableCell) {
        [self.reusableCells removeObject:reusableCell];
    }
    return reusableCell;
}

#pragma mark - Private Methods

/**
 *  列数
 */
- (NSUInteger)numberOfColumns {
    if ([self.dataSource respondsToSelector:@selector(numberOfColumnsInWaterfallView:)]) {
        return [self.dataSource numberOfColumnsInWaterfallView:self];
    } else {
        return FYWaterfallViewDefaultNumberOfColumns;
    }
}

- (CGFloat)heightAtIndex:(NSUInteger)index {
    if ([self.delegate respondsToSelector:@selector(waterfallView:heightAtIndex:)]) {
        return [self.delegate waterfallView:self heightAtIndex:index];
    } else {
        return FYWaterfallViewDefaultCellH;
    }
}

/**
 *  间距
 */
- (CGFloat)marginForType:(FYWaterfallViewMarginType)type {
    if ([self.delegate respondsToSelector:@selector(waterfallView:marginForType:)]) {
        return [self.delegate waterfallView:self marginForType:type];
    } else {
        return FYWaterfallViewDefaultMargin;
    }
}

- (BOOL)isInScreen:(CGRect)frame {
    return (CGRectGetMaxY(frame) > self.contentOffset.y) &&
    (CGRectGetMinY(frame) < self.contentOffset.y + self.bounds.size.height);
}

#pragma mark - Event Handlers

- (void)touchesEnded:(NSSet<UITouch *> *)touches
           withEvent:(UIEvent *)event {
    
    if (![self.delegate respondsToSelector:@selector(waterfallView:didSelectAtIndex:)]) {
        return;
    }
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self];
    
    __block NSNumber *selectedIndex = nil;
    [self.displayingCells enumerateKeysAndObjectsUsingBlock:^(id _Nonnull key,
                                                              FYWaterfallViewCell * _Nonnull cell,
                                                              BOOL * _Nonnull stop) {
        
        if (CGRectContainsPoint(cell.frame, point)) {
            selectedIndex = key;
            *stop = YES;
        }
        
    }];
    
    if (selectedIndex) {
        [self.delegate waterfallView:self
                    didSelectAtIndex:selectedIndex.unsignedIntegerValue];
    }
}

@end
