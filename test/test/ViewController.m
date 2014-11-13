//
//  ViewController.m
//  test
//
//  Created by Nguyen Tran Viet on 11/13/14.
//  Copyright (c) 2014 JF2. All rights reserved.
//

#import "ViewController.h"
#import "ComboBox.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet ComboBox *timeComboBox;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    _timeComboBox.backgroundColor = [UIColor whiteColor];
    _timeComboBox.entries = @[@"15 minutes", @"30 minutes", @"1 hours", @"2 hours"];
    _timeComboBox.currentSelectedIndex = 1;
    [_timeComboBox loadDisplayValue];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

@end
