ILSideScrollView
================

A sideways-scrolling selection scroll view

### Version 1.0

Overview
--------
`ILSideScrollView` is a tool for presenting options for a user to select, usually for *supporting* data. As such, the scroller works horizontally instead of vertically like for the *main* data. This scroll view is perfect for letting the user select fonts, colors, and other options. The user can configure each item in the scroll view in many ways, including appearances and to optionally invoke a method when the item is tapped.

See `ILSideScrollView` **in action** in this [short demo on YouTube](http://youtu.be/Ro_p_ItfeMY).

**Seleting a color scheme (with preview):**  
![Selecting font](http://isaacl.net/images/libraries/ILSideScrollView/2.png)

**Seleting a font (with preview):**  
![Selecting font](http://isaacl.net/images/libraries/ILSideScrollView/3.png)

**Customization in the demo app:**  
![Default appearance](http://isaacl.net/images/libraries/ILSideScrollView/1.png)

How to use
----------
A demo project `ILSideScrollViewDemo` is included to show how `ILSideScrollView` can be integrated into a project. It demos several ways that it can be put to good use.

#### Preparation
1. Copy the following 4 files into your Xcode project. Be sure to check "Copy items into destination's group folder".
    - `ILSideScrollView.h`
    - `ILSideScrollView.m`
    - `ILSideScrollViewItem.h`
    - `ILSideScrollViewItem.m`
2. Add the `QuartzCore` framework to your project by clicking on your project's name at the top of the sidebar in Xcode, then going into "Build Phases". In this tab, expand "Link Binaries With Libraries" and add `QuartzCore.framework`.
3. Add the line `#include "ILSideScrollView.h"` to the interface of the view controller that you wish to use `ILSideScrollView` in. If you intend to use `ILSideScrollView` in multiple view controllers,  add the above include line to the `YourAppName-Prefix.pch` file in the "Supporting Files" group. This way, `ILSideScrollView` will be available to every file in your project without needing to keep adding a `#include`.
        
#### Creating an array of `ILSideScrollViewItem` objects
1. Initialize a new mutable array. This array will contain **only** `ILSideScrollViewItem` objects. 

        NSMutableArray *items = [NSMutableArray array];

2. Create a new `ILSideScrollViewItem` (subclass of `NSObject`) object for each item you need in the scroll view. This can be done in a loop or manually. Calling `+item` will do this for you with the default appearance.

        ILSideScrollViewItem *item = [ILSideScrollViewItem item];

3. Set the desired appearance properties of each item to suit your needs. As of v1.0, the following self-explanatory properties are declared in `ILSideScrollViewItem.h`:

        NSString *title;

        UIImage *defaultBackgroundImage;
        UIImage *selectedBackgroundImage;
        UIColor *backgroundColor;
        
        UIColor *defaultTitleColor;
        UIColor *selectedTitleColor;
        UIFont *titleFont;

4. The tap action is also a property of `ILSideScrollViewItem`, but is designated `readonly`. To give an item an action, use the `-setTarget:action:withObject:` method.
        
        ...
        UIColor *aColor = [UIColor colorWithRed:red green:green blue:blue alpha:1.0];

        /* Tapping on a square will set the navigation bar to that color */
        [item setTarget:self action:@selector(changeNavBarColor:) withObject:aColor];
        
        ...
        
        - (void)changeNavBarColor:(UIColor *)color {
            self.navigationController.navigationBar.tintColor = color;
        }

    The polymorphic `object` parameter is a way to pass an arbitrary object to the method call specified in the `action` parameter. In the example above, the `aColor` object given to `-setTarget:action:withObject:` will automatically be passed into `changeNavBarColor:` when the `ILSideScrollViewItem` is tapped.
    
    If no arguments are needed, set the `object` parameter to `nil`. If multiple arguments need to be passed, encapsulate them in an `NSDictionary` and set `object` to that dictionary.
    
    Note that any parameter after the first one in the given selector will be ignored.

5. Add the `ILSideScrollViewItem` instance to the mutable array.

        [items addObject:item];

#### Initializing and populating the scroll view
1. In the view controller's `-viewDidLoad:` method, call `-initWithFrame:`

        ILSideScrollView *scroller = [[ILSideScrollView alloc] initWithFrame:
                                         CGRectMake(x,y,w,h)];

2. To use the default appearance settings for the scroll view, skip this step. To customize, call `-setBackgroundColor:indicatorStyle:itemBorderColor:`

        [scroller setBackgroundColor:[UIColor blackColor]
                      indicatorStyle:UIScrollViewIndicatorStyleWhite
                     itemBorderColor:[UIColor whiteColor]];

3. Finally, populate the scroll view by calling `-populateSideScrollViewWithItems:` and pass it the array of `ILSideScrollViewItem` objects you created earlier.

        [scroller populateSideScrollViewWithItems:items];
        
    Note that this method raises an exception if `items`contains objects that are not of type `ILSideScrollViewItem`.
    
4. Add the completed scroll view to the view controller's view, and you're done!

        [self.view addSubview:scroller];

Requirements
------------
- ARC
- iOS 5.0 or later
- The `QuartzCore` framework

Contact
-------
Isaac Lim  
[isaacl.net](http://isaacl.net)

Version History
---------------
**1.0**
- First publish to Github

License
-------
 ILSideScrollView is distributed under the terms and conditions of the MIT license.

 Copyright (c) 2013 isaacl.net. All rights reserved.

 Permission is hereby granted, free of charge, to any person obtaining a copy
 of this software and associated documentation files (the "Software"), to deal
 in the Software without restriction, including without limitation the rights
 to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 copies of the Software, and to permit persons to whom the Software is
 furnished to do so, subject to the following conditions:

 The above copyright notice and this permission notice shall be included in
 all copies or substantial portions of the Software.

 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 THE SOFTWARE.
