//
//  ILSideScrollViewItem.m
//  ILSideScrollViewDemo
//
//  Created by Isaac Lim on 1/6/13.
//  Copyright (c) 2013 isaacl.net. All rights reserved.
//

#define kILSideScrollViewItemBkgColor [UIColor whiteColor]
#define kILSideScrollViewItemDefaultTitleColor [UIColor blackColor]
#define kILSideScrollViewItemSelectedTitleColor [UIColor grayColor]
#define kILSideScrollViewItemTitleFont [UIFont boldSystemFontOfSize:18]

#import "ILSideScrollViewItem.h"

@interface ILSideScrollViewItem()

@property (nonatomic) id target;
@property (nonatomic) SEL action;
@property (nonatomic) id object;

@end

@implementation ILSideScrollViewItem

+ (ILSideScrollViewItem *)item {
    ILSideScrollViewItem *newItem = [[ILSideScrollViewItem alloc] init];
    newItem.title = nil;
    newItem.backgroundColor = kILSideScrollViewItemBkgColor;
    newItem.defaultBackgroundImage = nil;
    newItem.selectedBackgroundImage = nil;
    newItem.target = nil;
    newItem.action = nil;
    newItem.defaultTitleColor = kILSideScrollViewItemDefaultTitleColor;
    newItem.selectedTitleColor = kILSideScrollViewItemSelectedTitleColor;
    newItem.titleFont = kILSideScrollViewItemTitleFont;
    
    return newItem;
}

- (void)setTarget:(id)target action:(SEL)action withObject:(id)object {
    self.target = target;
    self.action = action;
    self.object = object;
}

@end
