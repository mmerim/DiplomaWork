//
//  SimpsoniBanadzevViewController.m
//  DiplomaWork
//
//  Created by Meri on 12/7/16.
//  Copyright © 2016 Meri. All rights reserved.
//

#import "SimpsoniBanadzevViewController.h"
#import "CustomIntegralTableViewCell.h"



@interface SimpsoniBanadzevViewController () <UIPickerViewDataSource,UIPickerViewDelegate, UITextViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITextField *aValue;
@property (weak, nonatomic) IBOutlet UITextField *bValue;
@property (weak, nonatomic) IBOutlet UIPickerView *pickerView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIButton *hashvelButton;


@property(weak, nonatomic) NSMutableArray *arrayOfXLebles;
@property (assign, nonatomic) NSInteger numberOfN;
@property(strong, nonatomic) NSMutableDictionary *dic;
@property(strong, nonatomic) NSString *yValue;

@end

@implementation SimpsoniBanadzevViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    
//    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"Math-1.png"]];
    self.navigationItem.title = @"Սիմպսոնի բանաձեւ";
    [self.hashvelButton setTitle:@"Հաշվել" forState:
     UIControlStateNormal];
    
    self.numberOfN = 1;
    self.tableView.backgroundColor = [UIColor clearColor];
    
    [self hideKeyboardWhenTouchingBackground];
    //    [self.hashvelButton setEnabled:NO];
    
    self.dic = [[NSMutableDictionary alloc]init];
}


- (void) viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    self.tabBarController.title = self.tabBarItem.title;
    [self addKeyboardObservsers];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [self removeKeyboardObservsers];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    if ([textField.text rangeOfCharacterFromSet:[NSCharacterSet letterCharacterSet]].location != NSNotFound) {
        [self.aValue setText:@""];
        [self.bValue setText:@""];
    }
    return YES;
}


// The number of columns of data
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

// The number of rows of data
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return 900;
}


#pragma mark - PickerView
- (NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return  [NSString stringWithFormat:@"%ld",(long)row+1];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger) component {
    self.numberOfN = row+1;
    [self.tableView reloadData];
}

#pragma mark - TableView
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.numberOfN + 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CustomIntegralTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    [cell setStacox: self];
    self.yValue = [self.dic valueForKey: [NSString stringWithFormat: @"Y%ld",(long)indexPath.row]];
    [cell updateCell:indexPath.row yValue: self.yValue];
    return cell;
}

#pragma mark - Hide keyboard when touching in the background
- (void)handleSingleTap:(UITapGestureRecognizer *) sender
{
    [self.view endEditing:YES];
}

-(void)hideKeyboardWhenTouchingBackground
{
    UIGestureRecognizer *tapper;
    tapper = [[UITapGestureRecognizer alloc]
              initWithTarget:self action:@selector(handleSingleTap:)];
    tapper.cancelsTouchesInView = NO;
    [self.view addGestureRecognizer:tapper];
}

#pragma mark - Keyboard
-(void)addKeyboardObservsers {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardShown:) name:UIKeyboardWillShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardHidden:) name:UIKeyboardWillHideNotification object:nil];
}

-(void)removeKeyboardObservsers {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}

-(void)keyboardShown:(NSNotification*) notification
{
    NSDictionary* info = [notification userInfo];
    double animationDuration = [[info objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    CGSize keyboardSize = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    
    [UIView animateWithDuration:animationDuration animations:^{
        self.tableView.contentInset = UIEdgeInsetsMake(0.0, 0.0, keyboardSize.height, 0.0);
        self.tableView.scrollIndicatorInsets = UIEdgeInsetsMake(0.0, 0.0, keyboardSize.height, 0.0);
    }];
    
    
}

-(void)keyboardHidden:(NSNotification*)notification {
    double animationDuration = [[[notification userInfo] objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    [UIView animateWithDuration:animationDuration
                     animations:^{
                         self.tableView.contentInset = UIEdgeInsetsZero;
                         self.tableView.scrollIndicatorInsets =UIEdgeInsetsZero;
                     }];
}
-(void)saveValue:(NSString *) labelTextY keyY:(NSString *)key {
    [self.dic setValue: labelTextY forKey: key];
    
    //    NSLog(@"%@",self.dic);
}
#pragma mark -Counting Simpson
-(double)countSimpson{
    double h = (self.bValue.text.doubleValue - self.aValue.text.doubleValue) / self.numberOfN;
    double sum1 = 0;
    for (int i = 1; i <= self.numberOfN - 1; ++i) {
        NSString *yIKey = [NSString stringWithFormat: @"Y%ld",(long)2*i];
        NSInteger yI = [[self.dic valueForKey: yIKey] integerValue];
        sum1 += yI;
    }
    double sum2 = 0;
    for (int i = 1; i <= self.numberOfN; ++i) {
        NSString *y2I1Key = [NSString stringWithFormat: @"Y%ld",(long)2*i-1];
        NSInteger yI1 = [[self.dic valueForKey: y2I1Key] integerValue];
        sum2 += yI1;
    }
    NSString *y0Key = [NSString stringWithFormat: @"Y%ld",(long)0];
    NSInteger y0 = [[self.dic valueForKey: y0Key] integerValue];
    NSString *y2nKey = [NSString stringWithFormat: @"Y%ld",(long)self.numberOfN];
    NSInteger y2n = [[self.dic valueForKey: y2nKey] integerValue];
    double sum = (h / 3) * (y0 + (2*sum1) + (4*sum2) + y2n);
    return sum;
}

#pragma mark - UIAlertView
-(IBAction)Alert{
    double m = [self countSimpson];
    NSLog(@"%f", m);
    NSString *inStr = [NSString stringWithFormat: @"%f", m];
    
    UIAlertController * alert = [UIAlertController
                                 alertControllerWithTitle:@"Սիմպսոնի բանաձեւի արդյունք՝"
                                 message:inStr
                                 preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction* yesButton = [UIAlertAction
                                actionWithTitle:@"OK"
                                style:UIAlertActionStyleDefault
                                handler:^(UIAlertAction * action) {
                                }];
    [alert addAction:yesButton];
    //    [alert addAction:noButton];
    
    [self presentViewController:alert animated:YES completion:nil];
}
@end
