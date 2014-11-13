//
//  ComboBox.m
//  test
//
//  Created by Nguyen Tran Viet on 11/13/14.
//  Copyright (c) 2014 JF2. All rights reserved.
//

#import "ComboBox.h"
#import <QuartzCore/QuartzCore.h>

@interface ComboBox () <UIPickerViewDataSource, UIPickerViewDelegate>

@property (nonatomic, strong) IBOutlet UIView *contentView;
@property (weak, nonatomic) IBOutlet UILabel *textLabel;
@property (weak, nonatomic) IBOutlet UIImageView *rightView;


@end

@implementation ComboBox

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self loadContentViewFromNib];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self loadContentViewFromNib];
    }
    return self;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self loadContentViewFromNib];
    }
    return self;
}

- (void)loadContentViewFromNib {
    NSString *className = NSStringFromClass([self class]);
    self.contentView = [[[NSBundle mainBundle] loadNibNamed:className owner:self options:nil] firstObject];
    [self addSubview:self.contentView];
    self.layer.cornerRadius = 7.;
    self.layer.borderWidth = .5;
    self.layer.borderColor = [UIColor grayColor].CGColor;
    self.layer.masksToBounds = YES;
    
    _contentView.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self addConstraint:[self pin:_contentView attribute:NSLayoutAttributeTop]];
    [self addConstraint:[self pin:_contentView attribute:NSLayoutAttributeLeft]];
    [self addConstraint:[self pin:_contentView attribute:NSLayoutAttributeBottom]];
    [self addConstraint:[self pin:_contentView attribute:NSLayoutAttributeRight]];
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapHandle)];
    [self addGestureRecognizer:tapGesture];
    self.userInteractionEnabled = YES;
}

- (NSLayoutConstraint *)pin:(id)item attribute:(NSLayoutAttribute)attribute
{
    return [NSLayoutConstraint constraintWithItem:self
                                        attribute:attribute
                                        relatedBy:NSLayoutRelationEqual
                                           toItem:item
                                        attribute:attribute
                                       multiplier:1.0
                                         constant:0.0];
}

#pragma mark - firstResponder
- (void)tapHandle {
#pragma mark - TODO: customize this action for iPhone and iPad
    [self becomeFirstResponder];
}

- (BOOL)canBecomeFirstResponder {
    return YES;
}

#pragma mark - change state when highlighed

-(void)setHighlighted:(BOOL)highlighted {
    [super setHighlighted:highlighted];
    _rightView.highlighted = highlighted; // change button to highlighed state
    _textLabel.highlighted = highlighted; // change label to highlighed state
    UIColor *shadowColor = highlighted ? [UIColor lightGrayColor] : nil;
    _textLabel.shadowColor = shadowColor;
}

#pragma mark - 'inputView' and 'inputAccessoryView'

-(UIView *)inputView {
    if (!_inputView) {
        UIPickerView *pickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 0, 320, 162)];
        pickerView.dataSource = self;
        pickerView.delegate = self;
        _inputView = pickerView;
    }
    
    UIPickerView *thePicker = (UIPickerView *)_inputView;
    [thePicker selectRow:_currentSelectedIndex inComponent:0 animated:NO];
    
    return _inputView;
}

- (UIView *)inputAccessoryView {
    if (!_inputAccessoryView) {
        UIToolbar *toolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
        UIBarButtonItem *flexibleItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
        UIBarButtonItem *doneItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(pressDone)];
        toolbar.items = @[flexibleItem, doneItem];
        _inputAccessoryView = toolbar;
    }
    return _inputAccessoryView;
}

- (void)pressDone {
    [self resignFirstResponder];
}

#pragma mark - UIPickerViewDataSource and UIPickerViewDelegate

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView
numberOfRowsInComponent:(NSInteger)component {
    return _entries.count;
}

- (NSString *)pickerView:(UIPickerView *)pickerView
             titleForRow:(NSInteger)row
            forComponent:(NSInteger)component {
    return _entries[row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    _currentSelectedIndex = row;
    [self loadDisplayValue];
}

#pragma mark - public method

- (void)loadDisplayValue {
    _textLabel.text = _entries[_currentSelectedIndex];
}

@end
