//
//  ViewController.m
//  ILSideScrollViewDemo
//
//  Created by Isaac Lim on 1/6/13.
//  Copyright (c) 2013 isaacl.net. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    /* Scroller1 has default appearance settings, colored titles, varying
     * fonts, and no actions
     */
    [self setupScroller1];

    /* Scroller2 has a large number of items, varying background color. Tapping
     * on items changes the navigation bar to that item's color.
     */
    [self setupScroller2];

    /* Scroller3 has a completely customized appearance, alert actions */
    [self setupScroller3];
}

#pragma mark - Setup Scrollers

- (void)setupScroller1 {
    NSMutableArray *items = [NSMutableArray array];
    
    ILSideScrollViewItem *item1 = [ILSideScrollViewItem item];
    item1.title = @"Red";
    item1.defaultTitleColor = [UIColor redColor];
    item1.titleFont = [UIFont fontWithName:@"MarkerFelt-Wide" size:20];
    [items addObject:item1];

    ILSideScrollViewItem *item2 = [ILSideScrollViewItem item];
    item2.title = @"Green";
    item2.defaultTitleColor = [UIColor greenColor];
    item2.titleFont = [UIFont fontWithName:@"TimesNewRomanPS-BoldMT" size:20];
    [items addObject:item2];

    ILSideScrollViewItem *item3 = [ILSideScrollViewItem item];
    item3.title = @"Purple";
    item3.defaultTitleColor = [UIColor purpleColor];
    item3.titleFont = [UIFont fontWithName:@"Papyrus" size:20];
    [items addObject:item3];

    ILSideScrollViewItem *item4 = [ILSideScrollViewItem item];
    item4.title = @"Blue";
    item4.defaultTitleColor = [UIColor blueColor];
    item4.titleFont = [UIFont fontWithName:@"HelveticaNeue-UltraLight" size:20];
    [items addObject:item4];
    
    scroller1 = [[ILSideScrollView alloc] initWithFrame:
                                   CGRectMake(0,
                                              0,
                                              self.view.frame.size.width,
                                              100)];
    [scroller1 populateSideScrollViewWithItems:items];

    [self.view addSubview:scroller1];
}

- (void)setupScroller2 {
    NSMutableArray *items = [NSMutableArray array];

    for (int i = 0; i < 256; i++) {
        ILSideScrollViewItem *item = [ILSideScrollViewItem item];

        /* Get a smooth blend of colors from black -> red -> green -> blue */
        CGFloat red, green, blue;
        if (i <= 85) {
            red = i/85.0;
            green = 0;
            blue = 0;
        }
        else if (i <= 170) {
            green = (i-85.0)/85.0;
            red = 1-green;
            blue = 0;
        }
        else {
            red = 0;
            blue = (i-170.0)/85.0;
            green = 1-blue;
        }
        
        UIColor *color = [UIColor colorWithRed:red green:green blue:blue alpha:1.0];
        item.backgroundColor = color;

        /* Tapping on a square will set the navigation bar to that color */
        [item setTarget:self action:@selector(changeNavBarColor:) withObject:color];
        
        [items addObject:item];
    }

	scroller2 = [[ILSideScrollView alloc] initWithFrame:
                                   CGRectMake(0,
                                              scroller1.frame.origin.y+scroller1.frame.size.height,
                                              self.view.frame.size.width,
                                              150)];
    [scroller2 setBackgroundColor:[UIColor blackColor]
                   indicatorStyle:UIScrollViewIndicatorStyleWhite
                  itemBorderColor:[UIColor whiteColor]];
    [scroller2 populateSideScrollViewWithItems:items];
    
    [self.view addSubview:scroller2];
}

- (void)setupScroller3 {
    NSMutableArray *items = [NSMutableArray array];

    for (int i = 'A'; i <= 'J'; i++) {
        ILSideScrollViewItem *item = [ILSideScrollViewItem item];
        item.title = [NSString stringWithFormat:@"%c", i];
        item.backgroundColor = [UIColor colorWithPatternImage:
                                [UIImage imageNamed:@"wood.png"]];
        item.defaultTitleColor = [UIColor brownColor];
        item.selectedTitleColor = [UIColor redColor];
        item.titleFont = [UIFont fontWithName:@"MarkerFelt-Wide" size:60];
        [item setTarget:self action:@selector(showAlertForItem:) withObject:item];
        [items addObject:item];
    }

    CGFloat originY = scroller2.frame.origin.y+scroller2.frame.size.height;
	scroller3 = [[ILSideScrollView alloc] initWithFrame:
                                   CGRectMake(0,
                                              originY,
                                              self.view.frame.size.width,
                                              self.view.frame.size.height-self.navigationController.navigationBar.frame.size.height-originY)];
    [scroller3 setBackgroundColor:[UIColor brownColor]
                   indicatorStyle:UIScrollViewIndicatorStyleWhite
                  itemBorderColor:[UIColor blackColor]];
    [scroller3 populateSideScrollViewWithItems:items];

    [self.view addSubview:scroller3];
}

#pragma mark - Actions

- (void)changeNavBarColor:(UIColor *)color {
    self.navigationController.navigationBar.tintColor = color;
}

- (void)showAlertForItem:(ILSideScrollViewItem *)item {
    NSString *title = [NSString stringWithFormat:@"You tapped on the giant %@!", item.title];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title
                                                    message:nil
                                                   delegate:self
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
	[alert show];
}

@end
