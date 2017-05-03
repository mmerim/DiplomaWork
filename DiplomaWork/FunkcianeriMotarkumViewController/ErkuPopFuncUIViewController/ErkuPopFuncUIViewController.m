//
//  ErkuPopFuncUIViewController.m
//  DiplomaWork
//
//  Created by Meri on 12/7/16.
//  Copyright © 2016 Meri. All rights reserved.
//

#import "ErkuPopFuncUIViewController.h"
#import "CustomCellCollectionViewCell.h"


@interface ErkuPopFuncUIViewController ()<UIPickerViewDataSource,UIPickerViewDelegate>

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

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


@end

@implementation ErkuPopFuncUIViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"Math-1.png"]];
    self.navigationItem.title = @"Երկու փոփոխականի ֆունկցիայի ինտերպոլացիոն բանաձեւ";
    [self.HashvelButton setTitle:@"Հաշվել" forState:
     UIControlStateNormal];

    [[self collectionView] setDataSource:self];
    [[self collectionView] setDelegate:self];
    
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
}

-(void)saveValue:(NSString *)labelTextZ keyZ:(NSString *)key {
    [self.dic setValue: labelTextZ forKey: key];
}

//TextField-i parunakutyan stugum
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    if ([textField.text rangeOfCharacterFromSet:[NSCharacterSet letterCharacterSet]].location != NSNotFound) {
        [self.xValueTF setText: @""];
        [self.yValueTF setText: @""];
        [self.tValueTF setText: @""];
        [self.hValueTF setText: @""];
    }
    return YES;
}


#pragma mark - PickerView
// The number of columns of data
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return 900;
}

- (NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return  [NSString stringWithFormat:@"%ld",(long)row+1];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger) component {
    self.numberOfN = row+1;
    //[self.tableView reloadData];
}

#pragma mark - CollectionVew, data source
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return self.numberOfM;
}
//-(NSInteger)collectionView
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.numberOfN;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CustomCellCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath: indexPath];
    [cell setStacox: self];
    self.zValue = [self.dic valueForKey: [NSString stringWithFormat: @"Z%ld%ld",(long)indexPath.row, (long)indexPath.row]];
    [cell updateCell:indexPath.row zValue: self.zValue];
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"%@",indexPath);
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
//    CGSize keyboardSize = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    
    [UIView animateWithDuration:animationDuration animations:^{
//        self.tableView.contentInset = UIEdgeInsetsMake(0.0, 0.0, keyboardSize.height, 0.0);
//        self.tableView.scrollIndicatorInsets = UIEdgeInsetsMake(0.0, 0.0, keyboardSize.height, 0.0);
    }];
    
    
}

-(void)keyboardHidden:(NSNotification*)notification {
    double animationDuration = [[[notification userInfo] objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    [UIView animateWithDuration:animationDuration
                     animations:^{
//                         self.tableView.contentInset = UIEdgeInsetsZero;
//                         self.tableView.scrollIndicatorInsets =UIEdgeInsetsZero;
                     }];
}
-(void)saveValue:(NSString *) labelTextX keyX:(NSString *)key saveValue:(NSString *) labelTextY keyY:(NSString *)key1{
//    [self.dic setValue: labelTextX forKey: key];
//    [self.dic setValue: labelTextY forKey: key1];
    
    //    NSLog(@"%@",self.dic);
}

#pragma mark -Counting Erku popoxakani funkciayi interpolacia
-(NSInteger)countNewton{
    NSInteger sum = 0;
    NSMutableArray * xArray = [NSMutableArray array];
    
//    //counting x and y
    for (int i = 1; i < self.numberOfN; ++i) {
        xArray[i] = self.xValueTF.text;// + i;*(int)self.hValueTF.text;
    }
//    for (int i = 1; i < m; ++i) {
//        y[i] = y[0] + i*t;
//    }

    
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
        NSInteger mult = 1;
        for(int j = 0; j < i; ++j){
//            NSString *xJKey = [NSString stringWithFormat: @"X%ld",(long)j];
//            NSInteger xJ = [[self.dic valueForKey: xJKey] integerValue];
//            mult*=(self.valueForCount.text.integerValue - xJ);
            
            NSString *yIKey = [NSString stringWithFormat: @"Y%ld",(long)i];
            NSInteger yI = [[self.dic valueForKey: yIKey] integerValue];
            mult *= yI;
            sum += mult;
        }
    }
    return sum;
}

//#pragma mark - UIAlertView
//-(IBAction)Alert{
//    NSInteger m = [self countNewton];
//    NSLog(@"%ld", (long)m);
//    NSString *inStr = [NSString stringWithFormat: @"%ld", (long)m];
//    
//    UIAlertController * alert = [UIAlertController
//                                 alertControllerWithTitle:@"Sum"
//                                 message:inStr
//                                 preferredStyle:UIAlertControllerStyleAlert];
//    UIAlertAction* yesButton = [UIAlertAction
//                                actionWithTitle:@"OK"
//                                style:UIAlertActionStyleDefault
//                                handler:^(UIAlertAction * action) {
//                                }];
//    //
//    //    UIAlertAction* noButton = [UIAlertAction
//    //                               actionWithTitle:@"No, thanks"
//    //                               style:UIAlertActionStyleDefault
//    //                               handler:^(UIAlertAction * action) {
//    //                                   //Handle no, thanks button
//    //                               }];
//    
//    [alert addAction:yesButton];
//    //    [alert addAction:noButton];
//    
//    [self presentViewController:alert animated:YES completion:nil];
//}
@end
