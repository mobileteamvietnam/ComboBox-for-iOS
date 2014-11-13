//
//  ComboBox.h
//  test
//
//  Created by Nguyen Tran Viet on 11/13/14.
//  Copyright (c) 2014 JF2. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ComboBox : UIControl

@property (nonatomic, readwrite, retain) UIView *inputView;
@property (nonatomic, readwrite, retain) UIView *inputAccessoryView;

@property (strong, nonatomic) NSArray *entries;
@property (nonatomic) NSUInteger currentSelectedIndex;

- (void)loadDisplayValue;

@end
