//
//  MenuViewController.m
//  DiplomaWork
//
//  Created by Meri on 12/3/16.
//  Copyright © 2016 Meri. All rights reserved.
//

#import "MenuViewController.h"

@interface MenuViewController ()

//@property (weak, nonatomic) IBOutlet UINavigationItem *menuNavigationItem;
@property (weak, nonatomic) IBOutlet UIButton *FuncMotarkumButton;
@property (weak, nonatomic) IBOutlet UIButton *IntegrHashvumButton;
@property (weak, nonatomic) IBOutlet UIButton *DifHavasarumnerButton;

@end

@implementation MenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"Math-1.png"]];
    self.navigationItem.title = @"Մենյու";
  
    self.FuncMotarkumButton.titleLabel.numberOfLines =0;
    [self.FuncMotarkumButton.titleLabel setTextAlignment:NSTextAlignmentCenter];
    [self.FuncMotarkumButton setTitle:@"Ֆունկցիաների մոտարկում" forState:UIControlStateNormal];
    
    self.IntegrHashvumButton.titleLabel.numberOfLines =0;
    [self.IntegrHashvumButton.titleLabel setTextAlignment:NSTextAlignmentCenter];
    [self.IntegrHashvumButton setTitle:@"Թվային ինտեգրում" forState:UIControlStateNormal];
    
    self.DifHavasarumnerButton.titleLabel.numberOfLines =0;
    [self.DifHavasarumnerButton.titleLabel setTextAlignment:NSTextAlignmentCenter];
    [self.DifHavasarumnerButton setTitle:@"Դիֆերենցիալ հավասարումներ" forState:UIControlStateNormal];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
