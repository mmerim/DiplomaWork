//
//  NewtoniBanadzevViewController.m
//  DiplomaWork
//
//  Created by Meri on 12/6/16.
//  Copyright © 2016 Meri. All rights reserved.
//

#import "NewtoniBanadzevViewController.h"
#import "CustomTableViewCell.h"


@interface NewtoniBanadzevViewController () <UIPickerViewDataSource,UIPickerViewDelegate, UITextViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIPickerView *pickerView;
@property (weak, nonatomic) IBOutlet UITextField *valueForCount; //x
@property (weak, nonatomic) IBOutlet UIButton *hashvelButton;

@property(weak, nonatomic) NSMutableArray *arrayOfXLebles;
@property (assign, nonatomic) NSInteger numberOfN;
@property(strong, nonatomic) NSMutableDictionary *dic;
@property(strong, nonatomic) NSString *xValue;
@property(strong, nonatomic) NSString *yValue;

@end

@implementation NewtoniBanadzevViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"Math-1.png"]];
    self.navigationItem.title = @"Նյուտոնի ինտերպոլացիոն բանաձեւ";
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
    return self.numberOfN + 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CustomTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    [cell setStacox: self];
    self.xValue = [self.dic valueForKey: [NSString stringWithFormat: @"X%ld",(long)indexPath.row]];
    self.yValue = [self.dic valueForKey: [NSString stringWithFormat: @"Y%ld",(long)indexPath.row]];
    [cell updateCell:indexPath.row xValue: self.xValue yValue: self.yValue];
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

#pragma mark -Counting Newton

/*
float NewtonFunc(int n, float *x, float* y, float a) {
    float sum = 0;
    for(int j = 0; j < n-1; ++j) {
        for(int i = n-1; i > j; --i) {
            y[i] = (y[i] - y[i-1]) / (x[i] - x[i-j-1]);
        }
    }
    for(int i = n-1; i >= 0; --i) {
        float mult = 1;
        for(int j = 0; j < i; ++j)
            mult*=(a-x[j]);
        
        mult *= y[i];
        sum += mult;
    }
    return sum;
}
*/
-(double)countNewton{
    double sum = 0;
    
    for (int j = 0; j < self.numberOfN; ++j) {
        for (int i = (int)self.numberOfN-1; i > j; --i) {
//            y[i] = (y[i] - y[i-1]) / (x[i] - x[i-j-1]);
            NSString *yIKey = [NSString stringWithFormat: @"Y%ld",(long)i];
            NSInteger yI = [[self.dic valueForKey: yIKey] integerValue];
            NSString *yIKey1 = [NSString stringWithFormat: @"Y%ld",(long)i-1];
            NSInteger yI1 = [[self.dic valueForKey: yIKey1] integerValue];
    NSLog(@"yi=%ld   yi-1=%ld  ",(long)yI, (long)yI1);
            NSString *xIKey = [NSString stringWithFormat: @"X%ld",(long)i];
            NSInteger xI = [[self.dic valueForKey: xIKey] integerValue];
            NSString *xIKey1 = [NSString stringWithFormat: @"X%ld",(long)i-j-1];
            NSInteger xI1 = [[self.dic valueForKey: xIKey1] integerValue];
    NSLog(@"xi=%ld   xi-1=%ld  ",(long)xI, (long)xI1);

            yI = (yI - yI1) / (xI - xI1);
        NSLog(@"yi=%ld   yi-1=%ld  ",(long)yI, (long)yI1);

        }
    }
    for(int i = (int)self.numberOfN; i >= 0; --i) {
        double mult = 1;
        for(int j = 0; j < i; ++j){
            NSString *xJKey = [NSString stringWithFormat: @"X%ld",(long)j];
            NSInteger xJ = [[self.dic valueForKey: xJKey] integerValue];
            mult*=(self.valueForCount.text.integerValue - xJ);
        
            NSString *yIKey = [NSString stringWithFormat: @"Y%ld",(long)i];
            NSInteger yI = [[self.dic valueForKey: yIKey] integerValue];
            mult *= yI;
            sum += mult;
        }
    }
    return sum;
}

#pragma mark - UIAlertView
-(IBAction)Alert{
    double m = [self countNewton];
    NSLog(@"%f", m);
    NSString *inStr = [NSString stringWithFormat: @"%f", m];
    
    UIAlertController * alert = [UIAlertController
                                 alertControllerWithTitle:@"Նյուտոնի ինտերպոլացիոն բանաձեւի արդյունքը՝"                                 message:inStr
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
