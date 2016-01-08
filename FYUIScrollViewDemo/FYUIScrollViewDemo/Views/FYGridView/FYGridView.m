//
//  FYGridView.m
//  FYUIScrollViewDemo
//
//  Created by Frankenstein Yang on 12/20/15.
//  Copyright © 2015 Frankenstein Yang. All rights reserved.
//

#import "FYGridView.h"

static const NSUInteger kTagOffset = 50;
static const CGFloat kDefaultAnimationDuration = 0.3;
static const UIViewAnimationOptions kDefaultAnimationOptions =
UIViewAnimationOptionBeginFromCurrentState |
UIViewAnimationOptionAllowUserInteraction;

@interface FYGridView () <UIGestureRecognizerDelegate, UIScrollViewDelegate> {
    
    UIScrollView *_scrollView;
    UIPanGestureRecognizer *_sortingPanGesture;
    UILongPressGestureRecognizer *_sortingLongPressGesture;
    UIPinchGestureRecognizer *_pinchGesture;
    UITapGestureRecognizer *_tapGesture;
    UIRotationGestureRecognizer *_rotationGesture;
    UIPanGestureRecognizer *_panGesture;
    NSInteger _numberTotalItems;
    CGSize _itemSize;
    NSMutableSet *_reusableCells;
    FYGridViewCell *_sortMovingItem;
    NSInteger _sortFuturePosition;
    BOOL _autoScrollActive;
    CGPoint _minPossibleContentOffset;
    CGPoint _maxPossibleContentOffset;
    FYGridViewCell *_transformingItem;
    CGFloat _lastRotation;
    CGFloat _lastScale;
    BOOL _inFullSizeMode;
    BOOL _rotationActive;
}

@property (nonatomic, readonly) BOOL itemsSubviewsCacheIsValid;
@property (nonatomic, strong) NSArray *itemSubviewsCache;
@property (atomic) NSInteger firstPositionLoaded;
@property (atomic) NSInteger lastPositionLoaded;

- (void)sortingPanGestureUpdated:(UIPanGestureRecognizer *)panGesture;
- (void)sortingLongPressGestureUpdated:(UILongPressGestureRecognizer *)longPressGesture;
- (void)tapGestureUpdated:(UITapGestureRecognizer *)tapGesture;
- (void)panGestureUpdated:(UIPanGestureRecognizer *)panGesture;
- (void)pinchGestureUpdated:(UIPinchGestureRecognizer *)pinchGesture;
- (void)rotationGestureUpdated:(UIRotationGestureRecognizer *)rotationGesture;

- (void)sortingMoveDidStartAtPoint:(CGPoint)point;
- (void)sortingMoveDidContinueToPoint:(CGPoint)point;
- (void)sortingMoveDidStopAtPoint:(CGPoint)point;
- (void)sortingAutoScrollMovementCheck;

- (void)transformingGestureDidBeginWithGesture:(UIGestureRecognizer *)gesture;
- (void)transformingGestureDidFinish;
- (BOOL)isInTransformingState;

- (void)recomputeSize;
- (void)relayoutItemsAnimated:(BOOL)animated;
- (NSArray *)itemSubviews;
- (FYGridViewCell *)cellForItemAtIndex:(NSInteger)position;
- (FYGridViewCell *)newItemSubviewForPosition:(NSInteger)position;
- (NSInteger)positionForItemSubview:(FYGridViewCell *)view;
- (void)setSubviewsCacheAsInvalid;

- (void)loadRequiredItems;
- (void)cleanUpUnseenItems;
- (void)queueReusableCell:(FYGridViewCell *)cell;

- (void)receivedMemoryWarningNotification:(NSNotification *)notification;

- (void)willRotate:(NSNotification *)notificaiton;

@end

@implementation FYGridView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)initWithFrame:(CGRect)frame {

    if (self = [super initWithFrame:frame]) {
        _scrollView = [[UIScrollView alloc] initWithFrame:[self bounds]];
        _scrollView.autoresizingMask = UIViewAutoresizingFlexibleWidth |
        UIViewAutoresizingFlexibleHeight;
        
        _scrollView.backgroundColor = [UIColor clearColor];
        
        _scrollView.delegate = self;
        [self addSubview:_scrollView];
        
        _tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                              action:@selector(tapGestureUpdated:)];
        _tapGesture.delegate = self;
        _tapGesture.numberOfTapsRequired = 1;
        _tapGesture.numberOfTouchesRequired = 1;
        [_scrollView addGestureRecognizer:_tapGesture];
        
        _pinchGesture = [[UIPinchGestureRecognizer alloc] initWithTarget:self
                                                                  action:@selector(pinchGestureUpdated:)];
        _pinchGesture.delegate = self;
        [self addGestureRecognizer:_pinchGesture];
        
        _rotationGesture = [[UIRotationGestureRecognizer alloc] initWithTarget:self
                                                                        action:@selector(rotationGestureUpdated:)];
        _rotationGesture.delegate = self;
        [self addGestureRecognizer:_rotationGesture];
        
        _panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panGestureUpdated:)];
        _panGesture.delegate = self;
        [_panGesture setMaximumNumberOfTouches:2];
        [_panGesture setMinimumNumberOfTouches:2];
        [self addGestureRecognizer:_panGesture];
        
    }
    return self;
}

- (void)sortingPanGestureUpdated:(UIPanGestureRecognizer *)panGesture {

}

- (void)sortingLongPressGestureUpdated:(UILongPressGestureRecognizer *)longPressGesture {

}

- (void)tapGestureUpdated:(UITapGestureRecognizer *)tapGesture {

}

- (void)panGestureUpdated:(UIPanGestureRecognizer *)panGesture {

}

- (void)pinchGestureUpdated:(UIPinchGestureRecognizer *)pinchGesture {

}

- (void)rotationGestureUpdated:(UIRotationGestureRecognizer *)rotationGesture {

}

//
- (void)sortingMoveDidStartAtPoint:(CGPoint)point {

}

- (void)sortingMoveDidContinueToPoint:(CGPoint)point {

}

- (void)sortingMoveDidStopAtPoint:(CGPoint)point {

}

- (void)sortingAutoScrollMovementCheck {

}

//

- (void)transformingGestureDidBeginWithGesture:(UIGestureRecognizer *)gesture {

}

- (void)transformingGestureDidFinish {

}

- (BOOL)isInTransformingState {

    return YES;
}

- (void)recomputeSize {

}

- (void)relayoutItemsAnimated:(BOOL)animated {

}

- (NSArray *)itemSubviews {

    return nil;
}

- (FYGridViewCell *)dequeueReusableCell {

    return nil;
}

- (FYGridViewCell *)cellForItemAtIndex:(NSInteger)position {

    return nil;
}

- (void)reloadData {

}

- (void)insertObjectAtIndex:(NSInteger)index {

}

- (void)removeObjectAtIndex:(NSInteger)index {

}

- (void)reloadObjectAtIndex:(NSInteger)index {

}

- (void)swapObjectAtIndex:(NSInteger)index toObjectAtIndex:(NSInteger)targetObjIndex {
    
}

- (void)scrollToObjectAtIndex:(NSInteger)index animated:(BOOL)animated {

}

- (FYGridViewCell *)newItemSubviewForPosition:(NSInteger)position {

    return nil;
}

- (void)receivedMemoryWarningNotification:(NSNotification *)notification {

}

- (void)cleanUpUnseenItems {

}

- (NSInteger)positionForItemSubview:(FYGridViewCell *)view {

    return 1;
}

- (void)queueReusableCell:(FYGridViewCell *)cell {

}

- (void)willRotate:(NSNotification *)notificaiton {

}

- (void)setSubviewsCacheAsInvalid {

}

- (void)loadRequiredItems {

}

@end
