//
//  Lagranji BanadzevViewController.m
//  DiplomaWork
//
//  Created by Meri on 12/3/16.
//  Copyright © 2016 Meri. All rights reserved.
//

#import "Lagranji BanadzevViewController.h"

#import "CustomTableViewCell.h"

@interface Lagranji_BanadzevViewController () <UIPickerViewDataSource,UIPickerViewDelegate, UITextViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIPickerView *pickerView;
@property(weak, nonatomic) NSMutableArray *arrayOfXLebles;
@property (assign, nonatomic) NSInteger numberOfN;
@property(strong, nonatomic) NSMutableDictionary *dic;

@property (weak, nonatomic) IBOutlet UITextField *valueForCount; //x
@end

@implementation Lagranji_BanadzevViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.numberOfN = 1;
    self.tableView.backgroundColor = [UIColor clearColor];
    [self hideKeyboardWhenTouchingBackground];
 
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
        [self.valueForCount setText: @""];
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
    return self.numberOfN;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CustomTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    [cell setStacox: self];
    NSString *xValue = [self.dic valueForKey: [NSString stringWithFormat: @"X%ld",(long)indexPath.row]];
    NSString *yValue = [self.dic valueForKey: [NSString stringWithFormat: @"Y%ld",(long)indexPath.row]];
    [cell updateCell:indexPath.row xValue: xValue yValue: yValue];
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
-(void)saveValue:(NSString *) labelTextX keyX:(NSString *)key saveValue:(NSString *) labelTextY keyY:(NSString *)key1{
    [self.dic setValue: labelTextX forKey: key];
    [self.dic setValue: labelTextY forKey: key1];
    
//    NSLog(@"%@",self.dic);
}

#pragma mark -Counting Lagrange
-(NSInteger)countLagrange{
    NSInteger sum = 0;
    for (int i = 0; i < self.numberOfN; ++i) {
        NSInteger mult = 1;
       for (int j = 0; j < self.numberOfN; ++j) {
        
           NSString *xIKey = [NSString stringWithFormat: @"X%ld",(long)i];
           NSInteger xI = [[self.dic valueForKey: xIKey] integerValue];
//           NSLog(@"i=%d j=%d ---- xi=%ld", i, j, (long)xI);
           NSString *xJKey = [NSString stringWithFormat: @"X%ld",(long)j];
           NSInteger xJ = [[self.dic valueForKey: xJKey] integerValue];
//           NSLog(@"i=%d j=%d ---- xj=%ld mult = %ld", i, j, (long)xJ, (long)mult);
           
           if (j != i) {
               mult *= (self.valueForCount.text.integerValue - xJ) / (xI - xJ);
               NSLog(@"%ld", (long)mult);
           }
           
       }
        
        NSString *yIKey = [NSString stringWithFormat: @"Y%ld",(long)i];
        NSInteger yI = [[self.dic valueForKey: yIKey] integerValue];
//        NSLog(@"y=%ld", (long)yI);
        sum += (mult * yI);
        NSLog(@"%ld", (long)sum);
    }
    return sum;
}

#pragma mark - UIAlertView
-(IBAction)Alert{
    NSInteger m = [self countLagrange];
    NSLog(@"%ld", (long)m);
    NSString *inStr = [NSString stringWithFormat: @"%ld", (long)m];
    
    UIAlertController * alert = [UIAlertController
                                 alertControllerWithTitle:@"Sum"
                                 message:inStr
                                 preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction* yesButton = [UIAlertAction
                                actionWithTitle:@"OK"
                                style:UIAlertActionStyleDefault
                                handler:^(UIAlertAction * action) {
                                }];
//    
//    UIAlertAction* noButton = [UIAlertAction
//                               actionWithTitle:@"No, thanks"
//                               style:UIAlertActionStyleDefault
//                               handler:^(UIAlertAction * action) {
//                                   //Handle no, thanks button
//                               }];
    
    [alert addAction:yesButton];
//    [alert addAction:noButton];
    
    [self presentViewController:alert animated:YES completion:nil];
}
@end
