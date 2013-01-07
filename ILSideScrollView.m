//
// ILSideScrollView.m
// Version 1.0
// Created by Isaac Lim (isaacl.net) on 1/1/13.
//

#import "ILSideScrollView.h"

/* Default Settings */
#define kILSideScrollViewBackgroundColor [UIColor whiteColor]
#define kILSideScrollViewIndicatorStyle UIScrollViewIndicatorStyleDefault
#define kILSideScrollViewItemBorderColor [UIColor blackColor]

/* Buffer distances */
#define kVerticalBuffer 10.0f
#define kHorizontalBuffer kVerticalBuffer

@interface ILSideScrollView() {
    CGFloat leftLength;
    CGFloat width;
    UIColor *_borderColor;
}

@end

@implementation ILSideScrollView

@synthesize items = _items;

#pragma mark - Init methods

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupDefaults];
    }
    return self;
}

- (void)setupDefaults {
    self.scrollsToTop = NO;
    leftLength = kHorizontalBuffer;

    /* Default settings */
    [self setBackgroundColor:kILSideScrollViewBackgroundColor
              indicatorStyle:kILSideScrollViewIndicatorStyle
             itemBorderColor:kILSideScrollViewItemBorderColor];
}

- (void)setBackgroundColor:(UIColor *)backgroundColor
            indicatorStyle:(UIScrollViewIndicatorStyle)style
           itemBorderColor:(UIColor *)borderColor
{
    self.backgroundColor = backgroundColor;
    self.indicatorStyle = style;
    _borderColor = borderColor;
}

#pragma mark - Data handling methods

- (void)populateSideScrollViewWithItems:(NSArray *)items {
    [self removeAllItems];

    self.items = [items mutableCopy];
    width = self.frame.size.height - (2 * kVerticalBuffer);

    /* Raise an exception if items contains foreign-typed objects */
    if (![self arrayContainsItemObjects:items]) {
        [NSException raise:@"ILSideScrollView array of wrong type" format:@"Array passed into populateSideScrollViewWithItems: contains objects that are not of type ILSideScrollViewItems."];
    }

    for (int i = 0; i < items.count; i++) {
        ILSideScrollViewItem *item = items[i];
        
        /* Create each square button */
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(leftLength, kVerticalBuffer, width, width);
        btn.layer.borderWidth = 1.0f;
        btn.layer.borderColor = _borderColor.CGColor;

        /* Set the item's action */
        btn.tag = i;
        [btn addTarget:self
                action:@selector(buttonTapped:)
      forControlEvents:UIControlEventTouchUpInside];

        /* Set the item's background properties */
        [btn setBackgroundColor:item.backgroundColor];
        [btn setBackgroundImage:item.defaultBackgroundImage
                       forState:UIControlStateNormal];
        [btn setBackgroundImage:item.selectedBackgroundImage
                       forState:UIControlStateHighlighted];

        /* Set the item's title properties */
        [btn setTitle:item.title
             forState:UIControlStateNormal];
        [btn setTitleColor:item.defaultTitleColor
                  forState:UIControlStateNormal];
        [btn setTitleColor:item.selectedTitleColor
                  forState:UIControlStateHighlighted];
        btn.titleLabel.font = item.titleFont;

        [self addSubview:btn];

        leftLength += width + kHorizontalBuffer;
    }

    self.contentSize = CGSizeMake(leftLength, self.frame.size.height);
}

- (void)buttonTapped:(id)sender {
    UIButton *btn = (UIButton *)sender;
    NSUInteger idx = btn.tag;
    ILSideScrollViewItem *item = self.items[idx];

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
    
    if (item.target != nil && item.action != nil) {
        [item.target performSelector:item.action withObject:item.object];
    }
    
#pragma clang diagnostic pop
}

/* Returns YES if array contains only ILSideScrollViewItem objects,
 * NO otherwise.
 */
- (BOOL)arrayContainsItemObjects:(NSArray *)array {
    for (int i = 0; i < array.count; i++) {
        if (![array[i] isMemberOfClass:[ILSideScrollViewItem class]])
            return NO;
    }

    return YES;
}

- (void)removeAllItems {
    [self.items removeAllObjects];
    leftLength = kHorizontalBuffer;

    for (UIView *view in self.subviews) {
        if ([view isKindOfClass:[UIButton class]]) {
            [view removeFromSuperview];
        }
    }
}

#pragma mark - Scrolling methods

- (void)scrollToLeftmost {
    CGRect left = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    [self scrollRectToVisible:left animated:YES];
}

- (void)scrollToItemAtIndex:(NSUInteger)index {
    CGFloat x = (kHorizontalBuffer+width) * (index+1);
    [self scrollRectToVisible:CGRectMake(x, 1, 2*width, 1) animated:YES];
}

@end
