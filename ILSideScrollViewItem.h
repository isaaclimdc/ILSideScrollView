//
//  ILSideScrollViewItem.h
//  ILSideScrollViewDemo
//
//  Created by Isaac Lim on 1/6/13.
//  Copyright (c) 2013 isaacl.net. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ILSideScrollViewItem : NSObject

@property (strong, nonatomic) NSString *title;

@property (strong, nonatomic) UIImage *defaultBackgroundImage;
@property (strong, nonatomic) UIImage *selectedBackgroundImage;
@property (strong, nonatomic) UIColor *backgroundColor;

@property (strong, nonatomic) UIColor *defaultTitleColor;
@property (strong, nonatomic) UIColor *selectedTitleColor;
@property (strong, nonatomic) UIFont *titleFont;

@property (nonatomic, readonly) id target;
@property (nonatomic, readonly) SEL action;
@property (nonatomic, readonly) id object;

/**
 * Instantiates a ILSideScrollViewItem object with the default appearance.
 * @param none
 *
 * @return The ILSideScrollViewItem object.
 */
+ (ILSideScrollViewItem *)item;

/**
 * Sets the tap action of an item to the given action, optionally with an argument object.
 * @param target The target to perform the selector.
 * @param action The selector to be performed. If the object parameter is not nil, then the method to be called here must have exactly 1 parameter, of any type. If multiple parameters are needed, encapsulate them in an NSDictionary.
 *
 * @return object The parameter to pass into action's method call.
 */
- (void)setTarget:(id)target action:(SEL)action withObject:(id)object;

@end
