//
// ILSideScrollView.h
// Version 1.0
// Created by Isaac Lim (isaacl.net) on 1/1/13.
//

// This code is distributed under the terms and conditions of the MIT license.
//
// Copyright (c) 2013 isaacl.net. All rights reserved.
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is 
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "ILSideScrollViewItem.h"

@interface ILSideScrollView : UIScrollView {
    NSMutableArray *_items;
}

@property (nonatomic, retain) NSMutableArray *items;

/**
 * Sets some appearance properties of the receiver ILSideScrollView.
 * @param backgroundColor The color of the entire ILSideScrollView's background.
 * @param style The color of the horizontal scroll bar.
 * @param borderColor The color of each item's square border.
 *
 * @return none
 */
- (void)setBackgroundColor:(UIColor *)backgroundColor
            indicatorStyle:(UIScrollViewIndicatorStyle)style
           itemBorderColor:(UIColor *)borderColor;

/**
 * Displays the ILSideScrollViewItem objects in the items array in the receiver ILSideScrollView.
 * @param items An array consisting of the objects to display in the scroll view. These must be ILSideScrollViewItem objects, and can be configured with the properties declared in @see ILSideScrollViewItem.h. These objects will be transformed into UIButtons and added into the scroll view.
 *
 * @return none
 *
 * @exception Raises "ILSideScrollView array of wrong type" if the items array contains objects that are not of type ILSideScrollViewItem.
 */
- (void)populateSideScrollViewWithItems:(NSArray *)items;

/**
 * Scroll to the leftmost edge of the receiver ILSideScrollView.
 */
- (void)scrollToLeftmost;

/**
 * Scroll the receiver ILSideScrollView to show the item at the given index.
 * @param index The index of the item in the given scroll view. The leftmost item has index 0.
 *
 * @return none
 */
- (void)scrollToItemAtIndex:(NSUInteger)index;

@end
