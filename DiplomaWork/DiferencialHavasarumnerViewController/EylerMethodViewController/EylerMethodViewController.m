//
//  EylerMethodViewController.m
//  DiplomaWork
//
//  Created by Meri on 4/16/17.
//  Copyright © 2017 Meri. All rights reserved.
//

#import "EylerMethodViewController.h"
#import "CustomDiferencialTableViewCell.h"


@interface EylerMethodViewController () <UIPickerViewDataSource,UIPickerViewDelegate, UITextViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITextField *hValue;
@property (weak, nonatomic) IBOutlet UITextField *x0Value;
@property (weak, nonatomic) IBOutlet UITextField *y0Value;
@property (weak, nonatomic) IBOutlet UIPickerView *pickerView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIButton *hashvelButton;

@property(weak, nonatomic) NSMutableArray *arrayOfXLebles;
@property(strong, nonatomic) NSMutableDictionary *dic;
@property(strong, nonatomic) NSString *aValue;

// for my counting
@property(retain, nonatomic) NSMutableArray *arrayOfXValues;
@property(retain, nonatomic) NSMutableArray *arrayOfYValues;
@property(retain, nonatomic) NSMutableArray *arrayOfFValues;

@end

@implementation EylerMethodViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"Էյլերի մեթոդ";
    [self.hashvelButton setTitle:@"Հաշվել" forState:UIControlStateNormal];
    
    self.numberOfN = 1;
    self.tableView.backgroundColor = [UIColor clearColor];
    
    [self hideKeyboardWhenTouchingBackground];
    
    if (!self.dic) self.dic = [[NSMutableDictionary alloc]init];
    
    //given elements of arrays
    if (!self.arrayOfXValues) self.arrayOfXValues = [[NSMutableArray alloc] init];
    self.arrayOfXValues[0] = self.x0Value;
    if (!self.arrayOfYValues) self.arrayOfYValues = [[NSMutableArray alloc] init];
    self.arrayOfYValues[0] = self.y0Value;
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
}

-(void) clearContents{
    [self.hValue setText:@""];
    [self.x0Value setText:@""];
    [self.y0Value setText:@""];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    if ([textField.text rangeOfCharacterFromSet:[NSCharacterSet letterCharacterSet]].location != NSNotFound) {
        [self clearContents];
    }
    return YES;
}

#pragma mark - PickerView
// The number of columns of data
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

// The number of rows of data
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return 900;
}

- (NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return  [NSString stringWithFormat:@"%ld",(long)row+1];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger) component {
    self.numberOfN = row+1;
    [self.tableView reloadData];
}

#pragma mark - TableView
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSInteger count = ( (self.numberOfN + 1) * (self.numberOfN + 2) ) / 2;
    return count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    CustomDiferencialTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    [cell setStacox: self];
    EylerMethodViewController *e = [[EylerMethodViewController alloc] init];
    for(int i = 0; i <= e.numberOfN; ++i) {
        for(int j = 0; j <= e.numberOfN - i; ++j) {
            self.aValue = [self.dic valueForKey: [NSString stringWithFormat: @"a%d%d",i, j]];
        }
    }
    //NSLog(@"-->%@", self.aValue);
    [cell updateCell:indexPath.row aValue: self.aValue];
    return cell;
}

#pragma mark - Hide keyboard when touching in the background
- (void)handleSingleTap:(UITapGestureRecognizer *) sender {
    [self.view endEditing:YES];
}

-(void)hideKeyboardWhenTouchingBackground {
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

-(void)keyboardShown:(NSNotification*) notification {
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

-(void)saveValue:(NSString *) labelTextA keyA:(NSString *)key {
    [self.dic setValue: labelTextA forKey: key];
    //    NSLog(@"%@",self.dic);
}

#pragma mark -Counting Eyler
-(NSInteger)countEyler{
    for(int i = 1; i < self.numberOfN + 1; ++i) {
        NSNumber *current = @(self.x0Value.text.doubleValue + (i * self.hValue.text.doubleValue));
        [self.arrayOfXValues insertObject:current atIndex:i];
//        [self.arrayOfXValues addObject:current];
                                        NSLog(@"%@", self.arrayOfXValues[i]);
    }
    
    for(int k = 0; k < self.numberOfN; ++k) {
//        [self.arrayOfFValues insertObject:0 atIndex:k];

//        self.arrayOfFValues[k] = 0;
        for(int i = 0, p = 0; i < self.numberOfN + 1; ++i) {
            for(int j = 0; j < self.numberOfN - i + 1; ++j, ++p) {
              //  NSNumber *current = pow([self.arrayOfXValues objectAtIndex:k], i);//([self.arrayOfXValues objectAtIndex:k], i);// * pow(yArr[k], j
                
//                [self.arrayOfFValues insertObject:0 atIndex:k];
          //      fArr[k] += a[p] * pow(xArr[k],i) * pow(yArr[k], j);
            }
        }
        if(0 != k) {
    //        yArr[k] = yArr[k - 1] + (h * fArr[k - 1]);
        }
    }
    return 1 ;
}

/*
#pragma mark - UIAlertView
-(IBAction)Alert{
    NSInteger m = [self countEyler];
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
*/

@end
