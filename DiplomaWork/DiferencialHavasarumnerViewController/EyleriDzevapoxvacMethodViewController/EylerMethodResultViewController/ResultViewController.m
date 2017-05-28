//
//  ResultViewController.m
//  DiplomaWork
//
//  Created by Meri on 5/14/17.
//  Copyright © 2017 Meri. All rights reserved.
//

#import "ResultViewController.h"
#import "ResultTableViewCell.h"

@interface ResultViewController()<UITextViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (weak, nonatomic) IBOutlet UITableView *resultTableView;
@property(retain, nonatomic) NSMutableArray *arrayOfXValues;
@property(retain, nonatomic) NSMutableArray *arrayOfYValues;
@property(nonatomic) NSInteger n;

@end

@implementation ResultViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (!self.arrayOfXValues)
        self.arrayOfXValues = [[NSMutableArray alloc] init];
    if (!self.arrayOfYValues)
        self.arrayOfYValues = [[NSMutableArray alloc] init];
    
    

    
//        self.arrayOfXValues = [[NSMutableArray alloc] initWithObjects: @"adsfadsf",@"dddd", @"adsfadsf",@"dddd", @"adsfadsf",@"dddd",nil];
//        self.arrayOfYValues = [[NSMutableArray alloc] initWithObjects: @"1111",@"2222", @"3333",@"4444", @"5555",@"6666",nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDataSource

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView  {
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.n;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ResultTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: @"result" forIndexPath: indexPath];
    NSNumber *x = [self.arrayOfXValues objectAtIndex:indexPath.row];
    NSNumber *y = [self.arrayOfYValues objectAtIndex:indexPath.row];
    [cell setVvalueID:indexPath.row
                xValue:[NSNumber numberWithDouble:x.doubleValue]
                yValue:[NSNumber numberWithDouble:y.doubleValue]];
    return cell;
}

#pragma mark - UITableViewDelegate

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"%@",indexPath);
}

-(void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath {
}

-(void)showResultX:(NSMutableArray *)xArr Y:(NSMutableArray *)yArr  numberOfN:(NSInteger)n title:(NSString *)title{
    self.navigationItem.title = title;
    NSLog(@"%@   %@", title, self.titleLabel.text );
    self.n = n + 1;
    NSLog(@"%ld", (long)self.n);
    self.arrayOfXValues = xArr;
    self.arrayOfYValues = yArr;
}

@end
