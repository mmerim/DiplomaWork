//
//  ErkuPopFuncUIViewController.m
//  DiplomaWork
//
//  Created by Meri on 12/7/16.
//  Copyright © 2016 Meri. All rights reserved.
//

#import "ErkuPopFuncUIViewController.h"


@interface ErkuPopFuncUIViewController () <UIPickerViewDataSource,UIPickerViewDelegate, UITextViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (weak, nonatomic) IBOutlet UITextField *xValueTF;
@property (weak, nonatomic) IBOutlet UITextField *yValueTF;
@property (weak, nonatomic) IBOutlet UITextField *tValueTF;
@property (weak, nonatomic) IBOutlet UITextField *hValueTF;

@property (weak, nonatomic) IBOutlet UIPickerView *nPickerView;
@property (weak, nonatomic) IBOutlet UIPickerView *mPickerView;

@property (weak, nonatomic) IBOutlet UIButton *HashvelButton;

@property (assign, nonatomic) NSInteger numberOfN;
@property (assign, nonatomic) NSInteger numberOfM;

@property(strong, nonatomic) NSString *zValue;

@property(strong, nonatomic) NSMutableDictionary *dic;

@property(strong, nonatomic) NSMutableArray *arrayX;
@property(strong, nonatomic) NSMutableArray *arrayY;


@end

@implementation ErkuPopFuncUIViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"Math-1.png"]];
    self.navigationItem.title = @"Երկու փոփոխականի ֆունկցիայի ինտերպոլացիոն բանաձեւ";
    [self.HashvelButton setTitle:@"Հաշվել" forState:
     UIControlStateNormal];
    
    self.numberOfN = 1;
    
    [self hideKeyboardWhenTouchingBackground];
    self.dic = [[NSMutableDictionary alloc]init];
    self.arrayX = [[NSMutableArray alloc] init];
    self.arrayY = [[NSMutableArray alloc] init];
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
        [self.xValueTF setText: @""];
        [self.yValueTF setText: @""];
        [self.hValueTF setText: @""];
        [self.tValueTF setText: @""];
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

- (NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if (1 == pickerView.tag) {
        return  [NSString stringWithFormat:@"%ld",(long)row+1];
    }
    return  [NSString stringWithFormat:@"%ld",(long)row + 1];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger) component {
    if (1 == pickerView.tag) {
        NSLog(@"row n %ld", (long)row);
        self.numberOfN = row + 1;
    }
    if (2 == pickerView.tag) {
        NSLog(@"row m %ld", (long)row);
        self.numberOfM = row + 1;
    }
    [self.tableView reloadData];
}



#pragma mark - TableView
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.numberOfN * self.numberOfM;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CustomTableViewCellErkuPop *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    [cell setStacox: self];
    self.zValue = [self.dic valueForKey: [NSString stringWithFormat: @"Y%ld",(long)indexPath.row]];
    NSLog(@"-->%@", self.zValue);
    [cell updateCell:indexPath.row zValue: self.zValue];
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

-(void)saveValue:(NSString *) labelTextZ keyZ:(NSString *)key {
    [self.dic setValue: labelTextZ forKey: key];
//    [self.dic setValue: labelTextY forKey: key1];
        NSLog(@"--%@",self.dic);
}

#pragma mark -Counting Erku popoxakani funkciayi interpolacia
-(double)countLagrangexValue:(NSNumber *)value{
    double sum = 0;
    for (int i = 0; i <= self.numberOfN; ++i) {
        double mult = 1;
        for (int j  = 0; j <= self.numberOfN; ++j) {
            NSString *xIKey = [NSString stringWithFormat: @"X%ld",(long)i];
            NSInteger xI = [[self.dic valueForKey: xIKey] integerValue];
            
            NSString *xJKey = [NSString stringWithFormat: @"X%ld",(long)j];
            NSInteger xJ = [[self.dic valueForKey: xJKey] integerValue];
            
            if (j != i) {
                mult *= (double)(value.integerValue - xJ) / (xI - xJ);
            }
        }
        NSString *yIKey = [NSString stringWithFormat: @"Y%ld",(long)i];
        NSInteger yI = [[self.dic valueForKey: yIKey] integerValue];
        sum += (mult * yI);
    }
    return sum;
}

-(NSInteger)countErkuPopoxakan{
    
    //arrayX arrayY
    for (int i = 0; i < self.numberOfN; ++i) {
        [self.arrayX addObject:[NSNumber numberWithDouble:self.xValueTF.text.doubleValue + (i * self.hValueTF.text.doubleValue)]];
    }
    for (int i = 0; i < self.numberOfM; ++i) {
        [self.arrayY addObject:[NSNumber numberWithDouble:self.yValueTF.text.doubleValue + (i * self.tValueTF.text.doubleValue)]];
    }
    
    NSInteger sum = 0;
    for (int i = 0; i < self.numberOfN; ++i) {
        NSInteger mult1 = 1, mult2 = 1;
        for (int j = 0; j < self.numberOfM; ++j) {
            
            NSString *xIKey = [NSString stringWithFormat: @"X%ld",(long)i];
            NSInteger xI = [[self.dic valueForKey: xIKey] integerValue];
            NSString *xJKey = [NSString stringWithFormat: @"X%ld",(long)j];
            NSInteger xJ = [[self.dic valueForKey: xJKey] integerValue];
            
            
            
            if (j != i) {
//                mult *= (self.valueForCount.text.integerValue - xJ) / (xI - xJ);
//                NSLog(@"%ld", (long)mult);
            }
        }
    NSString *zIKey = [NSString stringWithFormat: @"Z%ld",(long)i];
    NSInteger xI = [[self.dic valueForKey: zIKey] integerValue];

    for (int i = 1; i < self.numberOfN; ++i) {
    }
    for (int j = 0; j < self.numberOfN; ++j) {
        for (int i = (int)self.numberOfN-1; i > j; --i) {
            NSString *xIKey = [NSString stringWithFormat: @"X%ld",(long)i];
            NSInteger xI = [[self.dic valueForKey: xIKey] integerValue];
            NSString *xIKey1 = [NSString stringWithFormat: @"X%ld",(long)i-j-1];
            NSInteger xI1 = [[self.dic valueForKey: xIKey1] integerValue];
        }
    }
    for(int i = (int)self.numberOfN; i >= 0; --i) {
        NSInteger mult = 1;
        for(int j = 0; j < i; ++j){
            NSString *yIKey = [NSString stringWithFormat: @"Y%ld",(long)i];
            NSInteger yI = [[self.dic valueForKey: yIKey] integerValue];
            mult *= yI;
            sum += mult;
        }
    }}
    return sum;
}

#pragma mark - UIAlertView
-(IBAction)Alert{
    NSInteger m = [self countErkuPopoxakan];
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
    [alert addAction:yesButton];
    
    [self presentViewController:alert animated:YES completion:nil];
}

@end
