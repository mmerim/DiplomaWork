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
@property (weak, nonatomic) IBOutlet UITextField *valueForCount; //x
@property (weak, nonatomic) IBOutlet UIButton *hashvelButton;

@property(weak, nonatomic) NSMutableArray *arrayOfXLebles;
@property (assign, nonatomic) NSInteger numberOfN;
@property(strong, nonatomic) NSMutableDictionary *dic;
@property(strong, nonatomic) NSString *xValue;
@property(strong, nonatomic) NSString *yValue;

@end

@implementation Lagranji_BanadzevViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.backgroundColor = [UIColor clearColor];
    
//    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"Math-1.png"]];
    
    self.navigationItem.title = @"Լագրանժի ինտերպոլացիոն բանաձեւ";
    
    [self.hashvelButton setTitle:@"Հաշվել" forState:
     UIControlStateNormal];
    self.numberOfN = 1;
    
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
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    if ([textField.text rangeOfCharacterFromSet:[NSCharacterSet letterCharacterSet]].location != NSNotFound) {
        [self.valueForCount setText: @""];
    }
return YES;
}


#pragma mark - PickerView
// The number of columns of data
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}
//
// The number of rows of data
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return 900;
}

- (NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return  [NSString stringWithFormat:@"%ld",(long)row+1];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger) component {
    self.numberOfN = row+1;
    [self.tableView reloadData];
}

//- (NSAttributedString *)pickerView:(UIPickerView *)pickerView attributedTitleForRow:(NSInteger)row forComponent:(NSInteger)component
//{
//    NSString *title = @"sample title";
//    NSAttributedString *attString =
//    [[NSAttributedString alloc] initWithString:title attributes:@{NSForegroundColorAttributeName:[UIColor redColor]}];
//    
//    return attString;
//}

#pragma mark - TableView
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.numberOfN + 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CustomTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    [cell setStacox: self];
    
//    NSLog(@"y-- %@   x--%@", [self.dic valueForKey: [NSString stringWithFormat: @"X%ld",(long)indexPath.row]], [self.dic valueForKey: [NSString stringWithFormat: @"Y%ld",(long)indexPath.row]]);
    
    self.xValue = [self.dic valueForKey: [NSString stringWithFormat: @"X%ld",(long)indexPath.row]];
    self.yValue = [self.dic valueForKey: [NSString stringWithFormat: @"Y%ld",(long)indexPath.row]];
    [cell updateCell:indexPath.row xValue: self.xValue yValue: self.yValue];
    NSLog(@"y-- %@   x--%@", [self.dic valueForKey: [NSString stringWithFormat: @"X%ld",(long)indexPath.row]], [self.dic valueForKey: [NSString stringWithFormat: @"Y%ld",(long)indexPath.row]]);
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
}

#pragma mark -Counting Lagrange
-(double)countLagrange{
    double sum = 0;
    for (int i = 0; i <= self.numberOfN; ++i) {
        double mult = 1;
       for (int j = 0; j <= self.numberOfN; ++j) {
           NSString *xIKey = [NSString stringWithFormat: @"X%ld",(long)i];
           NSInteger xI = [[self.dic valueForKey: xIKey] integerValue];
           NSString *xJKey = [NSString stringWithFormat: @"X%ld",(long)j];
           NSInteger xJ = [[self.dic valueForKey: xJKey] integerValue];
           if (j != i) {
               mult *= (double)(self.valueForCount.text.integerValue - xJ) / (xI - xJ);
           }
       }
        NSString *yIKey = [NSString stringWithFormat: @"Y%ld",(long)i];
        NSInteger yI = [[self.dic valueForKey: yIKey] integerValue];
        sum += (mult * yI);
    }
    return sum;
}

#pragma mark - UIAlertView
-(IBAction)Alert{
    double m = [self countLagrange];
    NSLog(@"%f", m);
    NSString *inStr = [NSString stringWithFormat: @"%f", m];
    
    UIAlertController * alert = [UIAlertController
                                 alertControllerWithTitle:@"Լագրանժի ինտերպոլացիոն բանաձեւի արդյունքը՝"
                                 message:inStr
                                 preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction* yesButton = [UIAlertAction
                                actionWithTitle:@"OK"
                                style:UIAlertActionStyleDefault
                                handler:^(UIAlertAction * action) {
                                }];
    [alert addAction:yesButton];
    
    [self presentViewController:alert animated:YES completion:nil];
}

@end
